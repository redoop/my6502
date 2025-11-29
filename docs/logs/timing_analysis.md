# 时序分析报告

## 问题定位

### 1. CPU-PPU 时钟比率
- **NES 实际**: CPU 1.79 MHz, PPU 5.37 MHz (3:1)
- **当前实现**: CPU 和 PPU 同频率
- **影响**: PPU 运行太慢，VBlank 时序不准确

### 2. NMI 触发窗口
```
PPU Frame: 262 scanlines × 341 pixels = 89,342 PPU cycles
CPU Frame: 89,342 ÷ 3 = 29,780 CPU cycles

NMI 触发点: scanline=241, pixel=1
= 241 × 341 + 1 = 82,182 PPU cycles
= 27,394 CPU cycles
```

### 3. 寄存器写入时序
```
T0: CPU 写入 PPUCTRL (0x2000)
T1: PPU 寄存器更新
T2: NMI enable 生效

问题: 如果在 T0-T2 之间进入 VBlank，NMI 可能丢失
```

## 测试方案

### Test 1: CPU-PPU 周期比率
```scala
// 验证 3:1 时钟比率
for (i <- 0 until 100) {
  clock.step(1)  // 1 CPU cycle
  // 应该产生 3 PPU cycles
  assert(ppu.pixel == (i * 3) % 341)
}
```

### Test 2: NMI 触发精度
```scala
// 设置 NMI enable
poke(io.cpuAddr, 0)
poke(io.cpuDataIn, 0x80)  // NMI enable
poke(io.cpuWrite, true)
clock.step(1)

// 等待 VBlank
while (peek(io.vblank) == 0) {
  clock.step(1)
}

// 验证 NMI 在正确时间触发
assert(ppu.scanline == 241)
assert(ppu.pixel == 1)
```

### Test 3: 寄存器写入延迟
```scala
// 在 VBlank 前 1 周期写入
ppu.scanline = 240
ppu.pixel = 340

poke(io.cpuAddr, 0)
poke(io.cpuDataIn, 0x80)
poke(io.cpuWrite, true)
clock.step(1)

// 验证 NMI 是否触发
clock.step(10)
assert(peek(io.nmi) == 1)
```

## 修复建议

### 方案 1: 添加 PPU 时钟分频
```scala
val ppuClock = RegInit(0.U(2.W))
ppuClock := ppuClock + 1.U

when(ppuClock === 0.U) {
  // PPU 逻辑每 3 个 CPU 周期运行一次
  pixel := pixel + 1.U
}
```

### 方案 2: 寄存器写入缓冲
```scala
val writeBuffer = RegInit(0.U(8.W))
val writeValid = RegInit(false.B)

when(io.cpuWrite) {
  writeBuffer := io.cpuDataIn
  writeValid := true.B
}

when(writeValid) {
  regs.ppuCtrl := writeBuffer
  writeValid := false.B
}
```

### 方案 3: NMI 边沿检测增强
```scala
val nmiLast = RegInit(false.B)
val nmiEdge = !nmiLast && nmiTrigger

nmiLast := nmiTrigger
io.nmi := nmiEdge
```

## 下一步

1. ✅ 创建时序测试套件
2. ⏳ 实现 PPU 时钟分频
3. ⏳ 添加寄存器写入缓冲
4. ⏳ 验证 NMI 触发精度
5. ⏳ 测试实际游戏
