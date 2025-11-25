# MOS 6502 架构详解

## 寄存器组

### 通用寄存器
- **A (Accumulator)**: 8-bit 累加器，用于算术和逻辑运算
- **X (Index Register X)**: 8-bit 索引寄存器，用于索引寻址
- **Y (Index Register Y)**: 8-bit 索引寄存器，用于索引寻址

### 控制寄存器
- **PC (Program Counter)**: 16-bit 程序计数器，指向下一条指令
- **SP (Stack Pointer)**: 8-bit 栈指针，指向栈顶 (0x0100-0x01FF)
- **P (Processor Status)**: 8-bit 状态寄存器

## 状态标志位 (P 寄存器)

```
  7  6  5  4  3  2  1  0
┌───┬───┬───┬───┬───┬───┬───┬───┐
│ N │ V │ - │ B │ D │ I │ Z │ C │
└───┴───┴───┴───┴───┴───┴───┴───┘
```

- **N (Negative)**: 结果为负数 (bit 7 = 1)
- **V (Overflow)**: 有符号溢出
- **- (Unused)**: 未使用，总是 1
- **B (Break)**: BRK 指令标志
- **D (Decimal)**: BCD 十进制模式
- **I (Interrupt Disable)**: 中断禁用
- **Z (Zero)**: 结果为零
- **C (Carry)**: 进位/借位

## 内存映射

```
0xFFFF ┌─────────────────┐
       │  中断向量表      │
0xFFFA ├─────────────────┤
       │                 │
       │   ROM / RAM     │
       │                 │
0x0200 ├─────────────────┤
       │   栈空间        │
0x0100 ├─────────────────┤
       │   零页          │
0x0000 └─────────────────┘
```

## 寻址模式

1. **Implied**: 隐含寻址 (如 TAX)
2. **Accumulator**: 累加器寻址 (如 ASL A)
3. **Immediate**: 立即数寻址 (如 LDA #$42)
4. **Zero Page**: 零页寻址 (如 LDA $42)
5. **Zero Page,X**: 零页 X 索引 (如 LDA $42,X)
6. **Zero Page,Y**: 零页 Y 索引 (如 LDX $42,Y)
7. **Absolute**: 绝对寻址 (如 LDA $1234)
8. **Absolute,X**: 绝对 X 索引 (如 LDA $1234,X)
9. **Absolute,Y**: 绝对 Y 索引 (如 LDA $1234,Y)
10. **Indirect**: 间接寻址 (如 JMP ($1234))
11. **Indexed Indirect**: 索引间接 (如 LDA ($42,X))
12. **Indirect Indexed**: 间接索引 (如 LDA ($42),Y)
13. **Relative**: 相对寻址 (用于分支指令)

## 指令周期

大多数指令需要 2-7 个时钟周期：

- **2 周期**: 隐含/立即数指令 (如 TAX, LDA #$42)
- **3 周期**: 零页读取 (如 LDA $42)
- **4 周期**: 绝对寻址读取 (如 LDA $1234)
- **5-7 周期**: 复杂寻址模式或写操作

## 中断处理

6502 支持三种中断：

1. **RESET**: 硬件复位 (向量: 0xFFFC-0xFFFD)
2. **NMI**: 不可屏蔽中断 (向量: 0xFFFA-0xFFFB)
3. **IRQ**: 可屏蔽中断 (向量: 0xFFFE-0xFFFF)

## 指令集分类

### 数据传送 (16 条)
LDA, LDX, LDY, STA, STX, STY, TAX, TAY, TSX, TXA, TXS, TYA, PHA, PHP, PLA, PLP

### 算术运算 (4 条)
ADC, SBC, INC, DEC, INX, INY, DEX, DEY

### 逻辑运算 (5 条)
AND, ORA, EOR, BIT, CMP, CPX, CPY

### 移位操作 (4 条)
ASL, LSR, ROL, ROR

### 控制流 (9 条)
JMP, JSR, RTS, RTI, BCC, BCS, BEQ, BNE, BMI, BPL, BVC, BVS

### 标志位操作 (6 条)
CLC, CLD, CLI, CLV, SEC, SED, SEI

### 其他 (2 条)
BRK, NOP
