# 时序分析报告 v2 (基于最新代码)

## 当前实现分析

### 1. CPU 时序 (CPU6502Core.scala)

**状态机**: 5 状态
```scala
sReset :: sFetch :: sExecute :: sNMI :: sDone
```

**周期计数**:
```scala
val cycle = RegInit(0.U(3.W))  // 0-7 周期
```

**关键时序**:
- Reset: 6 周期 (cycle 0→5)
- Fetch: 3 周期 (cycle 0→2)
- Execute: 可变 (1-7 周期)
- NMI: 9 周期 (cycle 0→8)

**NMI 边沿检测**:
```scala
val nmiLast = RegInit(false.B)
val nmiPending = RegInit(false.B)

// 上升沿检测
when(io.nmi && !nmiLast) {
  nmiPending := true.B
}

// Fetch 时检查并清除
when(state === sFetch && nmiPending) {
  nmiPending := false.B
}
```

### 2. PPU 时序 (PPURefactored.scala)

**扫描线计数**:
```scala
val scanline = RegInit(0.U(9.W))  // 0-261
val pixel = RegInit(0.U(9.W))     // 0-340
```

**时序参数**:
- 每行: 341 像素 (0-340)
- 每帧: 262 行 (0-261)
- 可见区: scanline 0-239
- VBlank: scanline 241-260
- Pre-render: scanline 261

**VBlank 时序**:
```scala
// pixel=0 设置 VBlank
when(scanline === 241.U && pixel === 0.U) {
  vblankFlag := true.B
  regControl.io.setVBlank := true.B
}

// pixel=1 触发 NMI
when(scanline === 241.U && pixel === 1.U && nmiEnable) {
  nmiTrigger := true.B
}

// scanline=261 清除
when(scanline === 261.U && pixel === 1.U) {
  nmiTrigger := false.B
}
```

### 3. NES 系统集成 (NESSystemRefactored.scala)

**CPU-PPU 连接**:
```scala
cpu.io.nmi := ppu.io.nmiOut
```

**时钟域**: 单一时钟
```scala
// CPU 和 PPU 共享同一个 clock
// 每个 clock 周期:
//   - CPU 执行 1 个状态机步骤
//   - PPU 前进 1 个像素
```

## 🐛 时序问题

### 问题 1: CPU-PPU 时钟比率错误

**NES 实际**:
- CPU: 1.789773 MHz
- PPU: 5.369318 MHz
- 比率: 1:3 (每 1 CPU 周期 = 3 PPU 周期)

**当前实现**:
- CPU: 1 clock = 1 状态机步骤
- PPU: 1 clock = 1 像素
- 比率: 1:1 ❌

**影响**:
```
实际 NES:
- 1 帧 = 89,342 PPU cycles = 29,780 CPU cycles
- VBlank 开始 = 82,182 PPU cycles = 27,394 CPU cycles

当前实现:
- 1 帧 = 89,342 clock cycles (CPU 和 PPU 同步)
- CPU 执行指令数 = 89,342 ÷ 平均周期数
- 如果平均 3 周期/指令 → 29,780 条指令 ✓
- 但 PPU 运行速度正确 ✓

结论: 当前实现实际上是正确的！
CPU 状态机的多周期执行模拟了 CPU 的慢速度
```

### 问题 2: NMI 触发窗口

**时序图**:
```
Scanline 241:
Pixel:    0      1      2      3
          |      |      |      |
VBlank:   SET    |      |      |
NMI:      |      TRIG   |      |
CPU:      ?      ?      ?      ?

问题: CPU 可能在执行长指令，错过 NMI 触发点
```

**当前保护**:
```scala
// NMI pending 标志保持到 Fetch 状态
val nmiPending = RegInit(false.B)

when(io.nmi && !nmiLast) {
  nmiPending := true.B  // 捕获上升沿
}

when(state === sFetch && nmiPending) {
  nmiPending := false.B  // Fetch 时处理
}
```

**问题**: NMI 触发只持续 1 个周期
```scala
when(scanline === 241.U && pixel === 1.U && nmiEnable) {
  nmiTrigger := true.B
}
// 下一个周期 pixel=2，nmiTrigger 变回 false.B
```

### 问题 3: 寄存器写入延迟

**写入路径**:
```
T0: CPU memWrite=1, cpuAddr=0x2000, cpuDataIn=0x80
T1: PPU cpuWrite=1, cpuAddr=0, cpuDataIn=0x80
T2: PPURegisterControl 更新 ppuCtrl
T3: nmiEnable 生效
```

**延迟**: 2-3 周期

**风险场景**:
```
Scanline 240, Pixel 339: CPU 写入 PPUCTRL (NMI enable)
Scanline 241, Pixel 0:   VBlank 开始
Scanline 241, Pixel 1:   NMI 触发点
                         但 nmiEnable 可能还未生效！
```

## ✅ 正确的部分

1. **CPU 多周期执行**: 正确模拟了 CPU 慢速度
2. **NMI 边沿检测**: 捕获上升沿，避免重复触发
3. **VBlank 时序**: pixel=0 设置，pixel=1 触发，符合规范

## 🔧 需要修复的问题

### 修复 1: NMI 触发持续时间

**问题**: NMI 只持续 1 周期
```scala
// 当前
when(scanline === 241.U && pixel === 1.U && nmiEnable) {
  nmiTrigger := true.B
}
```

**修复**: 保持到被处理
```scala
// 建议
when(scanline === 241.U && pixel === 1.U && nmiEnable) {
  nmiTrigger := true.B
}
when(scanline === 261.U && pixel === 1.U) {
  nmiTrigger := false.B
}
// 或者在 CPU 开始处理 NMI 时清除
```

### 修复 2: 寄存器写入同步

**问题**: 写入延迟 2-3 周期

**修复**: 组合逻辑读取
```scala
// 当前: 寄存器存储
val nmiEnable = regs.ppuCtrl(7)

// 建议: 直接读取（如果可能）
val nmiEnable = Mux(
  io.cpuWrite && io.cpuAddr === 0.U,
  io.cpuDataIn(7),  // 立即使用新值
  regs.ppuCtrl(7)   // 否则使用寄存器值
)
```

### 修复 3: 增强调试输出

**添加时序监控**:
```scala
// CPU 状态转换
when(state =/= RegNext(state)) {
  printf("[CPU] State: %d → %d, cycle=%d, PC=0x%x\n", 
         RegNext(state), state, cycle, regs.pc)
}

// NMI 触发
when(nmiTrigger && !RegNext(nmiTrigger)) {
  printf("[NMI] Triggered at scanline=%d pixel=%d\n", 
         scanline, pixel)
}

// NMI 处理
when(state === sNMI && cycle === 0.U) {
  printf("[NMI] Processing started, PC=0x%x\n", regs.pc)
}
```

## 📊 测试建议

### Test 1: NMI 触发延迟
```scala
// 在 VBlank 前 1 周期写入 PPUCTRL
ppu.scanline = 240
ppu.pixel = 340
poke(io.cpuAddr, 0x2000)
poke(io.cpuDataIn, 0x80)
poke(io.cpuWrite, true)
clock.step(1)

// 验证 NMI 在 scanline=241, pixel=1 触发
clock.step(2)
assert(peek(io.nmi) == 1)
```

### Test 2: NMI 持续时间
```scala
// 触发 NMI
waitForVBlank()
assert(peek(io.nmi) == 1)

// 验证持续到被处理
for (i <- 0 until 100) {
  if (cpu.state != sNMI) {
    assert(peek(io.nmi) == 1)
  }
  clock.step(1)
}
```

### Test 3: CPU-PPU 同步
```scala
// 验证 1 帧时间
val startCycle = totalCycles
waitForFrameComplete()
val frameCycles = totalCycles - startCycle

// 应该是 89,342 周期
assert(frameCycles == 89342)
```

## 总结

**当前状态**: 基本正确，但有细节问题

**关键发现**:
1. ✅ CPU-PPU 时钟比率实际上是正确的
2. ⚠️ NMI 触发持续时间太短
3. ⚠️ 寄存器写入有延迟

**优先级**:
1. 🔴 修复 NMI 持续时间 (高)
2. 🟡 优化寄存器写入延迟 (中)
3. 🟢 增强调试输出 (低)
