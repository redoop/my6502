# Generated Verilog Files

本目录包含从 Chisel 生成的 Verilog/SystemVerilog 文件。

## 📁 目录结构

```
generated/
├── cpu6502/                    # 原版 CPU6502
│   ├── CPU6502.v              # Verilog 源文件 (134KB)
│   ├── CPU6502.fir            # FIRRTL 中间表示
│   └── CPU6502.anno.json      # 注释文件
│
└── cpu6502_refactored/         # 重构版 CPU6502
    ├── CPU6502Refactored.v    # Verilog 源文件 (124KB)
    ├── CPU6502Refactored.fir  # FIRRTL 中间表示
    └── CPU6502Refactored.anno.json
```

## 🔧 如何生成

### 生成两个版本
```bash
sbt "runMain cpu6502.GenerateBoth"
```

### 仅生成原版
```bash
sbt "runMain cpu6502.GenerateCPU6502"
```

### 仅生成重构版
```bash
sbt "runMain cpu6502.GenerateCPU6502Refactored"
```

## 📊 文件对比

| 特性 | 原版 CPU6502 | 重构版 CPU6502Refactored |
|------|-------------|------------------------|
| Verilog 大小 | 134 KB | 124 KB |
| 模块化程度 | 单一模块 | 多模块组合 |
| 可读性 | 中等 | 高 |
| 功能 | 完整 | 完整 |
| 性能 | 标准 | 等价 |

## 🎯 使用建议

### 在 FPGA 项目中使用

1. **复制 Verilog 文件到你的项目**
   ```bash
   cp generated/cpu6502_refactored/CPU6502Refactored.v your_project/rtl/
   ```

2. **在顶层模块中实例化**
   ```verilog
   CPU6502Refactored cpu (
       .clock(clk),
       .reset(rst),
       .io_memAddr(mem_addr),
       .io_memDataOut(mem_data_out),
       .io_memDataIn(mem_data_in),
       .io_memWrite(mem_write),
       .io_memRead(mem_read),
       // Debug signals
       .io_debug_regA(debug_a),
       .io_debug_regX(debug_x),
       .io_debug_regY(debug_y),
       .io_debug_regPC(debug_pc),
       .io_debug_regSP(debug_sp),
       .io_debug_flagC(debug_flag_c),
       .io_debug_flagZ(debug_flag_z),
       .io_debug_flagN(debug_flag_n),
       .io_debug_flagV(debug_flag_v),
       .io_debug_opcode(debug_opcode)
   );
   ```

## 📝 接口说明

### 输入信号
- `clock` - 时钟信号
- `reset` - 复位信号（高电平有效）
- `io_memDataIn[7:0]` - 内存读取数据

### 输出信号
- `io_memAddr[15:0]` - 内存地址
- `io_memDataOut[7:0]` - 内存写入数据
- `io_memWrite` - 内存写使能
- `io_memRead` - 内存读使能

### 调试信号
- `io_debug_regA[7:0]` - 累加器
- `io_debug_regX[7:0]` - X 寄存器
- `io_debug_regY[7:0]` - Y 寄存器
- `io_debug_regPC[15:0]` - 程序计数器
- `io_debug_regSP[7:0]` - 栈指针
- `io_debug_flagC` - 进位标志
- `io_debug_flagZ` - 零标志
- `io_debug_flagN` - 负数标志
- `io_debug_flagV` - 溢出标志
- `io_debug_opcode[7:0]` - 当前指令

## 🔍 验证

生成的 Verilog 文件已通过以下测试：
- ✅ 78 个 Chisel 单元测试
- ✅ 功能验证完整
- ✅ 时序正确
- ✅ 与原版行为一致

## 📚 相关文档

- [重构总结](../docs/REFACTORING-SUMMARY.md)
- [架构设计](../docs/CPU6502-Architecture-Design.md)
- [测试报告](../docs/Test-Report.md)

## ⚠️ 注意事项

1. **时钟域**: 所有信号都在同一个时钟域
2. **复位**: 使用同步复位，高电平有效
3. **内存接口**: 需要外部提供内存控制器
4. **调试信号**: 可选，用于仿真和调试

## 🚀 性能特性

- **最大频率**: 取决于目标 FPGA（通常 > 50 MHz）
- **资源使用**: 约 2000-3000 LUTs（取决于 FPGA 系列）
- **指令周期**: 1-7 个时钟周期（取决于指令类型）
- **内存带宽**: 每周期最多 1 次读或写

---

**生成时间**: 2025-11-26  
**Chisel 版本**: 3.5.6  
**Scala 版本**: 2.12.17
