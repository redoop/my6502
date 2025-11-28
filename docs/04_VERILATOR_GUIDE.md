# Verilator 仿真指南

## Verilator 简介

Verilator 是一个开源的 Verilog/SystemVerilog 仿真器，将 HDL 代码转换为 C++/SystemC 模型。

## 安装 Verilator

### macOS
```bash
brew install verilator
```

### Linux
```bash
sudo apt-get install verilator
# 或从源码编译
git clone https://github.com/verilator/verilator
cd verilator
autoconf && ./configure && make && sudo make install
```

### 验证安装
```bash
verilator --version
# 应该显示 5.0 或更高版本
```

## 工作流程

### 1. 生成 Verilog

从 Chisel 生成 Verilog：

```bash
./scripts/generate_verilog.sh
```

输出：`generated/nes/NESSystem.v`

### 2. 编译 Verilator 模型

```bash
./scripts/verilator_build.sh
```

这会：
- 将 Verilog 转换为 C++
- 编译 C++ 代码
- 链接 testbench
- 生成可执行文件

输出：`build/verilator/VNESSystem`

### 3. 运行仿真

```bash
./build/verilator/VNESSystem games/Donkey-Kong.nes
```

## Testbench 实现

### 主 Testbench

`verilator/nes_testbench.cpp` - 完整功能版本：
- SDL2 图形显示
- ROM 加载
- 控制器输入
- 实时渲染

### 最小化 Testbench

`verilator/nes_testbench_minimal.cpp` - 调试版本：
- 无图形界面
- 详细日志输出
- 指令追踪
- 可指定运行周期数

### Trace Testbench

`verilator/nes_testbench_trace.cpp` - 波形生成版本：
- 生成 VCD 文件
- 用于波形分析

## 编译选项

### 基础编译

```bash
verilator --cc NESSystem.v \
    --exe nes_testbench.cpp \
    --top-module NESSystem \
    --build
```

### 优化编译

```bash
verilator --cc NESSystem.v \
    --exe nes_testbench.cpp \
    -O3 \
    --x-assign fast \
    --x-initial fast \
    --noassert \
    --build
```

### Trace 编译

```bash
verilator --cc NESSystem.v \
    --exe nes_testbench_trace.cpp \
    --trace \
    --trace-depth 2 \
    --build
```

## 调试技巧

### 1. 使用 VCD 波形

```bash
# 生成 VCD
./scripts/test_reset_trace.sh

# 查看波形
gtkwave nes_trace.vcd
```

### 2. 添加调试信号

在 Chisel 代码中：

```scala
val debug = IO(Output(new DebugBundle))
debug.pc := regs.pc
debug.opcode := opcode
```

### 3. 使用 printf

```scala
printf("PC: 0x%x, Opcode: 0x%x\n", regs.pc, opcode)
```

### 4. 检查编译警告

```bash
./scripts/verilator_build.sh 2>&1 | grep -i warning
```

## 性能优化

### 1. 编译器优化

使用 `-O3` 优化级别

### 2. 减少 Trace

只在需要时启用 trace

### 3. 使用多线程

```bash
verilator --threads 4 ...
```

### 4. 减少调试输出

注释掉不必要的 printf

## 常见问题

### Q: 编译很慢

**A**: 使用并行编译：
```bash
make -j$(nproc)
```

### Q: 运行时崩溃

**A**: 检查内存访问：
```bash
valgrind ./build/verilator/VNESSystem games/Donkey-Kong.nes
```

### Q: 波形文件太大

**A**: 限制 trace 深度：
```bash
--trace-depth 2
```

### Q: 性能太慢

**A**: 
1. 使用 -O3 优化
2. 减少 printf
3. 禁用 trace

## Verilator 限制

1. **不支持所有 SystemVerilog 特性**
2. **时序仿真精度有限**
3. **内存使用较大**
4. **编译时间较长**

## 最佳实践

1. **使用 --build** - 自动化编译
2. **分离 testbench** - 不同用途使用不同 testbench
3. **合理使用 trace** - 只在调试时启用
4. **优化编译选项** - 根据需求选择
5. **定期清理** - 删除旧的构建文件

## 相关资源

- [Verilator 官方文档](https://verilator.org/guide/latest/)
- [Verilator GitHub](https://github.com/verilator/verilator)
- [Chisel-Verilator 集成](https://www.chisel-lang.org/chisel3/docs/explanations/simulation.html)

---
**最后更新**: 2025-11-28
