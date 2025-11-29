# NES 模拟器分阶段测试构建指南

自下而上的测试构建方法，确保每个阶段都能正常工作后再进入下一阶段。

## 架构层次

```
┌─────────────────────────────────────┐
│  Stage 5: 完整游戏运行               │  ← bash scripts/run.sh
├─────────────────────────────────────┤
│  Stage 4: NES 系统集成               │  ← NESSystemRefactored
├─────────────────────────────────────┤
│  Stage 3: 子系统测试                 │  ← CPU + PPU + APU
├─────────────────────────────────────┤
│  Stage 2: 指令集测试                 │  ← CPU 指令
├─────────────────────────────────────┤
│  Stage 1: 基础模块测试               │  ← 寄存器、ALU
└─────────────────────────────────────┘
```

---

## Stage 1: 基础模块测试 (Foundation)

### 目标
验证 CPU 核心组件的基本功能。

### 测试内容

#### 1.1 寄存器测试
```bash
# 测试 CPU 寄存器读写
sbt "testOnly cpu6502.core.CPU6502CoreSpec -- -z \"register\""
```

**验证点**:
- ✅ A, X, Y 寄存器读写
- ✅ PC (程序计数器) 递增
- ✅ SP (栈指针) 操作
- ✅ 状态标志位 (C, Z, N, V, I, D)

#### 1.2 内存接口测试
```bash
# 测试内存读写
sbt "testOnly cpu6502.core.CPU6502CoreSpec -- -z \"memory\""
```

**验证点**:
- ✅ 内存读操作
- ✅ 内存写操作
- ✅ 地址总线 (16-bit)
- ✅ 数据总线 (8-bit)

### 问题排查

**问题**: 寄存器值不正确
```scala
// 检查 Registers.scala
// 确保初始化正确
val regs_a = RegInit(0.U(8.W))
```

**问题**: 内存访问失败
```scala
// 检查 MemoryInterface.scala
// 确保读写信号正确
io.memRead := state === sRead
io.memWrite := state === sWrite
```

---

## Stage 2: 指令集测试 (Instructions)

### 目标
验证所有 6502 指令的正确实现。

### 测试内容

#### 2.1 数据传输指令
```bash
# 测试 LDA, LDX, LDY, STA, STX, STY
sbt "testOnly cpu6502.instructions.LoadStoreInstructionsSpec"
```

**验证点**:
- ✅ LDA (Load Accumulator)
- ✅ LDX (Load X)
- ✅ LDY (Load Y)
- ✅ STA (Store Accumulator)
- ✅ STX (Store X)
- ✅ STY (Store Y)

#### 2.2 算术指令
```bash
# 测试 ADC, SBC, INC, DEC
sbt "testOnly cpu6502.instructions.ArithmeticInstructionsSpec"
```

**验证点**:
- ✅ ADC (Add with Carry)
- ✅ SBC (Subtract with Carry)
- ✅ INC/DEC (Increment/Decrement)
- ✅ 进位标志正确
- ✅ 溢出标志正确

#### 2.3 逻辑指令
```bash
# 测试 AND, ORA, EOR
sbt "testOnly cpu6502.instructions.LogicInstructionsSpec"
```

#### 2.4 移位指令
```bash
# 测试 ASL, LSR, ROL, ROR
sbt "testOnly cpu6502.instructions.ShiftInstructionsSpec"
```

#### 2.5 分支指令
```bash
# 测试 BEQ, BNE, BCS, BCC, BMI, BPL, BVS, BVC
sbt "testOnly cpu6502.instructions.BranchInstructionsSpec"
```

#### 2.6 跳转指令
```bash
# 测试 JMP, JSR, RTS
sbt "testOnly cpu6502.instructions.JumpInstructionsSpec"
```

#### 2.7 栈操作
```bash
# 测试 PHA, PLA, PHP, PLP
sbt "testOnly cpu6502.instructions.StackInstructionsSpec"
```

#### 2.8 标志位操作
```bash
# 测试 CLC, SEC, CLI, SEI, CLV, CLD, SED
sbt "testOnly cpu6502.instructions.FlagInstructionsSpec"
```

### 运行所有指令测试
```bash
sbt "testOnly cpu6502.instructions.*"
```

### 问题排查

**问题**: 指令执行错误
```bash
# 查看具体失败的指令
sbt "testOnly cpu6502.instructions.ArithmeticInstructionsSpec -- -oF"
```

**问题**: 标志位不正确
```scala
// 检查 Flag.scala
// 确保标志位更新逻辑正确
when(opcode === 0x18.U) { // CLC
  regs.flag_c := false.B
}
```

---

## Stage 3: 子系统测试 (Subsystems)

### 目标
验证 CPU、PPU、APU 各子系统独立工作。

### 3.1 CPU 集成测试
```bash
# 测试 CPU 完整程序执行
sbt "testOnly cpu6502.core.CPU6502CoreSpec"
```

**验证点**:
- ✅ 多指令序列执行
- ✅ 子程序调用 (JSR/RTS)
- ✅ 中断处理 (BRK/RTI)
- ✅ 循环和分支

**测试程序示例**:
```assembly
LDA #$10      ; 加载立即数
STA $0200     ; 存储到内存
LDX #$05      ; 循环计数器
loop:
  DEX         ; 递减
  BNE loop    ; 不为零则跳转
```

### 3.2 PPU 渲染测试
```bash
# 测试 PPU 渲染管线
sbt "testOnly nes.ppu.PPURenderSpec"
```

**验证点**:
- ✅ 背景渲染
- ✅ 精灵渲染
- ✅ 调色板
- ✅ 滚动
- ✅ VBlank 中断

### 3.3 内存控制器测试
```bash
# 测试内存映射
sbt "testOnly nes.MemoryControllerSpec"
```

**验证点**:
- ✅ CPU 内存映射 ($0000-$FFFF)
- ✅ PPU 寄存器映射 ($2000-$2007)
- ✅ ROM 映射
- ✅ RAM 镜像

### 问题排查

**问题**: CPU 卡在循环
```bash
# 使用调试工具监控 PC
./scripts/debug.sh monitor pc
```

**问题**: PPU 不渲染
```bash
# 检查 PPU 寄存器
./scripts/debug.sh monitor ppu
```

---

## Stage 4: NES 系统集成测试 (Integration)

### 目标
验证 CPU、PPU、APU、内存控制器协同工作。

### 4.1 快速集成测试
```bash
# 运行快速集成测试
sbt "testOnly nes.NESIntegrationQuickSpec"
```

**验证点**:
- ✅ CPU 和 PPU 通信
- ✅ NMI 中断触发
- ✅ PPU 寄存器读写
- ✅ 基本渲染

### 4.2 完整集成测试
```bash
# 运行完整集成测试
sbt "testOnly nes.NESIntegrationSpec"
```

**验证点**:
- ✅ ROM 加载
- ✅ Reset 向量
- ✅ NMI 向量
- ✅ 多帧渲染
- ✅ 控制器输入

### 4.3 游戏兼容性测试
```bash
# 快速兼容性测试
sbt "testOnly nes.GameCompatibilityQuickSpec"

# 完整兼容性测试
sbt "testOnly nes.GameCompatibilitySpec"
```

### 问题排查

**问题**: NMI 不触发
```bash
# 监控 NMI 信号
./scripts/debug.sh monitor nmi
```

**问题**: ROM 加载失败
```bash
# 分析 ROM 文件
./scripts/debug.sh opcodes games/Donkey-Kong.nes
```

---

## Stage 5: Verilator 硬件仿真 (Hardware Simulation)

### 目标
在 Verilator 中运行完整游戏。

### 5.1 生成 Verilog
```bash
# 生成 Verilog 代码
./scripts/tools.sh generate
```

**验证点**:
- ✅ Verilog 文件生成成功
- ✅ 模块名正确 (NESSystemRefactored)
- ✅ 接口信号完整

### 5.2 编译 Verilator
```bash
# 快速编译（推荐）
./scripts/build.sh fast

# 带追踪的编译（调试用）
./scripts/build.sh trace
```

**验证点**:
- ✅ Verilator 编译成功
- ✅ C++ testbench 编译成功
- ✅ 可执行文件生成

### 5.3 运行游戏
```bash
# 交互式选择游戏
./scripts/run.sh

# 直接运行指定游戏
./scripts/run.sh games/Donkey-Kong.nes
```

**验证点**:
- ✅ ROM 加载成功
- ✅ CPU 启动正常
- ✅ 画面显示
- ✅ 控制器响应
- ✅ FPS 稳定 (30-40)

### 问题排查

**问题**: 编译失败
```bash
# 检查环境
./scripts/tools.sh check

# 查看详细错误
./scripts/build.sh fast 2>&1 | grep error
```

**问题**: 游戏黑屏
```bash
# 检查 ROM 加载
./scripts/debug.sh opcodes games/Donkey-Kong.nes

# 监控 PC 执行
./scripts/debug.sh monitor pc
```

**问题**: 性能低
```bash
# 使用快速模式
./scripts/build.sh fast

# 检查 CPU 是否卡在循环
./scripts/debug.sh monitor pc
```

---

## 完整测试流程

### 一键运行所有测试
```bash
# 运行所有 Scala 测试
./scripts/test.sh all

# 或分阶段测试
./scripts/test.sh unit          # Stage 1-2
./scripts/test.sh integration   # Stage 3-4
./scripts/test.sh quick         # 快速测试
```

### 完整构建和运行流程
```bash
# 1. 检查环境
./scripts/tools.sh check

# 2. 清理旧构建
./scripts/tools.sh clean

# 3. 运行单元测试
./scripts/test.sh unit

# 4. 运行集成测试
./scripts/test.sh integration

# 5. 生成 Verilog
./scripts/tools.sh generate

# 6. 编译 Verilator
./scripts/build.sh fast

# 7. 运行游戏
./scripts/run.sh
```

---

## 调试工具

### 分析工具
```bash
# ROM 指令分析
./scripts/debug.sh opcodes <rom>

# VCD 波形分析
./scripts/debug.sh vcd

# 晶体管统计
./scripts/debug.sh transistors

# 执行追踪
./scripts/debug.sh execution
```

### 监控工具
```bash
# 监控 PC
./scripts/debug.sh monitor pc

# 监控 PPU
./scripts/debug.sh monitor ppu

# 监控 NMI
./scripts/debug.sh monitor nmi
```

### 项目工具
```bash
# 项目统计
./scripts/tools.sh stats

# ROM 信息
./scripts/tools.sh rom

# 创建归档
./scripts/tools.sh archive
```

---

## 常见问题解决

### 问题 1: 测试失败
```bash
# 查看详细错误
sbt "testOnly <TestClass> -- -oF"

# 只运行失败的测试
sbt testQuick
```

### 问题 2: 编译错误
```bash
# 清理并重新编译
sbt clean compile

# 查看依赖
sbt dependencyTree
```

### 问题 3: Verilator 错误
```bash
# 检查 Verilator 版本
verilator --version

# 重新生成 Verilog
./scripts/tools.sh generate
./scripts/build.sh fast
```

### 问题 4: 游戏不运行
```bash
# 检查 ROM 文件
ls -lh games/

# 分析 ROM
./scripts/debug.sh opcodes games/Donkey-Kong.nes

# 监控执行
./scripts/debug.sh monitor pc
```

---

## 成功标准

### Stage 1 ✅
- 所有寄存器测试通过
- 内存接口正常工作

### Stage 2 ✅
- 所有指令测试通过 (122+ tests)
- 标志位正确更新

### Stage 3 ✅
- CPU 能执行完整程序
- PPU 能渲染画面
- 内存映射正确

### Stage 4 ✅
- NES 系统集成测试通过
- 游戏兼容性测试通过

### Stage 5 ✅
- Verilator 编译成功
- 游戏能正常运行
- FPS 稳定在 30-40

---

## 项目状态

当前状态: **Stage 5 完成** ✅

```
✅ Stage 1: 基础模块测试 (100%)
✅ Stage 2: 指令集测试 (100% - 122+ tests passing)
✅ Stage 3: 子系统测试 (100%)
✅ Stage 4: NES 系统集成 (100%)
✅ Stage 5: Verilator 仿真 (100%)
```

**游戏运行状态**:
- ✅ Donkey Kong - 可玩
- ✅ Super Mario Bros - 可玩
- ✅ Super Contra X - 可玩

---

## 快速参考

```bash
# 完整测试
./scripts/test.sh all

# 快速构建
./scripts/build.sh fast

# 运行游戏
./scripts/run.sh

# 调试分析
./scripts/debug.sh opcodes games/Donkey-Kong.nes
```

**文档**: [scripts/README.md](../scripts/README.md)
