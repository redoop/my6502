# PPU 渲染系统

## PPU 概述

PPU (Picture Processing Unit) 是 NES 的图形处理单元，负责所有图形渲染工作。

## 系统架构

### PPUv3 - 完整渲染管线

```
┌─────────────────────────────────────────────────────┐
│                     PPUv3                           │
│                                                     │
│  ┌──────────────┐         ┌──────────────────┐    │
│  │  Registers   │         │ PPURenderPipeline│    │
│  │              │         │                  │    │
│  │ - PPUCTRL    │────────▶│ - Background     │    │
│  │ - PPUMASK    │         │ - Sprites        │    │
│  │ - PPUSTATUS  │◀────────│ - Palette        │    │
│  │ - PPUSCROLL  │         │ - Priority       │    │
│  │ - PPUADDR    │         └──────────────────┘    │
│  │ - PPUDATA    │                 │               │
│  └──────────────┘                 │               │
│                                    ▼               │
│  ┌──────────────┐         ┌──────────────────┐    │
│  │   Memory     │◀───────▶│  Memory Access   │    │
│  │              │         │   Arbitration    │    │
│  │ - VRAM       │         └──────────────────┘    │
│  │ - OAM        │                                  │
│  │ - Palette    │                                  │
│  └──────────────┘                                  │
└─────────────────────────────────────────────────────┘
```

## 内存映射

### PPU 地址空间

```
$0000-$0FFF: Pattern Table 0 (4KB)
$1000-$1FFF: Pattern Table 1 (4KB)
$2000-$23FF: Nametable 0 (1KB)
$2400-$27FF: Nametable 1 (1KB)
$2800-$2BFF: Nametable 2 (1KB)
$2C00-$2FFF: Nametable 3 (1KB)
$3000-$3EFF: Nametable Mirrors
$3F00-$3F1F: Palette RAM (32 bytes)
$3F20-$3FFF: Palette Mirrors
```

### CPU 访问的 PPU 寄存器

| 地址 | 寄存器 | 读/写 | 功能 |
|------|--------|-------|------|
| $2000 | PPUCTRL | 写 | 控制寄存器 |
| $2001 | PPUMASK | 写 | 掩码寄存器 |
| $2002 | PPUSTATUS | 读 | 状态寄存器 |
| $2003 | OAMADDR | 写 | OAM 地址 |
| $2004 | OAMDATA | 读写 | OAM 数据 |
| $2005 | PPUSCROLL | 写x2 | 滚动位置 |
| $2006 | PPUADDR | 写x2 | VRAM 地址 |
| $2007 | PPUDATA | 读写 | VRAM 数据 |

## PPU 寄存器详解

### PPUCTRL ($2000)

```
7  bit  0
---- ----
VPHB SINN
|||| ||||
|||| ||++- Base nametable address
|||| ||    (0 = $2000; 1 = $2400; 2 = $2800; 3 = $2C00)
|||| |+--- VRAM address increment per CPU read/write of PPUDATA
|||| |     (0: add 1, going across; 1: add 32, going down)
|||| +---- Sprite pattern table address for 8x8 sprites
||||       (0: $0000; 1: $1000; ignored in 8x16 mode)
|||+------ Background pattern table address (0: $0000; 1: $1000)
||+------- Sprite size (0: 8x8 pixels; 1: 8x16 pixels)
|+-------- PPU master/slave select (0: read backdrop from EXT pins; 1: output color on EXT pins)
+--------- Generate an NMI at the start of VBlank (0: off; 1: on)
```

### PPUMASK ($2001)

```
7  bit  0
---- ----
BGRs bMmG
|||| ||||
|||| |||+- Greyscale (0: normal color, 1: produce a greyscale display)
|||| ||+-- 1: Show background in leftmost 8 pixels of screen, 0: Hide
|||| |+--- 1: Show sprites in leftmost 8 pixels of screen, 0: Hide
|||| +---- 1: Show background
|||+------ 1: Show sprites
||+------- Emphasize red
|+-------- Emphasize green
+--------- Emphasize blue
```

### PPUSTATUS ($2002)

```
7  bit  0
---- ----
VSO. ....
|||| ||||
|||+-++++- Least significant bits previously written into a PPU register
||+------- Sprite overflow
|+-------- Sprite 0 Hit
+--------- Vertical blank has started (0: not in vblank; 1: in vblank)
```

## 渲染管线

### 背景渲染流程

```
1. 扫描线计数 (scanlineX, scanlineY)
   ↓
2. 计算 tile 坐标 (tileX, tileY)
   ↓
3. 读取 nametable → tile 索引
   ↓
4. 读取 attribute table → 调色板索引
   ↓
5. 读取 pattern table → 像素数据
   ↓
6. 读取 palette → RGB 颜色
   ↓
7. 输出到 framebuffer
```

### 精灵渲染流程

```
1. OAM 评估 (每条扫描线)
   ↓
2. 精灵预取 (读取 tile 数据)
   ↓
3. 精灵翻转处理 (水平/垂直)
   ↓
4. 优先级判断 (前景/背景)
   ↓
5. 与背景合成
   ↓
6. 输出到 framebuffer
```

## 背景渲染

### Nametable 结构

每个 nametable 是 32x30 tiles (960 bytes)：
- 每个 tile 是 8x8 像素
- 总分辨率：256x240 像素

### Attribute Table

每个 nametable 后跟 64 字节的 attribute table：
- 每个字节控制 4x4 tiles (32x32 像素)
- 每 2 bits 指定一个 2x2 tiles 的调色板

```
Attribute byte:
7  bit  0
---- ----
|||| ||||
|||| ||++- Palette for top-left 2x2 tiles
|||| ++--- Palette for top-right 2x2 tiles
||++------ Palette for bottom-left 2x2 tiles
++-------- Palette for bottom-right 2x2 tiles
```

### Pattern Table

两个 pattern tables，每个 4KB：
- 256 个 tiles
- 每个 tile 8x8 像素
- 每个像素 2 bits (4 色)
- 每个 tile 16 bytes (8 bytes 低位 + 8 bytes 高位)

## 精灵渲染

### OAM (Object Attribute Memory)

256 bytes，64 个精灵，每个 4 bytes：

```
Byte 0: Y position (top of sprite - 1)
Byte 1: Tile index
Byte 2: Attributes
  7  bit  0
  ---- ----
  |||| ||||
  |||| ||++- Palette (4 to 7) of sprite
  |||| |+--- Priority (0: in front of background; 1: behind background)
  |||| +---- Flip sprite horizontally
  |||+------ Flip sprite vertically
  +++------- Unimplemented
Byte 3: X position
```

### 精灵大小

- **8x8 模式**: 标准模式，每个精灵 8x8 像素
- **8x16 模式**: PPUCTRL bit 5 = 1，每个精灵 8x16 像素
  - Tile index bit 0 选择 pattern table
  - 上半部分：tile N
  - 下半部分：tile N+1

### 精灵优先级

1. 精灵按 OAM 顺序渲染
2. 较早的精灵优先显示（覆盖后面的）
3. Sprite 0 用于碰撞检测

### Sprite 0 碰撞

- 当 Sprite 0 的不透明像素与背景的不透明像素重叠时
- PPUSTATUS bit 6 设置为 1
- 用于实现状态栏分割等效果

### 精灵溢出

- 当一条扫描线上有超过 8 个精灵时
- PPUSTATUS bit 5 设置为 1
- 硬件限制：每条扫描线最多渲染 8 个精灵

## 调色板系统

### 调色板结构

32 bytes 调色板 RAM：
- $3F00-$3F0F: 背景调色板 (4 组，每组 4 色)
- $3F10-$3F1F: 精灵调色板 (4 组，每组 4 色)
- $3F00, $3F04, $3F08, $3F0C: 背景色（镜像）
- $3F10, $3F14, $3F18, $3F1C: 透明色（镜像）

### NES 调色板

64 色系统调色板（硬编码）：
- 每个调色板索引 (0-63) 对应一个 RGB 颜色
- 调色板 RAM 存储的是系统调色板的索引

## 时序

### 帧时序

```
NTSC: 262 扫描线/帧，60.0988 Hz
PAL:  312 扫描线/帧，50.0070 Hz
```

### 扫描线时序

```
每条扫描线: 341 PPU 时钟周期

周期 0-255:   可见像素
周期 256-320: 精灵预取
周期 321-336: 下一条扫描线的 tile 预取
周期 337-340: 未使用
```

### 帧结构

```
扫描线 0-239:   可见扫描线
扫描线 240:     Post-render 扫描线
扫描线 241-260: VBlank
扫描线 261:     Pre-render 扫描线
```

## VBlank 和 NMI

### VBlank 时序

1. 扫描线 241，周期 1：设置 VBlank 标志
2. 如果 PPUCTRL bit 7 = 1，触发 NMI
3. 扫描线 261，周期 1：清除 VBlank 标志

### NMI 使用

游戏通常在 NMI 中：
- 更新 OAM (通过 DMA)
- 更新调色板
- 更新滚动位置
- 更新 VRAM

## OAM DMA

### DMA 传输

- 写入 $4014 触发 DMA
- 从 CPU 内存 $XX00-$XXFF 传输 256 bytes 到 OAM
- CPU 暂停 513-514 周期
- 快速更新所有精灵数据

### 使用示例

```assembly
LDA #$02      ; 从 $0200 开始
STA $4014     ; 触发 DMA
```

## 滚动

### 滚动寄存器

PPUSCROLL ($2005) 需要写入两次：
1. 第一次写入：X 滚动
2. 第二次写入：Y 滚动

### Nametable 镜像

4 个 nametable 的镜像模式：
- **水平镜像**: 0=1, 2=3 (垂直滚动游戏)
- **垂直镜像**: 0=2, 1=3 (水平滚动游戏)
- **单屏**: 所有指向同一个
- **四屏**: 4KB VRAM (特殊卡带)

## 性能指标

### 资源使用 (PPUv3)

| 组件 | LUTs | FFs | BRAM |
|------|------|-----|------|
| PPU 寄存器 | ~300 | ~200 | 0 |
| 背景渲染器 | ~500 | ~300 | 0 |
| 精灵渲染器 | ~800 | ~400 | 0 |
| 调色板查找 | ~100 | ~50 | 0 |
| 内存控制 | ~850 | ~260 | 2.5KB |
| **总计** | **~2,550** | **~1,210** | **2.5KB** |

### 渲染性能

- 时钟频率：50+ MHz
- 像素时钟：5.37 MHz (NTSC)
- 帧率：60 FPS (NTSC)
- 分辨率：256x240

## 调试技巧

### 查看 PPU 状态

```scala
println(f"PPUCTRL:   0x${ppuctrl.peek().litValue}%02X")
println(f"PPUMASK:   0x${ppumask.peek().litValue}%02X")
println(f"PPUSTATUS: 0x${ppustatus.peek().litValue}%02X")
println(f"Scanline:  ${scanline.peek().litValue}")
```

### 检查渲染

```scala
// 等待 VBlank
while (!vblank.peek().litToBoolean) {
  dut.clock.step(1)
}

// 检查像素输出
val pixel = framebuffer.peek()
println(f"Pixel: 0x${pixel}%06X")
```

### 常见问题

1. **画面不显示**
   - 检查 PPUMASK 是否启用渲染
   - 检查 VRAM 是否有数据
   - 检查调色板是否设置

2. **精灵不显示**
   - 检查 OAM 数据
   - 检查 Y 坐标范围 (0-239)
   - 检查 PPUMASK bit 4

3. **颜色错误**
   - 检查调色板设置
   - 检查 attribute table
   - 检查 pattern table 选择

## 相关文档

- [项目概述](01_PROJECT_OVERVIEW.md)
- [开发指南](02_DEVELOPMENT_GUIDE.md)
- [测试指南](03_TESTING_GUIDE.md)
- [CPU 实现详解](06_CPU_IMPLEMENTATION.md)
- [调试指南](08_DEBUG_GUIDE.md)

---
**最后更新**: 2025-11-28  
**版本**: v0.8.0
