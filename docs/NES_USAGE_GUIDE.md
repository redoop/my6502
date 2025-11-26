# 🎮 NES 系统使用指南

## 📚 目录

1. [快速开始](#快速开始)
2. [系统架构](#系统架构)
3. [ROM 加载](#rom-加载)
4. [PPU 使用](#ppu-使用)
5. [CPU 编程](#cpu-编程)
6. [APU 音频](#apu-音频)
7. [调试技巧](#调试技巧)

## 快速开始

### 运行测试

```bash
# 运行所有 NES 测试
sbt "testOnly nes.*"

# 运行特定测试
sbt "testOnly nes.NESSystemv2Test"
sbt "testOnly nes.ContraQuickTest"
```

### 创建 NES 系统实例

```scala
import nes._
import chisel3._
import chiseltest._

test(new NESSystemv2) { dut =>
  // 配置 Mapper
  dut.io.mapperType.poke(4.U)  // MMC3
  
  // 初始化控制器
  dut.io.controller1.poke(0.U)
  dut.io.controller2.poke(0.U)
  
  // 运行系统
  dut.clock.step(100)
}
```

## 系统架构

### 组件概览

```
NESSystemv2
├── CPU6502Refactored
│   └── CPU6502Core
├── PPUv2
│   ├── VRAM (2KB)
│   ├── OAM (256B)
│   └── Palette (32B)
├── MMC3Mapper
└── Memory
    ├── PRG ROM (512KB max)
    └── CHR ROM (256KB max)
```

### 内存映射

#### CPU 地址空间
```
$0000-$07FF: Internal RAM (2KB)
$0800-$1FFF: RAM Mirrors
$2000-$2007: PPU Registers
$2008-$3FFF: PPU Mirrors
$4000-$4017: APU and I/O
$8000-$FFFF: Cartridge (PRG ROM)
```

#### PPU 地址空间
```
$0000-$1FFF: Pattern Tables (CHR ROM)
$2000-$2FFF: Nametables (VRAM)
$3000-$3EFF: Nametable Mirrors
$3F00-$3F1F: Palette RAM
$3F20-$3FFF: Palette Mirrors
```

## ROM 加载

### 使用 ROMLoader

```scala
import nes.ROMLoader

// 加载 ROM 文件
val rom = ROMLoader.loadNESROM("path/to/game.nes")

println(s"Mapper: ${rom.mapper}")
println(s"PRG ROM: ${rom.prgROM.length} bytes")
println(s"CHR ROM: ${rom.chrROM.length} bytes")
```

### 加载到 NES 系统

```scala
test(new NESSystemv2) { dut =>
  val rom = ROMLoader.loadNESROM("game.nes")
  
  // 配置 Mapper
  dut.io.mapperType.poke(rom.mapper.U)
  
  // 加载 PRG ROM
  dut.io.romLoadPRG.poke(true.B)
  for (i <- 0 until rom.prgROM.length) {
    dut.io.romLoadEn.poke(true.B)
    dut.io.romLoadAddr.poke(i.U)
    dut.io.romLoadData.poke((rom.prgROM(i) & 0xFF).U)
    dut.clock.step(1)
  }
  
  // 加载 CHR ROM
  dut.io.romLoadPRG.poke(false.B)
  for (i <- 0 until rom.chrROM.length) {
    dut.io.romLoadEn.poke(true.B)
    dut.io.romLoadAddr.poke(i.U)
    dut.io.romLoadData.poke((rom.chrROM(i) & 0xFF).U)
    dut.clock.step(1)
  }
  
  // 完成加载
  dut.io.romLoadEn.poke(false.B)
}
```

## PPU 使用

### 读取 PPU 寄存器

```scala
// 读取 PPUSTATUS
dut.io.cpuAddr.poke(2.U)  // PPUSTATUS = $2002
dut.io.cpuRead.poke(true.B)
dut.clock.step(1)
val status = dut.io.cpuDataOut.peek()
dut.io.cpuRead.poke(false.B)

// 检查 VBlank
val vblank = (status.litValue & 0x80) != 0
```

### 写入 PPU 寄存器

```scala
// 启用 NMI
dut.io.cpuAddr.poke(0.U)  // PPUCTRL = $2000
dut.io.cpuDataIn.poke(0x80.U)  // Bit 7 = NMI enable
dut.io.cpuWrite.poke(true.B)
dut.clock.step(1)
dut.io.cpuWrite.poke(false.B)

// 启用渲染
dut.io.cpuAddr.poke(1.U)  // PPUMASK = $2001
dut.io.cpuDataIn.poke(0x1E.U)  // Show BG and sprites
dut.io.cpuWrite.poke(true.B)
dut.clock.step(1)
dut.io.cpuWrite.poke(false.B)
```

### 写入 VRAM

```scala
// 设置 VRAM 地址
dut.io.cpuAddr.poke(6.U)  // PPUADDR = $2006

// 写入高字节
dut.io.cpuDataIn.poke(0x20.U)
dut.io.cpuWrite.poke(true.B)
dut.clock.step(1)

// 写入低字节
dut.io.cpuDataIn.poke(0x00.U)
dut.clock.step(1)
dut.io.cpuWrite.poke(false.B)

// 写入数据
dut.io.cpuAddr.poke(7.U)  // PPUDATA = $2007
dut.io.cpuDataIn.poke(0x01.U)  // Tile index
dut.io.cpuWrite.poke(true.B)
dut.clock.step(1)
dut.io.cpuWrite.poke(false.B)
```

### 等待 VBlank

```scala
// 等待 VBlank 开始
var vblankSeen = false
var cycles = 0
while (!vblankSeen && cycles < 100000) {
  dut.clock.step(1)
  cycles += 1
  if (dut.io.vblank.peek().litToBoolean) {
    vblankSeen = true
  }
}
```

### 读取视频输出

```scala
// 捕获一帧
val frame = Array.ofDim[Int](256, 240)

for (y <- 0 until 240) {
  for (x <- 0 until 256) {
    // 等待到达正确的像素位置
    while (dut.io.pixelX.peek().litValue != x ||
           dut.io.pixelY.peek().litValue != y) {
      dut.clock.step(1)
    }
    
    // 读取颜色
    frame(x)(y) = dut.io.pixelColor.peek().litValue.toInt
  }
}
```

## CPU 编程

### 写入程序到内存

```scala
// 简单的程序: LDA #$10, INX, TAX
val program = Array[Byte](
  0xA9.toByte, 0x10.toByte,  // LDA #$10
  0xE8.toByte,               // INX
  0xAA.toByte                // TAX
)

// 写入到 $8000
for (i <- program.indices) {
  // 通过内存接口写入
  // (具体实现取决于系统配置)
}
```

### 设置 Reset Vector

```scala
// Reset Vector 在 $FFFC-$FFFD
// 指向程序起始地址 $8000

// 写入低字节
writeMemory(0xFFFC, 0x00)

// 写入高字节
writeMemory(0xFFFD, 0x80)
```

### 读取 CPU 状态

```scala
// 读取调试信息
val pc = dut.io.debug.regPC.peek().litValue
val a = dut.io.debug.regA.peek().litValue
val x = dut.io.debug.regX.peek().litValue
val y = dut.io.debug.regY.peek().litValue
val sp = dut.io.debug.regSP.peek().litValue
val flags = dut.io.debug.regP.peek().litValue

println(f"PC: 0x$pc%04X")
println(f"A:  0x$a%02X")
println(f"X:  0x$x%02X")
println(f"Y:  0x$y%02X")
println(f"SP: 0x$sp%02X")
println(f"P:  0x$flags%02X")
```

## APU 音频

### 启用音频通道

```scala
test(new APU) { dut =>
  // 启用 Pulse 1
  dut.io.cpuAddr.poke(0x15.U)  // Status register
  dut.io.cpuDataIn.poke(0x01.U)  // Enable Pulse 1
  dut.io.cpuWrite.poke(true.B)
  dut.clock.step(1)
  dut.io.cpuWrite.poke(false.B)
}
```

### 设置音量和频率

```scala
// 设置 Pulse 1 音量
dut.io.cpuAddr.poke(0x00.U)
dut.io.cpuDataIn.poke(0x0F.U)  // Max volume
dut.io.cpuWrite.poke(true.B)
dut.clock.step(1)
dut.io.cpuWrite.poke(false.B)

// 设置频率 (低字节)
dut.io.cpuAddr.poke(0x02.U)
dut.io.cpuDataIn.poke(0x00.U)
dut.io.cpuWrite.poke(true.B)
dut.clock.step(1)

// 设置频率 (高字节)
dut.io.cpuAddr.poke(0x03.U)
dut.io.cpuDataIn.poke(0x04.U)
dut.io.cpuWrite.poke(true.B)
dut.clock.step(1)
dut.io.cpuWrite.poke(false.B)
```

### 读取音频输出

```scala
// 等待音频样本
while (!dut.io.audioValid.peek().litToBoolean) {
  dut.clock.step(1)
}

// 读取样本
val sample = dut.io.audioOut.peek().litValue
```

## 调试技巧

### 使用 ContraSystem

```scala
test(new ContraSystem) { dut =>
  // 模拟按钮按下
  dut.io.controller.a.poke(true.B)
  dut.io.controller.start.poke(true.B)
  dut.clock.step(10)
  
  // 释放按钮
  dut.io.controller.a.poke(false.B)
  dut.io.controller.start.poke(false.B)
  
  // 检查 CPU 状态
  println(f"PC: 0x${dut.io.debug.regPC.peek().litValue}%04X")
}
```

### 跟踪执行

```scala
// 单步执行并打印状态
for (i <- 0 until 100) {
  val pc = dut.io.debug.regPC.peek().litValue
  val a = dut.io.debug.regA.peek().litValue
  
  println(f"[$i] PC: 0x$pc%04X, A: 0x$a%02X")
  
  dut.clock.step(1)
}
```

### 检查 VBlank 时序

```scala
var lastVBlank = false
var vblankCount = 0

for (i <- 0 until 200000) {
  val vblank = dut.io.vblank.peek().litToBoolean
  
  if (vblank && !lastVBlank) {
    vblankCount += 1
    val x = dut.io.pixelX.peek().litValue
    val y = dut.io.pixelY.peek().litValue
    println(f"VBlank #$vblankCount at cycle $i, pos ($x, $y)")
  }
  
  lastVBlank = vblank
  dut.clock.step(1)
}
```

### 验证内存访问

```scala
// 写入测试数据
val testAddr = 0x0200.U
val testData = 0x42.U

// 写入
dut.io.memAddr.poke(testAddr)
dut.io.memDataOut.poke(testData)
dut.io.memWrite.poke(true.B)
dut.clock.step(1)
dut.io.memWrite.poke(false.B)

// 读取
dut.io.memAddr.poke(testAddr)
dut.io.memRead.poke(true.B)
dut.clock.step(1)
val readData = dut.io.memDataIn.peek()
dut.io.memRead.poke(false.B)

assert(readData.litValue == testData.litValue)
```

## 常见问题

### Q: 为什么 CPU 不执行？

A: 检查 Reset Vector 是否正确设置：
```scala
// Reset Vector 应该指向有效的程序地址
// 在 $FFFC-$FFFD
```

### Q: 为什么看不到渲染输出？

A: 确保启用了渲染：
```scala
// PPUMASK bit 3 = show background
// PPUMASK bit 4 = show sprites
dut.io.cpuAddr.poke(1.U)
dut.io.cpuDataIn.poke(0x18.U)
dut.io.cpuWrite.poke(true.B)
```

### Q: 如何调试 Mapper 问题？

A: 检查 bank switching：
```scala
// 写入 Mapper 寄存器
// MMC3: $8000-$9FFF, $A000-$BFFF, etc.
```

### Q: VBlank 不触发？

A: 确保运行足够的周期：
```scala
// 一帧 = 262 扫描线 × 341 像素 = 89342 周期
dut.clock.step(90000)
```

## 性能优化

### 减少测试时间

```scala
// 使用 setTimeout(0) 禁用超时
dut.clock.setTimeout(0)

// 只运行必要的周期
val cyclesPerFrame = 89342
dut.clock.step(cyclesPerFrame)
```

### 批量内存访问

```scala
// 使用循环批量加载
for (i <- 0 until data.length by 16) {
  // 加载 16 字节
  for (j <- 0 until 16 if i + j < data.length) {
    loadByte(i + j, data(i + j))
  }
}
```

## 参考资料

- [NesDev Wiki](https://www.nesdev.org/wiki/)
- [6502 Instruction Set](http://www.6502.org/tutorials/6502opcodes.html)
- [PPU Registers](https://www.nesdev.org/wiki/PPU_registers)
- [APU Registers](https://www.nesdev.org/wiki/APU)
- [MMC3 Mapper](https://www.nesdev.org/wiki/MMC3)

---

**版本**: 1.0
**最后更新**: 2025-11-27
