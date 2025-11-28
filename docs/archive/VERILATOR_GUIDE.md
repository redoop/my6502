# NES Verilator 仿真指南

本指南介绍如何使用 Verilator 对 NES 模拟器进行硬件级仿真。

## 概述

Verilator 是一个开源的 Verilog/SystemVerilog 仿真器，可以将 Chisel 生成的 Verilog 代码编译成 C++ 并运行高性能仿真。

### 优势

- **硬件级精确度**: 完全模拟硬件行为
- **高性能**: 比传统仿真器快 10-100 倍
- **可调试**: 可以查看所有信号和状态
- **可综合**: 验证代码可以在 FPGA 上运行

## 环境要求

### 必需软件

1. **Verilator** (>= 4.0)
   ```bash
   # Ubuntu/Debian
   sudo apt-get install verilator
   
   # macOS
   brew install verilator
   
   # 或从源码编译
   git clone https://github.com/verilator/verilator
   cd verilator
   autoconf
   ./configure
   make
   sudo make install
   ```

2. **C++ 编译器** (g++ 或 clang++)
   ```bash
   # Ubuntu/Debian
   sudo apt-get install build-essential
   
   # macOS
   xcode-select --install
   ```

3. **SBT** (Scala Build Tool)
   - 用于生成 Verilog

### 可选软件

4. **SDL2** (仅完整版 GUI 需要)
   ```bash
   # Ubuntu/Debian
   sudo apt-get install libsdl2-dev
   
   # macOS
   brew install sdl2
   ```

## 快速开始

### 方法 1: 一键运行（推荐）

```bash
# 简化版（无 GUI，快速测试）
./run_verilator.sh games/your-rom.nes simple

# 完整版（带 SDL GUI）
./run_verilator.sh games/your-rom.nes full
```

### 方法 2: 分步执行

#### 步骤 1: 生成 Verilog

```bash
./scripts/generate_verilog.sh
```

这会：
- 使用 Chisel 编译器生成 Verilog 代码
- 输出到 `generated/nes/` 目录
- 生成 `NESSystem.v` 主模块

#### 步骤 2: 编译仿真器

**简化版（推荐用于测试）:**
```bash
./scripts/verilator_build_simple.sh
```

**完整版（带 GUI）:**
```bash
./scripts/verilator_build.sh
```

编译过程：
- Verilator 将 Verilog 转换为 C++
- 编译 C++ testbench
- 链接生成可执行文件

#### 步骤 3: 运行仿真

**简化版:**
```bash
./build/verilator_simple/VNESSystem games/your-rom.nes [周期数]
```

示例：
```bash
# 运行 100 万周期
./build/verilator_simple/VNESSystem games/Super-Contra-X-\(China\)-\(Pirate\).nes 1000000
```

**完整版:**
```bash
./scripts/verilator_run.sh games/your-rom.nes
```

## 仿真模式对比

### 简化版 (Simple)

**特点:**
- 无 GUI，纯命令行
- 不需要 SDL2
- 快速编译和运行
- 适合调试和测试

**输出:**
```
🚀 NES Verilator 简化仿真器
============================
🔄 复位系统...
📦 ROM 信息:
   PRG ROM: 131072 字节 (8 x 16KB)
   CHR ROM: 131072 字节 (16 x 8KB)
   Mapper: 4
⬆️  加载 ROM 到硬件...
   PRG: 100%
   CHR: 100%
✅ ROM 加载完成
🎮 开始仿真 (最多 1000000 周期)...
周期: 100000 | PC: 0x8234 | A: 0x0 | X: 0x1 | Y: 0x0
📺 VBlank (帧完成)
周期: 200000 | PC: 0x8456 | A: 0xff | X: 0x2 | Y: 0x1
...
```

### 完整版 (Full)

**特点:**
- SDL2 图形界面
- 实时显示画面
- 支持键盘输入
- 完整游戏体验

**控制:**
- 方向键: 移动
- Z: A 按钮
- X: B 按钮
- Enter: Start
- Right Shift: Select
- ESC: 退出

## 性能优化

### 编译优化

Verilator 已配置以下优化：
- `-O3`: 最高 C++ 优化级别
- `--x-assign fast`: 快速 X 赋值
- `--x-initial fast`: 快速初始化
- `--noassert`: 禁用断言（提高速度）

### 仿真速度

典型性能（取决于硬件）：
- 简化版: ~1-5 MHz（模拟 CPU 频率）
- 完整版: ~0.5-2 MHz（受 GUI 限制）

实际 NES CPU 频率: 1.79 MHz

### 提高速度的方法

1. **减少周期数**: 只仿真需要的部分
2. **禁用波形追踪**: 移除 `--trace` 选项
3. **使用简化版**: 避免 GUI 开销
4. **优化 C++ 代码**: 修改 testbench

## 调试技巧

### 1. 查看 CPU 状态

简化版会定期输出 CPU 寄存器：
```
周期: 100000 | PC: 0x8234 | A: 0x0 | X: 0x1 | Y: 0x0
```

### 2. 检测死循环

如果 PC 长时间不变，可能陷入死循环：
```
⚠️  警告: PC 未变化，可能陷入死循环
```

### 3. 监控 VBlank

每帧结束时会输出：
```
📺 VBlank (帧完成)
```

### 4. 波形追踪

添加 `--trace` 选项生成 VCD 波形文件：
```bash
verilator --trace ...
```

然后用 GTKWave 查看：
```bash
gtkwave dump.vcd
```

## 常见问题

### Q: 编译失败 "verilator: command not found"

**A:** Verilator 未安装或不在 PATH 中
```bash
# 检查安装
which verilator
verilator --version

# 重新安装
sudo apt-get install verilator  # Linux
brew install verilator          # macOS
```

### Q: "SDL2 not found"

**A:** 只有完整版需要 SDL2，可以：
1. 安装 SDL2: `sudo apt-get install libsdl2-dev`
2. 或使用简化版: `./run_verilator.sh rom.nes simple`

### Q: 仿真速度太慢

**A:** 尝试：
1. 使用简化版（无 GUI）
2. 减少仿真周期数
3. 禁用波形追踪
4. 使用更快的 CPU

### Q: "Verilog file not found"

**A:** 先生成 Verilog：
```bash
./scripts/generate_verilog.sh
```

### Q: ROM 加载失败

**A:** 检查：
1. ROM 文件路径是否正确
2. ROM 文件是否是有效的 iNES 格式
3. 文件权限是否正确

## 高级用法

### 自定义仿真周期

```bash
# 仿真 500 万周期（约 3 秒）
./build/verilator_simple/VNESSystem rom.nes 5000000
```

### 修改 Testbench

编辑 `verilator/nes_testbench_simple.cpp`:
```cpp
// 添加自定义调试输出
std::cout << "自定义信息: " << dut->io_debug_pc << std::endl;
```

重新编译：
```bash
./scripts/verilator_build_simple.sh
```

### 生成波形文件

1. 修改构建脚本，添加 `--trace`
2. 在 testbench 中添加：
```cpp
#include "verilated_vcd_c.h"
VerilatedVcdC* tfp = new VerilatedVcdC;
dut->trace(tfp, 99);
tfp->open("wave.vcd");
// 在每个周期调用
tfp->dump(cycle_count);
```

### 连接到 FPGA

生成的 Verilog 可以直接用于 FPGA 综合：
```bash
# 使用 Vivado/Quartus 等工具
# 添加 generated/nes/NESSystem.v
# 配置时钟和 I/O
```

## 与其他仿真方式对比

| 方式 | 速度 | 精确度 | 易用性 | 用途 |
|------|------|--------|--------|------|
| Chisel 测试 | 慢 | 高 | 高 | 单元测试 |
| Verilator | 快 | 高 | 中 | 系统仿真 |
| Scala 模拟器 | 中 | 中 | 高 | 快速原型 |
| FPGA | 最快 | 最高 | 低 | 最终部署 |

## 下一步

- 尝试不同的 ROM
- 修改 testbench 添加功能
- 优化性能
- 准备 FPGA 部署

## 参考资料

- [Verilator 官方文档](https://verilator.org/guide/latest/)
- [Chisel 文档](https://www.chisel-lang.org/)
- [NES 开发 Wiki](https://wiki.nesdev.com/)
