# NES 模拟器当前状态

## 最新进展 (2025-11-28)

### ✅ 已完成的功能

#### CPU (6502)
- ✅ 正确从 reset vector (0xC79E) 启动
- ✅ 指令执行正常
- ✅ 寄存器更新正常
- ✅ 内存读写正常
- ✅ 16KB ROM 镜像支持

#### PPU (图形处理)
- ✅ 扫描线计数器工作正常
- ✅ VBlank 检测正常
- ✅ CHR ROM 加载和读取
- ✅ Pattern table 渲染
- ✅ Nametable 渲染
- ✅ Attribute table 读取
- ✅ 调色板初始化
- ✅ 像素颜色计算
- ✅ Framebuffer 更新
- ✅ SDL 显示

#### 系统集成
- ✅ CPU-Memory-PPU 连接
- ✅ ROM 加载系统
- ✅ Verilator 仿真环境
- ✅ SDL2 图形显示
- ✅ 调试输出系统

### 📊 当前状态

**运行参数：**
- FPS: 2-3 (需要优化)
- CPU PC: 0xC7AF
- CPU 寄存器: A=0x80, X=0xFF, Y=0x00, SP=0xFF

**PPU 状态：**
- PPUCTRL: 0x10 (Pattern table 1 选中)
- PPUMASK: 0x00 (渲染禁用 ⚠️)
- PPUSTATUS: 0x80 (VBlank)
- 调色板: 已初始化 ✅
- 非零像素: 23040 / 61440 (37.5%)

**画面显示：**
- 重复的灰色图案
- 说明渲染管道工作正常
- 但游戏还未完全初始化

### 🔧 当前问题

1. **PPUMASK = 0**
   - 游戏还没有启用渲染
   - 需要等待游戏初始化完成
   - 或者需要 NMI 中断支持

2. **性能问题**
   - FPS 只有 2-3
   - 需要优化仿真速度

3. **缺少 NMI 中断**
   - 游戏依赖 NMI 来更新 PPU
   - 这可能是游戏无法完全初始化的原因

### 📈 测试结果

| 测试项目 | 结果 | 说明 |
|---------|------|------|
| CPU 启动 | ✅ | 从正确的地址启动 |
| CPU 执行 | ✅ | 指令正常执行 |
| ROM 加载 | ✅ | PRG 和 CHR ROM 正确加载 |
| PPU 扫描 | ✅ | 扫描线计数正常 |
| VBlank | ✅ | VBlank 检测正常 |
| 调色板 | ✅ | 初始化完成 |
| Pattern 渲染 | ✅ | CHR ROM 正确显示 |
| Nametable 渲染 | ✅ | 显示重复图案 |
| 游戏画面 | ⚠️ | 等待游戏初始化 |

### 🎯 下一步计划

#### 短期目标
1. **实现 NMI 中断**
   - 让 CPU 能响应 VBlank
   - 这对游戏初始化很重要

2. **监控 PPU 寄存器写入**
   - 观察游戏何时设置 PPUMASK
   - 观察游戏写入的数据

3. **等待游戏初始化**
   - 运行更长时间
   - 观察状态变化

#### 中期目标
1. **精灵渲染**
   - 实现 OAM 系统
   - 显示游戏角色

2. **性能优化**
   - 提高 FPS 到 60
   - 优化 Verilator 仿真

3. **完善 PPU 功能**
   - 滚动支持
   - Sprite 0 碰撞
   - 精灵优先级

#### 长期目标
1. **音频支持**
   - 实现 APU
   - 声音输出

2. **更多 Mapper 支持**
   - 支持更多游戏

3. **保存/加载状态**
   - 游戏进度保存

## 技术细节

### 渲染管道流程
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
   ↓
8. VBlank 时更新 SDL 纹理
```

### 内存映射
- **CPU 地址空间:**
  - 0x0000-0x07FF: 内部 RAM (2KB)
  - 0x2000-0x2007: PPU 寄存器
  - 0x4000-0x4017: APU/IO 寄存器
  - 0x8000-0xFFFF: PRG ROM (32KB)

- **PPU 地址空间:**
  - 0x0000-0x1FFF: CHR ROM (8KB)
  - 0x2000-0x2FFF: VRAM (4KB, 镜像)
  - 0x3F00-0x3F1F: 调色板 (32B)

### 构建流程
```bash
# 一键构建（包含 Verilog 生成）
./scripts/verilator_build.sh

# 运行仿真
./scripts/verilator_run.sh games/Donkey-Kong.nes
```

## 结论

NES 模拟器的核心功能已经实现并验证工作正常。CPU 正确执行代码，PPU 渲染管道正常工作。当前的主要问题是游戏还在初始化阶段，还没有启用渲染。实现 NMI 中断支持应该能让游戏完成初始化并显示正确的画面。

**项目已经取得了重大进展！** 🎉
