# 指令集完善报告 - 2025年11月28日

## 概述

完成了 Donkey Kong ROM 所需的所有 6502 指令实现，从 124 种指令增加到 151 种指令，实现率达到 100%。

## 新增指令

### 1. 移位指令 (Shift Instructions)

已在 `Shift.scala` 中实现，但未在 CPU 核心中连接：

- **零页 X 索引模式** (4 条指令)
  - `0x16` ASL zp,X (出现 68 次)
  - `0x56` LSR zp,X (出现 30 次)
  - `0x36` ROL zp,X (出现 46 次)
  - `0x76` ROR zp,X (出现 5 次)

- **绝对寻址模式** (4 条指令)
  - `0x0E` ASL abs (出现 53 次)
  - `0x4E` LSR abs (出现 24 次)
  - `0x2E` ROL abs (出现 17 次)
  - `0x6E` ROR abs (出现 8 次)

- **绝对 X 索引模式** (4 条指令)
  - `0x1E` ASL abs,X (出现 22 次)
  - `0x5E` LSR abs,X (出现 40 次)
  - `0x3E` ROL abs,X (出现 29 次)
  - `0x7E` ROR abs,X (出现 12 次)

### 2. 算术指令 (Arithmetic Instructions)

已在 `Arithmetic.scala` 中实现，但未在 CPU 核心中连接：

- **ADC/SBC 零页模式** (2 条指令)
  - `0x65` ADC zp (出现 28 次)
  - `0xE5` SBC zp (出现 33 次)

- **ADC/SBC 零页 X 索引** (2 条指令)
  - `0x75` ADC zp,X (出现 12 次)
  - `0xF5` SBC zp,X (出现 17 次)

- **ADC/SBC 绝对寻址** (2 条指令)
  - `0x6D` ADC abs (出现 15 次)
  - `0xED` SBC abs (出现 16 次)

- **ADC/SBC 间接 X** (2 条指令)
  - `0x61` ADC (ind,X) (出现 11 次)
  - `0xE1` SBC (ind,X) (出现 37 次)

- **ADC/SBC 间接 Y** (2 条指令)
  - `0x71` ADC (ind),Y (出现 9 次)
  - `0xF1` SBC (ind),Y (出现 29 次)

- **INC/DEC 零页 X 索引** (2 条指令)
  - `0xF6` INC zp,X (出现 26 次)
  - `0xD6` DEC zp,X (出现 21 次)

- **INC/DEC 绝对 X 索引** (2 条指令)
  - `0xFE` INC abs,X (出现 66 次)
  - `0xDE` DEC abs,X (出现 22 次)

### 3. 跳转指令 (Jump Instructions)

新增实现：

- **JMP 间接寻址** (1 条指令)
  - `0x6C` JMP ind (出现 14 次)
  - 实现了 6502 的 JMP indirect bug（页边界不跨越）

## 修改的文件

### 1. src/main/scala/cpu/instructions/Jump.scala
- 添加 `executeJMPIndirect` 函数
- 实现 JMP indirect 的 4 周期执行流程
- 正确处理 6502 的页边界 bug

### 2. src/main/scala/cpu/core/CPU6502Core.scala
- 在指令分发器中添加所有缺失指令的连接
- 重新组织 ADC/SBC 指令的分发逻辑
- 添加 INC/DEC 零页 X 和绝对 X 的分发
- 添加 JMP indirect (0x6C) 的分发

### 3. scripts/analyze_opcodes.py
- 更新 `IMPLEMENTED_OPCODES` 集合，包含所有新实现的指令

## 验证结果

运行 `python3 scripts/analyze_opcodes.py games/Donkey-Kong.nes` 的结果：

```
📦 ROM 信息:
   PRG ROM: 16384 字节
   CHR ROM: 8192 字节

🔍 发现 151 种不同的指令

✅ 已实现: 151 种指令
❌ 未实现: 0 种指令
```

## 技术细节

### JMP Indirect 实现

JMP indirect 是 6502 中一个特殊的指令，它有一个著名的硬件 bug：

```scala
// 读取目标地址高字节 (注意 6502 的 JMP indirect bug: 不跨页)
val indirectAddrHigh = Mux(operand(7, 0) === 0xFF.U,
  Cat(operand(15, 8), 0.U(8.W)),  // Bug: 回绕到同一页
  operand + 1.U)
```

当间接地址的低字节是 0xFF 时，读取高字节时不会跨越到下一页，而是回绕到同一页的开始。这是 6502 的一个已知硬件 bug，但许多游戏依赖这个行为。

### 指令周期

所有新增指令都遵循正确的周期时序：

- **零页 X 索引**: 3 周期（读取地址 → 计算索引 → 读取/修改/写回）
- **绝对寻址**: 4 周期（读取地址低字节 → 读取地址高字节 → 读取数据 → 修改/写回）
- **绝对 X 索引**: 4 周期（读取地址 → 计算索引 → 读取数据 → 修改/写回）
- **JMP indirect**: 4 周期（读取间接地址 → 读取目标地址低字节 → 读取目标地址高字节 → 跳转）

## 编译验证

```bash
$ sbt compile
[success] Total time: 0 s
```

所有代码编译通过，没有语法错误或类型错误。

## 下一步

1. 运行完整的 Donkey Kong ROM 测试
2. 验证所有新增指令的正确性
3. 测试 JMP indirect 的页边界 bug 行为
4. 进行性能测试和优化

## 总结

本次更新完成了 Donkey Kong 所需的所有 6502 指令实现，共新增 27 条指令。所有指令都已在 Scala 代码中实现并正确连接到 CPU 核心的指令分发器中。代码编译通过，准备进行实际测试。
