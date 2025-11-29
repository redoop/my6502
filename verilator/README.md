# Verilator Testbench

NES 系统的 Verilator C++ testbench。

## 文件

### testbench_main.cpp
主 testbench 文件，用于 NES 系统仿真。

**功能**:
- 加载 NES ROM 文件
- SDL2 图形显示
- 键盘输入处理
- 硬件级仿真

**使用**:
```bash
./scripts/build.sh
./scripts/run.sh
```

**模块**: `VNESSystemRefactored`

## 归档

旧的 testbench 变体已移至 `archive/` 目录：
- nes_testbench_debug.cpp
- nes_testbench_fast.cpp
- nes_testbench_minimal.cpp
- nes_testbench_simple.cpp
- nes_testbench_trace.cpp
- test_reset.cpp

## 编译

通过 `scripts/build.sh` 自动编译，支持多种模式：
- normal - 标准编译
- fast - 快速编译（无断言）
- trace - 带 VCD 波形追踪
- optimized - 优化编译

## 依赖

- Verilator 5.0+
- SDL2
- C++11 编译器
