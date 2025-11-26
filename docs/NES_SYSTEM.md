# NES 系统实现指南

## 概述

这是一个基于 Chisel 6502 CPU 的 NES (Nintendo Entertainment System) 系统框架。目前实现了基础组件，可以作为运行 NES 游戏（如魂斗罗）的起点。

## 架构

```
┌─────────────────────────────────────────┐
│           NES System                     │
│                                          │
│  ┌──────────┐      ┌──────────────┐    │
│  │  CPU     │◄────►│   Memory     │    │
│  │  6502    │      │  Controller  │    │
│  └──────────┘      └──────┬───────┘    │
│                           │              │
│                    ┌──────▼───────┐     │
│                    │     PPU      │     │
│                    │   (2C02)     │     │
│                    └──────────────┘     │
│                                          │
└─────────────────────────────────────────┘
```

## 已实现的组件

### 1. CPU6502
- 完整的 6502 指令集
- 所有寻址模式
- 中断支持 (NMI, IRQ, BRK)
- 通过 Klaus Dormann 功能测试

### 2. PPU (Picture Processing Unit)
简化的 PPU 实现，包含：
- ✅ 基本寄存器 (PPUCTRL, PPUMASK, PPUSTATUS 等)
- ✅ 扫描线计数器
- ✅ VBlank 检测和 NMI 生成
- ✅ 2KB VRAM (nametables)
- ✅ 256B OAM (sprite memory)
- ✅ 32B palette RAM
- ❌ 背景渲染 (待实现)
- ❌ 精灵渲染 (待实现)
- ❌ 滚动 (待实现)

### 3. MemoryController
NES 内存映射实现：
- `$0000-$07FF`: 2KB 内部 RAM (带镜像到 $1FFF)
- `$2000-$2007`: PPU 寄存器 (带镜像到 $3FFF)
- `$4016-$4017`: 控制器接口
- `$8000-$FFFF`: 32KB PRG ROM

### 4. NESSystem
顶层模块，整合所有组件

## 内存映射详解

### CPU 内存空间
```
$0000-$07FF: 2KB 内部 RAM
$0800-$1FFF: RAM 镜像 (3 次)
$2000-$2007: PPU 寄存器
$2008-$3FFF: PPU 寄存器镜像
$4000-$4017: APU 和 I/O 寄存器
$4020-$5FFF: 扩展 ROM
$6000-$7FFF: 卡带 SRAM (8KB)
$8000-$BFFF: PRG ROM 低 16KB
$C000-$FFFF: PRG ROM 高 16KB
```

### PPU 寄存器
```
$2000: PPUCTRL   - PPU 控制
$2001: PPUMASK   - PPU 掩码
$2002: PPUSTATUS - PPU 状态 (只读)
$2003: OAMADDR   - OAM 地址
$2004: OAMDATA   - OAM 数据
$2005: PPUSCROLL - 滚动位置
$2006: PPUADDR   - PPU 地址
$2007: PPUDATA   - PPU 数据
```

## 使用方法

### 编译和测试

```bash
# 运行 NES 系统测试
sbt "testOnly nes.NESSystemTest"

# 生成 Verilog
sbt "runMain nes.GenerateNESVerilog"
```

### 加载程序

目前系统支持通过测试接口加载程序到 ROM：

```scala
// 在测试中加载简单程序
test(new NESSystem) { dut =>
  // 加载程序到 $8000
  // 注意：需要扩展 MemoryController 以支持 ROM 加载
}
```

## 运行魂斗罗需要的额外工作

### 1. 完善 PPU 渲染
```scala
// 需要实现：
- 背景层渲染 (4 个 nametable)
- 精灵渲染 (64 个精灵，8x8 或 8x16)
- 调色板系统 (背景 + 精灵)
- 滚动寄存器
- 精灵 0 碰撞检测
```

### 2. 实现 Mapper
魂斗罗使用 MMC3 mapper：
```scala
class MMC3Mapper extends Module {
  // PRG ROM bank switching
  // CHR ROM bank switching  
  // IRQ 计数器 (用于滚动效果)
}
```

### 3. 添加 APU (可选)
音频处理单元：
- 2 个方波通道
- 1 个三角波通道
- 1 个噪声通道
- 1 个 DMC 通道

### 4. 实现 CHR ROM/RAM
图形数据存储：
- 8KB CHR ROM/RAM
- Pattern tables (精灵和背景图案)

### 5. 控制器支持
标准 NES 控制器：
```
Bit 0: A
Bit 1: B
Bit 2: Select
Bit 3: Start
Bit 4: Up
Bit 5: Down
Bit 6: Left
Bit 7: Right
```

## 开发路线图

### 阶段 1: 基础验证 ✅
- [x] CPU 实现
- [x] 基础 PPU 框架
- [x] 内存控制器
- [x] 系统集成

### 阶段 2: PPU 渲染 (进行中)
- [ ] 背景渲染
- [ ] 精灵渲染
- [ ] 调色板
- [ ] 滚动

### 阶段 3: Mapper 支持
- [ ] NROM (Mapper 0)
- [ ] MMC1 (Mapper 1)
- [ ] MMC3 (Mapper 4) - 魂斗罗需要

### 阶段 4: 完整系统
- [ ] APU 实现
- [ ] 控制器完善
- [ ] ROM 加载器
- [ ] 调试工具

### 阶段 5: 游戏测试
- [ ] 简单游戏 (如 Donkey Kong)
- [ ] 魂斗罗
- [ ] 其他 MMC3 游戏

## 参考资料

### 技术文档
- [NesDev Wiki](https://www.nesdev.org/) - 最全面的 NES 技术文档
- [6502 Reference](http://www.6502.org/) - 6502 CPU 参考
- [PPU Rendering](https://www.nesdev.org/wiki/PPU_rendering) - PPU 渲染详解

### 开源项目
- [FCEUX](https://fceux.com/) - NES 模拟器和调试器
- [Mesen](https://github.com/SourMesen/Mesen2) - 高精度 NES 模拟器
- [FPGANES](https://github.com/strigeus/fpganes) - FPGA NES 实现

### ROM 信息
- 魂斗罗 (美版 Contra)
  - Mapper: MMC3 (Mapper 4)
  - PRG ROM: 128KB
  - CHR ROM: 128KB
  - Mirroring: Horizontal

## 性能估算

### 时钟频率
- NES CPU: 1.789773 MHz (NTSC)
- PPU: 5.369318 MHz (3x CPU)
- 每帧: 29780.5 CPU 周期

### 资源使用 (估算)
- CPU: ~5000 LUTs
- PPU: ~3000 LUTs (简化版)
- Memory: ~40KB BRAM
- 总计: ~8000 LUTs + 40KB BRAM

适合在中等规模 FPGA 上实现 (如 Xilinx Artix-7)

## 快速开始示例

```scala
// 创建一个简单的测试程序
val program = Seq(
  0xA9, 0x01,  // LDA #$01
  0x8D, 0x00, 0x02,  // STA $0200
  0xA9, 0x05,  // LDA #$05
  0x8D, 0x01, 0x02,  // STA $0201
  0x4C, 0x00, 0x80   // JMP $8000 (loop)
)

// 加载到 ROM 并运行
// (需要实现 ROM 加载接口)
```

## 贡献

欢迎贡献！优先级：
1. PPU 背景渲染
2. PPU 精灵渲染
3. MMC3 Mapper
4. APU 实现

## 许可证

与主项目相同
