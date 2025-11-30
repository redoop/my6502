# 快速开始指南

本指南帮助你快速构建和运行 NES 模拟器。

---

## 📋 前置要求

### 必需工具
- **Verilator** 5.042 或更高版本
- **C++ 编译器** (Clang/GCC)
- **Make**
- **SDL2** (用于 GUI 模拟器)
- **Python 3** (用于工具脚本)

### macOS 安装
```bash
brew install verilator sdl2 python3
```

### Linux 安装
```bash
# Ubuntu/Debian
sudo apt install verilator g++ make libsdl2-dev python3

# Fedora
sudo dnf install verilator gcc-c++ make SDL2-devel python3
```

---

## 🚀 快速运行

### 1. 克隆项目
```bash
git clone <repository-url>
cd my6502
```

### 2. 运行单元测试
```bash
cd src/test/rtl/unit
make all
```

**预期输出**:
```
Testing DMA...
Testing APU...
Testing PPU...
Testing CPU...
[TEST] PASS: INC/DEC - mem[$12] = $01
[TEST] PASS: ROL/ROR - mem[$13] = $80
[TEST] PASS: AND - mem[$14] = $0F
[TEST] PASS: ORA - mem[$15] = $FF
[TEST] PASS: EOR - mem[$16] = $55
[TEST] PASS: LSR/ASL - mem[$17] = $AA
Testing NMI...
[TEST] PASS: NMI triggered 6820 times
Testing PPU rendering...
[TEST] PASS: PPU rendered 61440 pixels
```

### 3. 运行 GUI 模拟器
```bash
cd src/test/rtl
make gui_audio
./obj_dir/Vnes_gui_audio
```

**功能**:
- 实时视频显示 (768x720)
- 音频播放 (44.1kHz)
- FPS 显示

**控制**:
- 关闭窗口退出

---

## 🔧 开发工作流

### 修改 RTL 代码
```bash
# 编辑 CPU 代码
vim src/main/rtl/cpu_6502.sv

# 编辑 PPU 代码
vim src/main/rtl/nes_ppu.sv

# 编辑 APU 代码
vim src/main/rtl/nes_apu.sv
```

### 运行特定测试
```bash
cd src/test/rtl/unit

# 测试 CPU
make test_cpu

# 测试 PPU
make test_ppu

# 测试 APU
make test_apu

# 测试 DMA
make test_dma

# 测试 NMI
make test_nmi

# 测试 PPU 渲染
make test_ppu_render
```

### 清理构建文件
```bash
cd src/test/rtl/unit
make clean
```

---

## 🎮 加载游戏 ROM

### 1. 准备 ROM 文件
将 NES ROM 文件 (.nes) 放入 `roms/` 目录：
```bash
mkdir -p roms
cp your_game.nes roms/
```

### 2. 修改测试台
编辑 `src/test/rtl/nes_gui_audio_tb.cpp`：
```cpp
// 修改 ROM 路径
std::string rom_path = "../../roms/your_game.nes";
```

### 3. 重新编译运行
```bash
cd src/test/rtl
make gui_audio
./obj_dir/Vnes_gui_audio
```

---

## 🔍 调试工具

### 1. 帧捕获工具
捕获游戏画面到 PPM 文件：

```bash
cd src/test/rtl
make capture
timeout 60s ./obj_dir/Vnes_capture
```

**输出**: `dk_output/frame_*.ppm`

### 2. 转换为 PNG
```bash
cd dk_output
../ppm2png.sh
```

### 3. 指令覆盖率分析
```bash
cd src/test/tools
python3 check_cpu_instructions.py
```

**输出**:
```
6502 Instruction Coverage Analysis
===================================
Total Instructions: 151
Implemented: 151
Missing: 0
Coverage: 100.0%
```

---

## 📊 性能分析

### 查看波形
单元测试会生成 VCD 波形文件：
```bash
cd src/test/rtl/unit/waveforms
# 使用 GTKWave 查看
gtkwave test_cpu.vcd
```

### FPS 监控
GUI 模拟器窗口标题显示实时 FPS。

---

## 🐛 常见问题

### Q1: 编译错误 "verilator: command not found"
**解决**: 安装 Verilator
```bash
brew install verilator  # macOS
```

### Q2: SDL2 链接错误
**解决**: 安装 SDL2 开发库
```bash
brew install sdl2  # macOS
sudo apt install libsdl2-dev  # Linux
```

### Q3: 测试失败
**解决**: 
1. 清理构建文件: `make clean`
2. 重新编译: `make all`
3. 检查 RTL 代码语法

### Q4: GUI 窗口黑屏
**可能原因**:
- PPU 渲染未完全实现
- ROM 文件损坏
- 游戏初始化失败

**调试步骤**:
1. 使用帧捕获工具检查输出
2. 查看单元测试是否通过
3. 检查 CPU 执行日志

### Q5: 没有声音
**可能原因**:
- APU 通道未启用
- 音频设备配置问题

**解决**:
1. 检查系统音频设置
2. 确认 SDL2 音频初始化成功

---

## 📚 下一步

- 阅读 [PROJECT_STATUS.md](PROJECT_STATUS.md) 了解项目状态
- 查看 [CHANGELOG.md](CHANGELOG.md) 了解开发历史
- 参考 [instruction_dependency_tree.txt](../instruction_dependency_tree.txt) 了解指令架构

---

## 🤝 获取帮助

遇到问题？
1. 查看文档目录下的其他文档
2. 检查单元测试是否通过
3. 使用调试工具分析问题

---

**祝你使用愉快！** 🎮
