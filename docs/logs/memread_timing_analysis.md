# memRead 时序分析报告 - 2025-11-29 20:22

## 测试结果总结

### 测试 1: LDA memRead 时序 ✅

**文件**: `LDAMemReadTimingSpec.scala`

**结果**:
```
Cycle 0: memRead=1 memAddr=0x1000
Cycle 1: memRead=1 memAddr=0x1000
Cycle 2: memRead=1 memAddr=0x2002 ← PPU 应该在这里响应
Cycle 3: memRead=0 memAddr=0x2002 ← CPU 在这里读取数据
```

**关键发现**: 
- ✅ Cycle 2: memRead=1 (发出读请求)
- ❌ Cycle 3: memRead=0 (CPU 读取数据，但 memRead 已经是 0)

### 测试 2: PPU cpuRead 信号 ✅

**文件**: `PPUReadSignalSpec.scala`

**结果**:
```
Cycle 2: cpuRead=1, cpuAddr=2
[PPU Regs] Read PPUSTATUS: vblank=1, status=0x80, will clear next cycle
PPUSTATUS = 0x80 ✅

Cycle 3: cpuRead=0
VBlank = 0 ✅
```

**关键发现**:
- ✅ PPU 在 Cycle 2 正确响应
- ✅ 返回 PPUSTATUS = 0x80
- ✅ 下一周期清除 VBlank

## 根本原因分析

### 问题定位 🎯

**PPU 单独测试**: ✅ 完全正常
**LDA 指令测试**: ✅ 完全正常
**NES 系统集成**: ❌ 有问题

### 时序不匹配

**LDA 绝对寻址时序**:
```
Cycle 0: 读取地址低字节
Cycle 1: 读取地址高字节
Cycle 2: memRead=1, 发出读请求 ← PPU 应该在这里响应
Cycle 3: memRead=0, CPU 读取 memDataIn ← 但 PPU 需要 memRead=1
```

**问题**: 
- PPU 需要 `cpuRead=1` 才能返回数据
- 但 CPU 在 Cycle 3 时 `memRead=0`
- 导致 PPU 的 `cpuRead` 信号不触发

### NES 系统连接

**NESSystemRefactored.scala**:
```scala
ppu.io.cpuRead := cpu.io.memRead && isPpuReg
```

**问题**:
- Cycle 2: `cpu.io.memRead=1` → `ppu.io.cpuRead=1` ✅
- Cycle 3: `cpu.io.memRead=0` → `ppu.io.cpuRead=0` ❌

但 CPU 在 Cycle 3 才读取 `memDataIn`！

## 解决方案

### 方案 1: PPU 在 Cycle 2 准备数据 ⭐ 推荐

**原理**: PPU 在检测到 `cpuRead=1` 时立即准备数据

**当前实现**: ✅ 已经是这样
```scala
io.cpuDataOut := MuxLookup(io.cpuAddr, 0.U, Seq(
  2.U -> regs.ppuStatus,  // 立即返回
  ...
))
```

**问题**: `regs.ppuStatus` 可能不是最新的

### 方案 2: 使用组合逻辑组装 PPUSTATUS ⭐⭐ 最佳

**原理**: 不使用 `regs.ppuStatus`，直接组装

```scala
// PPURegisterControl.scala
io.cpuDataOut := MuxLookup(io.cpuAddr, 0.U, Seq(
  2.U -> Cat(
    regs.vblank,      // 使用当前值
    regs.sprite0Hit,
    regs.spriteOverflow,
    0.U(5.W)
  ),
  ...
))

// 不需要 regs.ppuStatus
```

**优点**:
- 立即反映最新状态
- 不需要额外寄存器
- 符合硬件行为

### 方案 3: 延长 memRead 信号

**原理**: CPU 在 Cycle 3 也保持 `memRead=1`

**缺点**: 需要修改 CPU 指令实现

## 推荐修复

### 修改 PPURegisterControl.scala

**移除**:
```scala
// 组装 PPUSTATUS
regs.ppuStatus := Cat(
  regs.vblank,
  regs.sprite0Hit,
  regs.spriteOverflow,
  0.U(5.W)
)
```

**改为**:
```scala
// 读取逻辑 - 使用组合逻辑
io.cpuDataOut := MuxLookup(io.cpuAddr, 0.U, Seq(
  2.U -> Cat(
    regs.vblank,      // 直接使用当前值
    regs.sprite0Hit,
    regs.spriteOverflow,
    0.U(5.W)
  ),
  4.U -> 0.U,
  7.U -> regs.ppuData
))
```

**保留延迟清除**:
```scala
val clearVBlankNext = RegInit(false.B)

when(io.cpuRead && io.cpuAddr === 2.U) {
  clearVBlankNext := true.B
}.otherwise {
  clearVBlankNext := false.B
}

when(clearVBlankNext) {
  regs.vblank := false.B
}
```

## 验证测试

### 测试 1: PPUStatusReadTimingSpec
```bash
sbt "testOnly integration.PPUStatusReadTimingSpec"
```

**期望**: 4/4 通过

### 测试 2: WaitLoopSpec
```bash
sbt "testOnly integration.WaitLoopSpec"
```

**期望**: 2/2 通过

### 测试 3: 完整测试
```bash
sbt test
```

**期望**: 所有测试通过

## 时间线

- 20:03: 接受任务
- 20:05: 创建 PPUStatusReadTimingSpec (失败)
- 20:12: 研发主程实施方案 1
- 20:21: 创建 LDAMemReadTimingSpec (通过)
- 20:22: 创建 PPUReadSignalSpec (通过)
- 20:23: 定位根本原因

**总用时**: 20 分钟

## 下一步

1. 研发主程实施方案 2 (组合逻辑)
2. 运行所有测试验证
3. 如果通过，测试 Verilator 仿真
4. 验证游戏是否能跳出循环

---

**状态**: 🟢 根本原因已定位  
**建议**: 使用组合逻辑组装 PPUSTATUS
