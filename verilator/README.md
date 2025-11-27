# Verilator Testbench

这个目录包含用于 NES 系统 Verilator 仿真的 C++ testbench 代码。

## 文件说明

### nes_testbench.cpp
完整版 testbench，包含：
- SDL2 图形界面
- 实时画面显示
- 键盘输入支持
- 完整的游戏体验

**依赖:**
- SDL2 库
- Verilator

**编译:**
```bash
./scripts/verilator_build.sh
```

**运行:**
```bash
./scripts/verilator_run.sh <rom文件>
```

### nes_testbench_simple.cpp
简化版 testbench，包含：
- 纯命令行界面
- CPU 状态监控
- 周期计数
- 快速测试

**依赖:**
- 仅 Verilator（无需 SDL2）

**编译:**
```bash
./scripts/verilator_build_simple.sh
```

**运行:**
```bash
./build/verilator_simple/VNESSystem <rom文件> [周期数]
```

## 功能特性

### ROM 加载
- 支持 iNES 格式 ROM
- 自动解析 PRG/CHR ROM
- 硬件级 ROM 加载

### 调试输出
- CPU 寄存器状态
- 程序计数器 (PC)
- 周期计数
- VBlank 检测

### 性能监控
- 实时 FPS 显示
- 周期统计
- 死循环检测

## 自定义

### 修改显示
编辑 `NES_PALETTE` 数组来改变调色板。

### 添加调试信息
在 `tick()` 函数中添加：
```cpp
if (cycle_count % 1000 == 0) {
    std::cout << "自定义调试信息" << std::endl;
}
```

### 改变控制器映射
修改 `handleInput()` 函数中的键盘映射。

## 编译选项

### 优化级别
- `-O3`: 最高优化
- `-O2`: 平衡优化
- `-O0`: 无优化（调试用）

### Verilator 选项
- `--trace`: 生成波形文件
- `--coverage`: 代码覆盖率
- `--profile-cfuncs`: 性能分析

## 故障排除

### 编译错误
1. 检查 Verilator 版本: `verilator --version`
2. 检查 C++ 编译器: `g++ --version`
3. 检查 SDL2: `pkg-config --libs sdl2`

### 运行时错误
1. 检查 ROM 文件格式
2. 检查内存限制
3. 查看调试输出

## 性能提示

1. **使用简化版**: 无 GUI 开销
2. **限制周期数**: 只仿真需要的部分
3. **禁用追踪**: 移除 `--trace`
4. **优化编译**: 使用 `-O3`

## 更多信息

详细文档请参考: [docs/VERILATOR_GUIDE.md](../docs/VERILATOR_GUIDE.md)
