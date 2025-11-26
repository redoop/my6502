# CPU6502 模块化架构设计文档

## 1. 背景

当前 `CPU6502.scala` 文件约 1100 行，所有指令实现集中在一个巨大的 `switch(opcode)` 语句中，存在以下问题：

- 代码难以维护和阅读
- 无法对单个指令类型进行独立测试
- 新增指令需要修改核心文件
- 寻址模式逻辑重复

## 2. 目标架构

```
src/main/scala/cpu/
├── core/
│   ├── CPU6502Core.scala      # 主控制器：状态机、指令分发
│   ├── Registers.scala        # 寄存器定义
│   ├── MemoryInterface.scala  # 内存接口定义
│   └── DebugBundle.scala      # 调试接口
├── instructions/
│   ├── InstructionExecutor.scala  # 指令执行器基础 trait
│   ├── LoadStore.scala        # LDA, LDX, LDY, STA, STX, STY
│   ├── Arithmetic.scala       # ADC, SBC, INC, DEC, INX, INY, DEX, DEY
│   ├── Logic.scala            # AND, ORA, EOR, BIT
│   ├── Shift.scala            # ASL, LSR, ROL, ROR
│   ├── Branch.scala           # BEQ, BNE, BCS, BCC, BMI, BPL, BVC, BVS
│   ├── Jump.scala             # JMP, JSR, RTS, BRK, RTI
│   ├── Compare.scala          # CMP, CPX, CPY
│   ├── Transfer.scala         # TAX, TAY, TXA, TYA, TSX, TXS
│   ├── Stack.scala            # PHA, PHP, PLA, PLP
│   └── Flag.scala             # CLC, SEC, CLD, SED, CLI, SEI, CLV, NOP
├── addressing/
│   └── AddressingModes.scala  # 寻址模式逻辑复用
└── CPU6502.scala              # 顶层模块，组装所有组件
```

## 3. 核心接口设计

### 3.1 寄存器 Bundle

```scala
class Registers extends Bundle {
  val a  = UInt(8.W)   // 累加器
  val x  = UInt(8.W)   // X 索引
  val y  = UInt(8.W)   // Y 索引
  val sp = UInt(8.W)   // 栈指针
  val pc = UInt(16.W)  // 程序计数器
  
  // 状态标志
  val flagC = Bool()   // Carry
  val flagZ = Bool()   // Zero
  val flagI = Bool()   // Interrupt Disable
  val flagD = Bool()   // Decimal Mode
  val flagB = Bool()   // Break
  val flagV = Bool()   // Overflow
  val flagN = Bool()   // Negative
}
```

### 3.2 内存接口

```scala
class MemoryInterface extends Bundle {
  val addr    = Output(UInt(16.W))
  val dataOut = Output(UInt(8.W))
  val dataIn  = Input(UInt(8.W))
  val write   = Output(Bool())
  val read    = Output(Bool())
}
```

### 3.3 指令执行结果

```scala
class ExecutionResult extends Bundle {
  val done      = Bool()           // 指令执行完成
  val nextCycle = UInt(3.W)        // 下一周期
  val regsOut   = new Registers    // 更新后的寄存器
  val memAddr   = UInt(16.W)       // 内存地址
  val memData   = UInt(8.W)        // 写入数据
  val memWrite  = Bool()           // 写使能
  val memRead   = Bool()           // 读使能
}
```

### 3.4 指令执行器 Trait

```scala
trait InstructionExecutor {
  def opcodes: Seq[Int]  // 该执行器处理的 opcode 列表
  
  def execute(
    opcode: UInt,
    cycle: UInt,
    operand: UInt,
    regs: Registers,
    memDataIn: UInt
  ): ExecutionResult
}
```

## 4. 指令分类

| 模块 | 指令 | Opcodes |
|------|------|---------|
| LoadStore | LDA, LDX, LDY, STA, STX, STY | 0xA9, 0xA5, 0xAD, 0xB5, 0xBD, 0xB9, 0xA2, 0xA0, 0x85, 0x8D, 0x95, 0x86, 0x84 |
| Arithmetic | ADC, SBC, INC, DEC, INX, INY, DEX, DEY | 0x69, 0xE9, 0xE6, 0xC6, 0xE8, 0xC8, 0xCA, 0x88, 0x1A, 0x3A |
| Logic | AND, ORA, EOR, BIT | 0x29, 0x09, 0x49, 0x24 |
| Shift | ASL, LSR, ROL, ROR | 0x0A, 0x06, 0x4A, 0x46, 0x2A, 0x26, 0x6A, 0x66 |
| Branch | BEQ, BNE, BCS, BCC, BMI, BPL, BVC, BVS | 0xF0, 0xD0, 0xB0, 0x90, 0x30, 0x10, 0x50, 0x70 |
| Jump | JMP, JSR, RTS, BRK, RTI | 0x4C, 0x20, 0x60, 0x00, 0x40 |
| Compare | CMP, CPX, CPY | 0xC9, 0xC5, 0xE0, 0xC0 |
| Transfer | TAX, TAY, TXA, TYA, TSX, TXS | 0xAA, 0xA8, 0x8A, 0x98, 0xBA, 0x9A |
| Stack | PHA, PHP, PLA, PLP | 0x48, 0x08, 0x68, 0x28 |
| Flag | CLC, SEC, CLD, SED, CLI, SEI, CLV, NOP | 0x18, 0x38, 0xD8, 0xF8, 0x58, 0x78, 0xB8, 0xEA |

## 5. 寻址模式复用

```scala
object AddressingModes {
  // 立即寻址
  def immediate(pc: UInt, memDataIn: UInt): (UInt, UInt) = {
    (memDataIn, pc + 1.U)
  }
  
  // 零页寻址
  def zeroPage(cycle: UInt, pc: UInt, memDataIn: UInt, operand: UInt): AddressResult
  
  // 零页 X 索引
  def zeroPageX(cycle: UInt, pc: UInt, memDataIn: UInt, operand: UInt, x: UInt): AddressResult
  
  // 绝对寻址
  def absolute(cycle: UInt, pc: UInt, memDataIn: UInt, operand: UInt): AddressResult
  
  // 绝对 X 索引
  def absoluteX(cycle: UInt, pc: UInt, memDataIn: UInt, operand: UInt, x: UInt): AddressResult
  
  // 绝对 Y 索引
  def absoluteY(cycle: UInt, pc: UInt, memDataIn: UInt, operand: UInt, y: UInt): AddressResult
}
```

## 6. 测试策略

每个指令模块可独立测试：

```
src/test/scala/cpu/
├── core/
│   └── RegistersSpec.scala
├── instructions/
│   ├── LoadStoreSpec.scala
│   ├── ArithmeticSpec.scala
│   ├── LogicSpec.scala
│   ├── ShiftSpec.scala
│   ├── BranchSpec.scala
│   ├── JumpSpec.scala
│   ├── CompareSpec.scala
│   ├── TransferSpec.scala
│   ├── StackSpec.scala
│   └── FlagSpec.scala
├── addressing/
│   └── AddressingModesSpec.scala
└── CPU6502Spec.scala          # 集成测试
```

## 7. 实现步骤

1. **Phase 1**: 创建核心接口
   - `Registers.scala`
   - `MemoryInterface.scala`
   - `DebugBundle.scala`
   - `InstructionExecutor.scala`

2. **Phase 2**: 迁移简单指令
   - `Flag.scala` (最简单，无内存操作)
   - `Transfer.scala` (寄存器间传输)

3. **Phase 3**: 迁移单周期指令
   - `Arithmetic.scala` (立即寻址部分)
   - `Logic.scala`
   - `Shift.scala` (累加器模式)

4. **Phase 4**: 迁移多周期指令
   - `LoadStore.scala`
   - `Compare.scala`
   - `Branch.scala`

5. **Phase 5**: 迁移复杂指令
   - `Stack.scala`
   - `Jump.scala`

6. **Phase 6**: 重构主模块
   - `CPU6502Core.scala` 指令分发
   - `AddressingModes.scala` 寻址逻辑复用
   - `CPU6502.scala` 顶层组装

## 8. 预期收益

| 指标 | 重构前 | 重构后 |
|------|--------|--------|
| 单文件行数 | ~1100 | ~150 (主模块) |
| 可测试性 | 仅集成测试 | 单元测试 + 集成测试 |
| 新增指令 | 修改核心文件 | 仅修改对应模块 |
| 代码复用 | 寻址逻辑重复 | 寻址模式统一复用 |
