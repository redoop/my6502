# 快速参考

## 项目信息

**名称**: NES 硬件模拟器  
**版本**: v0.8.0  
**语言**: Scala (Chisel)  
**状态**: ✅ 可运行  
**完成度**: 82%

## 快速开始

### 编译和运行

```bash
# 1. 生成 Verilog
./scripts/generate_verilog.sh

# 2. 编译 Verilator 仿真器
./scripts/verilator_build.sh

# 3. 运行游戏
./build/verilator/VNESSystem games/Donkey-Kong.nes

# 或一键运行
./scripts/verilator_run.sh games/Donkey-Kong.nes
```

### 运行测试

```bash
# 所有测试
sbt test

# CPU 测试
sbt "testOnly cpu6502.*"

# NES 系统测试
sbt "testOnly nes.*"

# 特定测试
sbt "testOnly nes.ContraQuickTest"
```

## 系统架构速查

### CPU 寄存器

| 寄存器 | 位宽 | 说明 |
|--------|------|------|
| A | 8-bit | 累加器 |
| X | 8-bit | 索引寄存器 X |
| Y | 8-bit | 索引寄存器 Y |
| PC | 16-bit | 程序计数器 |
| SP | 8-bit | 栈指针 |
| P | 8-bit | 状态寄存器 (NV1BDIZC) |

### PPU 寄存器

| 地址 | 名称 | 读/写 | 说明 |
|------|------|-------|------|
| $2000 | PPUCTRL | W | 控制寄存器 |
| $2001 | PPUMASK | W | 掩码寄存器 |
| $2002 | PPUSTATUS | R | 状态寄存器 |
| $2003 | OAMADDR | W | OAM 地址 |
| $2004 | OAMDATA | RW | OAM 数据 |
| $2005 | PPUSCROLL | Wx2 | 滚动位置 |
| $2006 | PPUADDR | Wx2 | VRAM 地址 |
| $2007 | PPUDATA | RW | VRAM 数据 |

### APU 寄存器

| 地址 | 名称 | 说明 |
|------|------|------|
| $4000-$4003 | Pulse 1 | 方波通道 1 |
| $4004-$4007 | Pulse 2 | 方波通道 2 |
| $4008-$400B | Triangle | 三角波通道 |
| $400C-$400F | Noise | 噪声通道 |
| $4010-$4013 | DMC | 采样通道 |
| $4015 | Status | 通道启用/状态 |
| $4017 | Frame Counter | 帧计数器 |

## 内存映射速查

### CPU 地址空间

```
$0000-$07FF: RAM (2KB)
$0800-$1FFF: RAM Mirrors
$2000-$2007: PPU Registers
$2008-$3FFF: PPU Register Mirrors
$4000-$4017: APU and I/O
$4020-$5FFF: Expansion ROM
$6000-$7FFF: SRAM
$8000-$FFFF: PRG ROM
  $FFFA-$FFFB: NMI Vector
  $FFFC-$FFFD: Reset Vector
  $FFFE-$FFFF: IRQ Vector
```

### PPU 地址空间

```
$0000-$0FFF: Pattern Table 0
$1000-$1FFF: Pattern Table 1
$2000-$23FF: Nametable 0
$2400-$27FF: Nametable 1
$2800-$2BFF: Nametable 2
$2C00-$2FFF: Nametable 3
$3F00-$3F1F: Palette RAM
```

## 常用指令速查

### 加载/存储

```assembly
LDA #$42    ; A = 0x42 (立即)
LDA $42     ; A = Memory[$42] (零页)
LDA $1234   ; A = Memory[$1234] (绝对)
STA $1234   ; Memory[$1234] = A
```

### 算术

```assembly
ADC #$10    ; A = A + 0x10 + C
SBC #$10    ; A = A - 0x10 - !C
INC $42     ; Memory[$42]++
DEC $42     ; Memory[$42]--
```

### 逻辑

```assembly
AND #$0F    ; A = A & 0x0F
ORA #$80    ; A = A | 0x80
EOR #$FF    ; A = A ^ 0xFF
```

### 分支

```assembly
BEQ label   ; if Z=1, jump
BNE label   ; if Z=0, jump
BCS label   ; if C=1, jump
BCC label   ; if C=0, jump
BMI label   ; if N=1, jump
BPL label   ; if N=0, jump
```

### 跳转

```assembly
JMP $1234   ; PC = $1234
JSR $1234   ; Call subroutine
RTS         ; Return from subroutine
```

### 栈操作

```assembly
PHA         ; Push A
PLA         ; Pop A
PHP         ; Push P
PLP         ; Pop P
```

## 调试命令速查

### ChiselTest

```scala
// 读取信号
val value = dut.io.signal.peek()

// 设置信号
dut.io.signal.poke(0x42.U)

// 推进时钟
dut.clock.step(1)

// 等待条件
while (!dut.io.ready.peek().litToBoolean) {
  dut.clock.step(1)
}
```

### Verilator

```bash
# 编译
./scripts/verilator_build.sh

# 运行
./build/verilator/VNESSystem game.nes

# 调试版本
./build/minimal/VNESSystem game.nes 10000
```

### VCD 波形

```bash
# 生成 VCD
./scripts/test_reset_trace.sh

# 查看波形
gtkwave nes_trace.vcd
```

## 常见问题速查

### Q: 编译失败？

```bash
# 检查 Scala 版本
scala -version  # 需要 2.13+

# 清理并重新编译
sbt clean
sbt compile
```

### Q: 游戏不启动？

```scala
// 检查 reset vector
println(f"Reset Vector: 0x${resetVector}%04X")

// 检查初始 PC
println(f"Initial PC: 0x${pc}%04X")
```

### Q: 画面不显示？

```scala
// 检查 PPU 寄存器
println(f"PPUCTRL: 0x${ppuctrl}%02X")
println(f"PPUMASK: 0x${ppumask}%02X")

// 检查渲染启用
val bgEnabled = (ppumask & 0x08) != 0
val sprEnabled = (ppumask & 0x10) != 0
```

### Q: 性能太慢？

```bash
# 使用优化编译
verilator --cc -O3 ...

# 减少调试输出
# 注释掉 printf 语句

# 检查性能瓶颈
perf record ./build/verilator/VNESSystem game.nes
perf report
```

## 文件结构速查

```
my6502/
├── src/main/scala/
│   ├── cpu/              # CPU 实现
│   │   ├── core/         # CPU 核心
│   │   └── instructions/ # 指令实现
│   └── nes/              # NES 系统
│       ├── NESSystem.scala
│       ├── PPUv3.scala
│       ├── APU.scala
│       └── MMC3.scala
├── src/test/scala/       # 测试
├── verilator/            # Verilator testbench
├── scripts/              # 构建脚本
├── docs/                 # 文档
├── games/                # ROM 文件
└── build/                # 构建输出
```

## 脚本速查

### 构建脚本

```bash
./scripts/generate_verilog.sh    # 生成 Verilog
./scripts/verilator_build.sh     # 编译 Verilator
./scripts/verilator_run.sh       # 运行游戏
./scripts/build_minimal.sh       # 编译调试版本
./scripts/test_reset_trace.sh    # 生成 VCD
```

### 测试脚本

```bash
sbt test                          # 所有测试
sbt "testOnly cpu6502.*"          # CPU 测试
sbt "testOnly nes.*"              # NES 测试
```

## 性能指标速查

### 资源使用

| 组件 | LUTs | FFs | BRAM |
|------|------|-----|------|
| CPU | ~4,000 | ~500 | 0 |
| PPU | ~2,550 | ~1,210 | 2.5KB |
| APU | ~2,400 | ~650 | 0 |
| Memory | ~1,000 | ~500 | 10KB |
| **总计** | **~10,000** | **~2,900** | **12.5KB** |

### 时序

- CPU 频率: 1.79 MHz (NTSC)
- PPU 频率: 5.37 MHz (NTSC)
- 帧率: 60 FPS (NTSC)
- 分辨率: 256x240

## 测试统计速查

```
总测试: 122+
通过: 122+
失败: 0
成功率: 100%

分类:
- CPU 测试: 78
- PPU 测试: 22
- APU 测试: 12
- 系统测试: 10+
```

## 进度速查

```
总体进度: 82%

CPU:     ████████████████████ 100%
PPU:     ████████████████████ 100%
APU:     ███████████████████░  98%
Mapper:  ███████████████████░  95%
System:  ███████████████████░  95%
```

## 游戏兼容性速查

| 游戏 | Mapper | 兼容性 | 状态 |
|------|--------|--------|------|
| Donkey Kong | NROM | 95% | ✅ 可玩 |
| 魂斗罗 | MMC3 | 98% | ✅ 可玩 |
| Super Mario Bros | NROM | 98% | ✅ 可玩 |
| Mega Man | NROM | 95% | ✅ 可玩 |

## 相关链接

### 文档

- [项目概述](01_PROJECT_OVERVIEW.md)
- [开发指南](02_DEVELOPMENT_GUIDE.md)
- [测试指南](03_TESTING_GUIDE.md)
- [Verilator 指南](04_VERILATOR_GUIDE.md)
- [PPU 系统](05_PPU_SYSTEM.md)
- [CPU 实现](06_CPU_IMPLEMENTATION.md)
- [游戏兼容性](07_GAME_COMPATIBILITY.md)
- [调试指南](08_DEBUG_GUIDE.md)
- [发布说明](09_RELEASE_NOTES.md)

### 外部资源

- [Chisel 文档](https://www.chisel-lang.org/)
- [Verilator 文档](https://verilator.org/)
- [6502 参考](http://www.6502.org/)
- [NES Dev Wiki](https://wiki.nesdev.com/)

---
**最后更新**: 2025-11-28  
**版本**: v0.8.0
