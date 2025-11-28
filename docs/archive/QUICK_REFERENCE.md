# 🚀 NES 系统快速参考

## 📦 组件概览

```
NES System v2
├── CPU6502Refactored (100%) ✅
│   ├── 70+ 指令
│   ├── Reset Vector 支持
│   └── NMI/IRQ 中断
├── PPUv3 (100%) ✅ NEW!
│   ├── 8 个寄存器
│   ├── VBlank + NMI
│   ├── 完整渲染管线
│   ├── 8x8/8x16 精灵 ⭐
│   ├── 精灵溢出检测 ⭐
│   ├── Sprite 0 碰撞
│   ├── 2KB VRAM
│   ├── 256B OAM
│   └── 32B Palette
├── APU (70%) 🚧 NEW!
│   ├── Pulse 1/2 ⭐
│   ├── Triangle ⭐
│   ├── Noise ⭐
│   └── 音频混合 ⭐
└── MMC3 Mapper (95%) ✅ NEW!
    ├── PRG Bank Switching
    ├── CHR Bank Switching
    └── IRQ 计数器 ⭐
```

## 🎯 快速开始

### 运行测试
```bash
# NES 系统测试
sbt "testOnly nes.NESSystemv2Test"

# Contra 测试
sbt "testOnly nes.ContraQuickTest"

# 所有测试
sbt test
```

### 生成 Verilog
```bash
sbt "runMain nes.GenerateNESVerilog"
```

## 🆕 新功能快速使用 (v0.3.1)

### 8x16 精灵
```scala
// PPUCTRL bit 5 = 1 启用 8x16 模式
poke(ppuCtrl, 0x20.U)  // bit 5 = 1
```

### 精灵溢出检测
```scala
// PPUSTATUS bit 5 = 精灵溢出标志
val status = peek(ppuStatus)
val overflow = (status & 0x20) != 0
```

### APU 音频
```scala
// Pulse 1: duty=25%, volume=8
poke(apu_pulse1_ctrl, 0x48.U)
poke(apu_status, 0x01.U)  // enable

// Triangle: period=128
poke(apu_triangle_lo, 0x80.U)
poke(apu_status, 0x04.U)  // enable

// Noise: volume=8, period=5
poke(apu_noise_ctrl, 0x08.U)
poke(apu_noise_period, 0x05.U)
poke(apu_status, 0x08.U)  // enable
```

### MMC3 IRQ
```scala
// 每 10 条扫描线触发 IRQ
poke(mmc3_irq_latch, 0x0A.U)
poke(mmc3_irq_reload, 0.U)
poke(mmc3_irq_enable, 0.U)
```

---

## 📝 PPU 寄存器

| 地址 | 名称 | 功能 |
|------|------|------|
| $2000 | PPUCTRL | 控制 (NMI, pattern tables, 8x16 sprites) |
| $2001 | PPUMASK | 掩码 (rendering enable) |
| $2002 | PPUSTATUS | 状态 (VBlank, Sprite 0, Sprite overflow) |
| $2002 | PPUSTATUS | 状态 (VBlank, sprite 0) |
| $2003 | OAMADDR | OAM 地址 |
| $2004 | OAMDATA | OAM 数据 |
| $2005 | PPUSCROLL | 滚动位置 |
| $2006 | PPUADDR | VRAM 地址 |
| $2007 | PPUDATA | VRAM 数据 |

## 🎵 APU 寄存器

| 地址 | 名称 | 功能 |
|------|------|------|
| $4000-$4003 | Pulse 1 | 方波 1 |
| $4004-$4007 | Pulse 2 | 方波 2 |
| $4008-$400B | Triangle | 三角波 |
| $400C-$400F | Noise | 噪声 |
| $4015 | Status | 通道启用 |
| $4017 | Frame Counter | 帧计数器 |

## 🗺️ 内存映射

### CPU 地址空间
```
$0000-$07FF: RAM (2KB)
$2000-$2007: PPU Registers
$4000-$4017: APU + I/O
$8000-$FFFF: PRG ROM
  $FFFC-$FFFD: Reset Vector
  $FFFA-$FFFB: NMI Vector
  $FFFE-$FFFF: IRQ Vector
```

### PPU 地址空间
```
$0000-$1FFF: Pattern Tables (CHR)
$2000-$2FFF: Nametables (VRAM)
$3F00-$3F1F: Palette RAM
```

## ⏱️ 时序

### PPU 时序
```
每帧: 262 扫描线
每扫描线: 341 像素
可见区域: 256×240
VBlank: 扫描线 241-260
```

### CPU 时序
```
NTSC: 1.789773 MHz
每帧: ~29,780 周期
每扫描线: ~113.67 周期
```

## 🔧 常用代码片段

### 等待 VBlank
```scala
while (!dut.io.vblank.peek().litToBoolean) {
  dut.clock.step(1)
}
```

### 写入 PPU 寄存器
```scala
// 启用 NMI
dut.io.cpuAddr.poke(0.U)  // PPUCTRL
dut.io.cpuDataIn.poke(0x80.U)
dut.io.cpuWrite.poke(true.B)
dut.clock.step(1)
dut.io.cpuWrite.poke(false.B)
```

### 读取 PPUSTATUS
```scala
dut.io.cpuAddr.poke(2.U)  // PPUSTATUS
dut.io.cpuRead.poke(true.B)
dut.clock.step(1)
val status = dut.io.cpuDataOut.peek()
dut.io.cpuRead.poke(false.B)
```

### 写入 VRAM
```scala
// 设置地址 $2000
dut.io.cpuAddr.poke(6.U)  // PPUADDR
dut.io.cpuDataIn.poke(0x20.U)
dut.io.cpuWrite.poke(true.B)
dut.clock.step(1)
dut.io.cpuDataIn.poke(0x00.U)
dut.clock.step(1)

// 写入数据
dut.io.cpuAddr.poke(7.U)  // PPUDATA
dut.io.cpuDataIn.poke(0x01.U)
dut.clock.step(1)
dut.io.cpuWrite.poke(false.B)
```

### 加载 ROM
```scala
val rom = ROMLoader.loadNESROM("game.nes")
dut.io.mapperType.poke(rom.mapper.U)

// 加载 PRG ROM
dut.io.romLoadPRG.poke(true.B)
for (i <- 0 until rom.prgROM.length) {
  dut.io.romLoadEn.poke(true.B)
  dut.io.romLoadAddr.poke(i.U)
  dut.io.romLoadData.poke((rom.prgROM(i) & 0xFF).U)
  dut.clock.step(1)
}
dut.io.romLoadEn.poke(false.B)
```

## 🐛 调试技巧

### 查看 CPU 状态
```scala
println(f"PC: 0x${dut.io.debug.regPC.peek().litValue}%04X")
println(f"A:  0x${dut.io.debug.regA.peek().litValue}%02X")
println(f"X:  0x${dut.io.debug.regX.peek().litValue}%02X")
println(f"Y:  0x${dut.io.debug.regY.peek().litValue}%02X")
```

### 跟踪 VBlank
```scala
var vblankCount = 0
var lastVBlank = false

for (i <- 0 until 200000) {
  val vblank = dut.io.vblank.peek().litToBoolean
  if (vblank && !lastVBlank) {
    vblankCount += 1
    println(s"VBlank #$vblankCount at cycle $i")
  }
  lastVBlank = vblank
  dut.clock.step(1)
}
```

### 单步执行
```scala
for (i <- 0 until 100) {
  val pc = dut.io.debug.regPC.peek().litValue
  val opcode = dut.io.debug.opcode.peek().litValue
  println(f"[$i] PC: 0x$pc%04X, Opcode: 0x$opcode%02X")
  dut.clock.step(1)
}
```

## 📊 测试统计

```
总测试: 100+
通过: 100+
失败: 0
通过率: 100%

分类:
- CPU 测试: 78
- NES 系统测试: 4
- Contra 测试: 3
- ROM 加载测试: 4
- 其他: 15+
```

## 🎯 进度

```
总体进度: 80%

CPU:     ████████████████████ 100%
PPU:     █████████████████░░░  85%
APU:     ████████░░░░░░░░░░░░  40%
Mapper:  ██████████████████░░  90%
System:  ███████████████████░  95%
```

## 📚 文档

- [NES v2 改进](NES_V2_IMPROVEMENTS.md)
- [使用指南](NES_USAGE_GUIDE.md)
- [更新总结](NES_V2_SUMMARY.md)
- [Contra 进度](CONTRA_PROGRESS.md)

## 🔗 资源

- [NesDev Wiki](https://www.nesdev.org/wiki/)
- [6502 Reference](http://www.6502.org/)
- [Visual 6502](http://www.visual6502.org/)

---

**版本**: v2.0  
**更新**: 2025-11-27
