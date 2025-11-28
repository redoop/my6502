# 🎮 NES 模拟器运行指南

**版本**: v0.4.0
**日期**: 2025-11-27

---

## 📋 概述

本项目是基于 Chisel 的 NES 硬件实现，可以通过以下方式运行实际游戏：

### 方案 1: Verilator + SDL2 (推荐)
将 Chisel 生成的 Verilog 转换为 C++ 模拟器，配合 SDL2 提供图形和输入。

### 方案 2: FPGA 部署
将 Verilog 部署到 FPGA 开发板，连接显示器和控制器。

### 方案 3: ChiselTest 仿真
使用 ChiselTest 进行功能验证（已实现）。

---

## 🚀 方案 1: Verilator 模拟器（推荐）

### 步骤 1: 生成 Verilog

```bash
# 生成 NES 系统的 Verilog
sbt "runMain nes.GenerateNESVerilog"

# 输出文件: generated/nes/NESSystemv2.v
```

### 步骤 2: 安装依赖

```bash
# Ubuntu/Debian
sudo apt-get install verilator libsdl2-dev libsdl2-image-dev

# macOS
brew install verilator sdl2 sdl2_image

# Arch Linux
sudo pacman -S verilator sdl2 sdl2_image
```

### 步骤 3: 创建 C++ 包装器

我将创建一个 C++ 包装器来：
- 加载 ROM 文件
- 驱动 Verilog 模块
- 渲染画面到 SDL2 窗口
- 处理键盘输入

---

## 📁 项目结构

```
my6502/
├── generated/
│   └── nes/
│       └── NESSystemv2.v          # 生成的 Verilog
├── emulator/                       # 新增：模拟器前端
│   ├── src/
│   │   ├── main.cpp               # 主程序
│   │   ├── nes_emulator.cpp       # NES 模拟器类
│   │   ├── display.cpp            # SDL2 显示
│   │   └── input.cpp              # 键盘输入
│   ├── include/
│   │   ├── nes_emulator.h
│   │   ├── display.h
│   │   └── input.h
│   ├── CMakeLists.txt             # CMake 构建
│   └── README.md
└── roms/                          # ROM 文件目录
    └── contra.nes
```

---

## 🔧 实现细节

### C++ 模拟器架构

```cpp
class NESEmulator {
public:
    // 初始化
    bool init(const std::string& romPath);
    
    // 主循环
    void run();
    
    // 单步执行
    void step();
    
    // 渲染一帧
    void renderFrame();
    
private:
    // Verilator 模块
    VNESSystemv2* nes;
    
    // ROM 数据
    std::vector<uint8_t> prgRom;
    std::vector<uint8_t> chrRom;
    
    // 显示
    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Texture* texture;
    
    // 帧缓冲 (256x240)
    uint32_t framebuffer[256 * 240];
    
    // 输入状态
    uint8_t controller1;
    uint8_t controller2;
};
```

### 键盘映射

```
NES 控制器 1:
  A      -> Z
  B      -> X
  SELECT -> A
  START  -> S
  UP     -> ↑
  DOWN   -> ↓
  LEFT   -> ←
  RIGHT  -> →

NES 控制器 2:
  A      -> N
  B      -> M
  SELECT -> ,
  START  -> .
  UP     -> W
  DOWN   -> S
  LEFT   -> A
  RIGHT  -> D
```

### 调色板

NES 使用 64 色调色板，需要映射到 RGB：

```cpp
const uint32_t NES_PALETTE[64] = {
    0x7C7C7C, 0x0000FC, 0x0000BC, 0x4428BC,
    0x940084, 0xA80020, 0xA81000, 0x881400,
    // ... 完整的 64 色
};
```

---

## 🎮 使用方法

### 编译模拟器

```bash
cd emulator
mkdir build
cd build
cmake ..
make
```

### 运行游戏

```bash
# 运行魂斗罗
./nes_emulator ../../roms/contra.nes

# 运行 Super Mario Bros
./nes_emulator ../../roms/smb.nes

# 带调试信息
./nes_emulator --debug ../../roms/contra.nes
```

### 命令行选项

```
用法: nes_emulator [选项] <rom文件>

选项:
  -h, --help          显示帮助信息
  -d, --debug         启用调试模式
  -s, --scale <n>     窗口缩放 (1-4, 默认 2)
  -f, --fullscreen    全屏模式
  --no-audio          禁用音频
  --save-state <file> 保存状态
  --load-state <file> 加载状态
```

---

## 🎨 显示效果

### 窗口设置
- **分辨率**: 256x240 (NES 原生)
- **缩放**: 2x (512x480 窗口)
- **帧率**: 60 FPS (NTSC)
- **垂直同步**: 启用

### 性能要求
- **CPU**: 任何现代 CPU
- **内存**: < 100 MB
- **GPU**: 支持 OpenGL 2.0+

---

## 🔊 音频输出

### 音频设置
- **采样率**: 44.1 kHz
- **位深度**: 16-bit
- **声道**: 立体声
- **缓冲**: 512 samples

### APU 通道
- Pulse 1/2: 方波
- Triangle: 三角波
- Noise: 噪声
- DMC: 采样播放

---

## 🐛 调试功能

### 调试模式

```bash
./nes_emulator --debug contra.nes
```

显示信息：
- CPU 状态 (PC, A, X, Y, SP, Flags)
- PPU 状态 (扫描线, 像素, VBlank)
- APU 状态 (通道启用, 音量)
- 内存访问
- 性能统计

### 快捷键

```
调试快捷键:
  F1  - 暂停/继续
  F2  - 单步执行
  F3  - 单帧执行
  F4  - 保存状态
  F5  - 加载状态
  F6  - 重置
  F7  - 截图
  F8  - 切换调试信息
  F9  - 切换 FPS 显示
  F10 - 切换音频
  F11 - 全屏
  ESC - 退出
```

---

## 📊 性能优化

### Verilator 优化选项

```cmake
# CMakeLists.txt
set(VERILATOR_FLAGS
    --cc                    # 生成 C++
    --exe                   # 生成可执行文件
    --build                 # 自动构建
    -O3                     # 优化级别 3
    --x-assign fast         # 快速 X 赋值
    --x-initial fast        # 快速 X 初始化
    --noassert              # 禁用断言
    --trace                 # 启用波形追踪（调试用）
)
```

### 运行时优化

```cpp
// 使用多线程
#define VM_PARALLEL_BUILDS 1

// 启用快速模式
#define VM_COVERAGE 0
#define VM_TRACE 0  // 发布版本禁用追踪
```

---

## 🎯 当前限制

### 已知问题
1. ⚠️ DMC 内存访问未完全集成
2. ⚠️ 某些 Mapper 未实现 (仅支持 MMC3)
3. ⚠️ 保存/加载状态功能待实现
4. ⚠️ 网络对战功能未实现

### 兼容性
- ✅ Mapper 4 (MMC3): 魂斗罗, SMB3
- ⏳ Mapper 0 (NROM): 待测试
- ⏳ Mapper 1 (MMC1): 待实现
- ⏳ Mapper 2 (UxROM): 待实现

---

## 🚀 方案 2: FPGA 部署

### 支持的开发板
- Xilinx Artix-7 (推荐)
- Xilinx Spartan-7
- Intel Cyclone V
- Lattice ECP5

### 资源需求
- LUTs: ~10,000
- FFs: ~3,000
- BRAM: 12.5 KB
- 时钟: 50 MHz

### 外设接口
- VGA 输出 (640x480 @ 60Hz)
- PS/2 键盘
- I2S 音频输出
- SD 卡 (ROM 加载)

---

## 📚 参考资料

### NES 开发
- [NESDev Wiki](https://wiki.nesdev.com/)
- [6502 Reference](http://www.6502.org/)
- [NES APU](https://wiki.nesdev.com/w/index.php/APU)

### Verilator
- [Verilator Manual](https://verilator.org/guide/latest/)
- [Verilator Examples](https://github.com/verilator/verilator/tree/master/examples)

### SDL2
- [SDL2 Documentation](https://wiki.libsdl.org/)
- [Lazy Foo' SDL Tutorials](https://lazyfoo.net/tutorials/SDL/)

---

## 🎉 下一步

### 短期 (1 周)
1. ⏳ 创建 C++ 模拟器框架
2. ⏳ 实现 SDL2 显示
3. ⏳ 实现键盘输入
4. ⏳ 集成 Verilator

### 中期 (1 个月)
1. ⏳ 实现音频输出
2. ⏳ 添加调试功能
3. ⏳ 优化性能
4. ⏳ 添加保存/加载

### 长期 (2-3 个月)
1. ⏳ FPGA 部署
2. ⏳ 更多 Mapper 支持
3. ⏳ 网络对战
4. ⏳ 工具链完善

---

**状态**: 📋 规划中
**优先级**: 高
**预计时间**: 1-2 周

如果您想立即开始，我可以帮您创建 C++ 模拟器的基础框架！
