# Chisel 6502 CPU

这是一个使用 Chisel 硬件描述语言实现的 6502 CPU。

## 功能特性

### 已实现的指令

**加载/存储指令:**
- LDA (Load Accumulator) - Immediate, Zero Page
- LDX (Load X Register) - Immediate
- LDY (Load Y Register) - Immediate
- STA (Store Accumulator) - Zero Page

**算术指令:**
- ADC (Add with Carry) - Immediate
- SBC (Subtract with Carry) - Immediate

**逻辑指令:**
- AND (Logical AND) - Immediate
- ORA (Logical OR) - Immediate
- EOR (Exclusive OR) - Immediate

**增减指令:**
- INX (Increment X)
- INY (Increment Y)
- DEX (Decrement X)
- DEY (Decrement Y)

**传送指令:**
- TAX (Transfer A to X)
- TAY (Transfer A to Y)
- TXA (Transfer X to A)
- TYA (Transfer Y to A)

**标志位操作:**
- CLC (Clear Carry)
- SEC (Set Carry)
- CLD (Clear Decimal)
- SED (Set Decimal)
- CLI (Clear Interrupt)
- SEI (Set Interrupt)
- CLV (Clear Overflow)

**控制流指令:**
- JMP (Jump) - Absolute
- BEQ (Branch if Equal)
- BNE (Branch if Not Equal)
- BCS (Branch if Carry Set)
- BCC (Branch if Carry Clear)
- NOP (No Operation)

### CPU 寄存器

- A: 累加器 (8-bit)
- X: X 索引寄存器 (8-bit)
- Y: Y 索引寄存器 (8-bit)
- SP: 栈指针 (8-bit)
- PC: 程序计数器 (16-bit)
- P: 状态寄存器 (标志位)
  - C: Carry (进位)
  - Z: Zero (零)
  - I: Interrupt Disable (中断禁用)
  - D: Decimal Mode (十进制模式)
  - B: Break (断点)
  - V: Overflow (溢出)
  - N: Negative (负数)

## 项目结构

```
.
├── build.sbt                          # SBT 构建配置
├── project/
│   ├── build.properties               # SBT 版本
│   └── plugins.sbt                    # SBT 插件
├── src/
│   ├── main/scala/cpu6502/
│   │   ├── CPU6502.scala             # CPU 核心实现
│   │   ├── Memory.scala              # 内存模块
│   │   └── Top.scala                 # 顶层模块
│   └── test/scala/cpu6502/
│       └── CPU6502Test.scala         # 测试用例
└── README.md
```

## 使用方法

### 前置要求

- Java 8 或更高版本
- SBT (Scala Build Tool)

### 编译项目

```bash
sbt compile
```

### 运行测试

```bash
sbt test
```

### 生成 Verilog

```bash
sbt "runMain cpu6502.Top"
```

生成的 Verilog 文件将位于 `generated/` 目录。

## 架构说明

### 状态机

CPU 使用简单的三状态状态机：
1. **Fetch**: 从内存读取指令
2. **DecodeExecute**: 解码并执行指令
3. **Done**: 完成状态（保留用于扩展）

### 内存接口

CPU 通过以下信号与内存交互：
- `memAddr`: 16-bit 地址总线
- `memDataOut`: 8-bit 数据输出
- `memDataIn`: 8-bit 数据输入
- `memWrite`: 写使能信号
- `memRead`: 读使能信号

### 调试接口

CPU 提供调试接口，可以观察内部状态：
- 所有寄存器值 (A, X, Y, PC, SP)
- 所有标志位 (C, Z, N, V)
- 当前操作码

## 扩展建议

这是一个基础实现，可以通过以下方式扩展：

1. **更多寻址模式**: 添加 Absolute, Indexed, Indirect 等寻址模式
2. **完整指令集**: 实现所有 56 条官方指令
3. **中断处理**: 实现 IRQ, NMI, RESET 中断
4. **栈操作**: 实现 PHA, PLA, PHP, PLP 等栈指令
5. **子程序调用**: 实现 JSR, RTS 指令
6. **性能优化**: 优化时序和周期精确性
7. **总线接口**: 添加更真实的总线协议

## 参考资料

- [6502 指令集参考](http://www.6502.org/tutorials/6502opcodes.html)
- [Chisel 文档](https://www.chisel-lang.org/)
- [6502 编程手册](http://archive.6502.org/books/mcs6500_family_programming_manual.pdf)

## 许可证

MIT License
