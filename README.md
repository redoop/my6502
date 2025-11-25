# Chisel 6502 CPU

这是一个使用 Chisel 硬件描述语言实现的 MOS 6502 CPU。

## 关于 MOS 6502

MOS 6502 是由 MOS Technology 在 1975 年设计的 8 位微处理器，是计算机历史上最具影响力的处理器之一。

<div align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/MOS_6502AD_4585_top.jpg/600px-MOS_6502AD_4585_top.jpg" alt="MOS 6502 芯片" width="400"/>
  <p><i>MOS 6502 微处理器芯片</i></p>
</div>

### 在线资源

- 🔬 **Visual 6502 模拟器**: [在线体验 6502 芯片运行](http://www.visual6502.org/JSSim/index.html) - 可视化晶体管级模拟器，实时观察芯片内部运作


### 历史背景

- **发布时间**: 1975 年
- **设计者**: Chuck Peddle 和 Bill Mensch
- **制造商**: MOS Technology (后被 Commodore 收购)
- **价格优势**: 发布时售价仅 $25，而竞争对手 Intel 8080 和 Motorola 6800 售价约 $179

### 经典应用

6502 处理器被广泛应用于 1970-1980 年代的众多经典计算机和游戏机：

**个人电脑:**
- Apple I (1976)
- Apple II 系列 (1977-1993)
- Commodore PET (1977)
- Commodore 64 (1982) - 史上最畅销的个人电脑
- Commodore VIC-20 (1980)
- BBC Micro (1981)
- Atari 8-bit 系列 (400/800)

**游戏机:**
- Atari 2600 (使用 6507 变体)
- Nintendo Entertainment System / Famicom (使用 2A03 变体)
- Atari Lynx (使用 65SC02)

### 技术特点

- **8 位数据总线** / **16 位地址总线** (64KB 寻址空间)
- **3 个通用寄存器**: A (累加器), X, Y (索引寄存器)
- **简洁的指令集**: 56 条官方指令
- **多种寻址模式**: 13 种寻址模式
- **低功耗**: NMOS 工艺，功耗远低于同时代处理器
- **高性能**: 1-7 个时钟周期/指令
- **时钟频率**: 1-2 MHz (典型)

### 架构图

```
                    MOS 6502 架构
    ┌─────────────────────────────────────────┐
    │                                         │
    │  ┌─────────┐  ┌─────────┐  ┌─────────┐ │
    │  │    A    │  │    X    │  │    Y    │ │  寄存器
    │  │ (8-bit) │  │ (8-bit) │  │ (8-bit) │ │
    │  └─────────┘  └─────────┘  └─────────┘ │
    │                                         │
    │  ┌─────────────────────────────────┐   │
    │  │         ALU (算术逻辑单元)        │   │
    │  └─────────────────────────────────┘   │
    │                                         │
    │  ┌─────────┐              ┌─────────┐  │
    │  │   PC    │              │   SP    │  │  控制寄存器
    │  │(16-bit) │              │ (8-bit) │  │
    │  └─────────┘              └─────────┘  │
    │                                         │
    │  ┌─────────────────────────────────┐   │
    │  │  P (状态寄存器 - 8 flags)       │   │
    │  │  N V - B D I Z C                │   │
    │  └─────────────────────────────────┘   │
    │                                         │
    │  ┌─────────────────────────────────┐   │
    │  │      指令解码器 & 控制逻辑       │   │
    │  └─────────────────────────────────┘   │
    │                                         │
    └─────────────────────────────────────────┘
              ↕                    ↕
         数据总线 (8-bit)    地址总线 (16-bit)
```

### 为什么选择 6502？

1. **教学价值**: 架构简洁，易于理解和实现
2. **历史意义**: 推动了个人计算机革命
3. **文档完善**: 大量的技术文档和社区资源
4. **实用性**: 至今仍在嵌入式系统中使用
5. **怀旧情怀**: 复古计算和游戏开发的热门选择

## 项目状态
- ✅ 编译通过
- ✅ 所有测试通过 (6/6)
- ✅ 使用阿里云镜像加速构建

### 在线资源

- 📖 **详细架构文档**: [MOS 6502 架构详解](docs/6502-architecture.md)


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
│   ├── main/scala/cpu/
│   │   ├── CPU6502.scala             # CPU 核心实现
│   │   ├── Memory.scala              # 内存模块
│   │   └── MyCpu6502.scala           # 顶层模块
│   └── test/scala/cpu/
│       └── CPU6502Test.scala         # 测试用例
└── README.mdPU6502T
```est.scala         # 主测试套件
│       └── DebugTest.scala           # 调试测试
├── generated/
│   └─
## 快速开始Cpu6502.v                   # 生成的 Verilog
└── README.md

### 前置要求

- Java 8 或更高版本
- SBT (Scala Build Tool)

### 编译和测试

```bash
# 编译项目
sbt compile

# 运行测试 (6 个测试用例全部通过)
sbt test

# 生成 Verilog
sbt "runMain cpu6502.MyCpu6502"
```

生成的 Verilog 文件将位于 `generated/` 目录。

### 生成的 Verilog 信息

- **顶层模块名**: `MyCpu6502`
- **时钟信号**: `clock`
- **复位信号**: `reset`
- **文件位置**: `generated/MyCpu6502.v`

### 测试覆盖

- ✅ LDA immediate 指令测试
- ✅ ADC 指令和进位标志测试
- ✅ INX 增量指令测试
- ✅ 寄存器传送指令测试 (TAX, TAY)
- ✅ 分支指令测试 (BEQ)
- ✅ 调试接口测试

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

## 技术亮点

1. **状态机设计**: 简洁的 Fetch-Decode-Execute 流水线
2. **寻址模式**: 支持 Immediate 和 Zero Page 寻址
3. **标志位处理**: 正确实现进位、溢出、零、负数标志
4. **可扩展架构**: 易于添加更多指令和寻址模式
5. **完整测试**: 包含调试接口和全面的测试用例

## 后续扩展建议

这是一个基础但功能完整的实现，可以通过以下方式扩展：

1. **更多寻址模式**: 添加 Absolute, Indexed, Indirect 等寻址模式
2. **完整指令集**: 实现所有 56 条官方指令
3. **中断处理**: 实现 IRQ, NMI, RESET 中断
4. **栈操作**: 实现 PHA, PLA, PHP, PLP 等栈指令
5. **子程序调用**: 实现 JSR, RTS 指令
6. **性能优化**: 优化时序和周期精确性
7. **总线接口**: 添加更真实的总线协议

## 文档

- 📖 [MOS 6502 架构详解](docs/6502-architecture.md) - 寄存器、寻址模式、指令集详细说明

## 参考资料

- [6502 指令集参考](http://www.6502.org/tutorials/6502opcodes.html)
- [Chisel 文档](https://www.chisel-lang.org/)
- [6502 编程手册](http://archive.6502.org/books/mcs6500_family_programming_manual.pdf)
- [Visual 6502](http://www.visual6502.org/) - 可视化 6502 芯片模拟器
- [6502.org](http://www.6502.org/) - 6502 社区和资源

## 许可证

MIT License
