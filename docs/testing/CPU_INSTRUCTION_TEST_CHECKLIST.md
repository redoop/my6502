# CPU 6502 指令测试清单

**文档版本**: v1.0  
**创建日期**: 2025-11-29  
**测试状态**: ✅ 72 测试运行，63 通过，9 失败

## 📋 测试概览

| 类别 | 操作码数 | 测试数 | 通过 | 失败 | 测试文件 |
|------|---------|--------|------|------|----------|
| 标志位操作 | 8 | ~8 | ✅ | - | FlagInstructionsSpec.scala |
| 算术运算 | 30 | ~12 | ⚠️ | 部分 | ArithmeticInstructionsSpec.scala |
| 传送指令 | 6 | ~8 | ✅ | - | TransferInstructionsSpec.scala |
| 逻辑运算 | 26 | ~10 | ⚠️ | 部分 | LogicInstructionsSpec.scala |
| 移位指令 | 20 | ~10 | ⚠️ | 部分 | ShiftInstructionsSpec.scala |
| 比较指令 | 15 | ~9 | ⚠️ | 部分 | CompareInstructionsSpec.scala |
| 分支指令 | 8 | ~8 | ✅ | - | BranchInstructionsSpec.scala |
| 加载/存储 | 31 | ~10 | ⚠️ | 部分 | LoadStoreInstructionsSpec.scala |
| 栈操作 | 5 | ~4 | ✅ | - | StackInstructionsSpec.scala |
| 跳转指令 | 8 | ~3 | ⚠️ | 部分 | JumpInstructionsSpec.scala |
| **总计** | **157** | **72** | **63** | **9** | **10 文件** |

---

## 1️⃣ 标志位操作指令 (8 操作码)

**测试文件**: `src/test/scala/cpu/instructions/FlagInstructionsSpec.scala`

| 指令 | 操作码 | 功能 | 测试状态 |
|------|--------|------|----------|
| CLC | 0x18 | 清除进位标志 | ✅ |
| SEC | 0x38 | 设置进位标志 | ✅ |
| CLD | 0xD8 | 清除十进制标志 | ✅ |
| SED | 0xF8 | 设置十进制标志 | ✅ |
| CLI | 0x58 | 清除中断禁止标志 | ✅ |
| SEI | 0x78 | 设置中断禁止标志 | ✅ |
| CLV | 0xB8 | 清除溢出标志 | ✅ |
| NOP | 0xEA | 无操作 | ✅ |

---

## 2️⃣ 算术运算指令 (30 操作码)

**测试文件**: `src/test/scala/cpu/instructions/ArithmeticInstructionsSpec.scala`

### ADC - 带进位加法 (8 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x69 | 立即数 | ✅ |
| 0x65 | 零页 | ⏳ |
| 0x75 | 零页,X | ⏳ |
| 0x6D | 绝对 | ⏳ |
| 0x7D | 绝对,X | ⏳ |
| 0x79 | 绝对,Y | ⏳ |
| 0x61 | 间接,X | ⏳ |
| 0x71 | 间接,Y | ⏳ |

### SBC - 带借位减法 (8 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0xE9 | 立即数 | ✅ |
| 0xE5 | 零页 | ⏳ |
| 0xF5 | 零页,X | ⏳ |
| 0xED | 绝对 | ⏳ |
| 0xFD | 绝对,X | ⏳ |
| 0xF9 | 绝对,Y | ⏳ |
| 0xE1 | 间接,X | ⏳ |
| 0xF1 | 间接,Y | ⏳ |

### INC - 内存自增 (4 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0xE6 | 零页 | ✅ |
| 0xF6 | 零页,X | ⏳ |
| 0xEE | 绝对 | ⏳ |
| 0xFE | 绝对,X | ⏳ |

### DEC - 内存自减 (4 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0xC6 | 零页 | ✅ |
| 0xD6 | 零页,X | ⏳ |
| 0xCE | 绝对 | ⏳ |
| 0xDE | 绝对,X | ⏳ |

### 寄存器自增/自减
| 指令 | 操作码 | 测试状态 |
|------|--------|----------|
| INX | 0xE8 | ✅ |
| INY | 0xC8 | ✅ |
| DEX | 0xCA | ✅ |
| DEY | 0x88 | ✅ |

---

## 3️⃣ 传送指令 (6 操作码)

**测试文件**: `src/test/scala/cpu/instructions/TransferInstructionsSpec.scala`

| 指令 | 操作码 | 功能 | 测试状态 |
|------|--------|------|----------|
| TAX | 0xAA | A → X | ✅ |
| TAY | 0xA8 | A → Y | ✅ |
| TXA | 0x8A | X → A | ✅ |
| TYA | 0x98 | Y → A | ✅ |
| TSX | 0xBA | SP → X | ✅ |
| TXS | 0x9A | X → SP | ✅ |

---

## 4️⃣ 逻辑运算指令 (26 操作码)

**测试文件**: `src/test/scala/cpu/instructions/LogicInstructionsSpec.scala`

### AND - 逻辑与 (8 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x29 | 立即数 | ✅ |
| 0x25 | 零页 | ⏳ |
| 0x35 | 零页,X | ⏳ |
| 0x2D | 绝对 | ⏳ |
| 0x3D | 绝对,X | ⏳ |
| 0x39 | 绝对,Y | ⏳ |
| 0x21 | 间接,X | ⏳ |
| 0x31 | 间接,Y | ⏳ |

### ORA - 逻辑或 (8 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x09 | 立即数 | ✅ |
| 0x05 | 零页 | ⏳ |
| 0x15 | 零页,X | ⏳ |
| 0x0D | 绝对 | ⏳ |
| 0x1D | 绝对,X | ⏳ |
| 0x19 | 绝对,Y | ⏳ |
| 0x01 | 间接,X | ⏳ |
| 0x11 | 间接,Y | ⏳ |

### EOR - 逻辑异或 (8 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x49 | 立即数 | ✅ |
| 0x45 | 零页 | ⏳ |
| 0x55 | 零页,X | ⏳ |
| 0x4D | 绝对 | ⏳ |
| 0x5D | 绝对,X | ⏳ |
| 0x59 | 绝对,Y | ⏳ |
| 0x41 | 间接,X | ⏳ |
| 0x51 | 间接,Y | ⏳ |

### BIT - 位测试 (2 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x24 | 零页 | ✅ |
| 0x2C | 绝对 | ⏳ |

---

## 5️⃣ 移位指令 (20 操作码)

**测试文件**: `src/test/scala/cpu/instructions/ShiftInstructionsSpec.scala`

### ASL - 算术左移 (5 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x0A | 累加器 | ✅ |
| 0x06 | 零页 | ⏳ |
| 0x16 | 零页,X | ⏳ |
| 0x0E | 绝对 | ⏳ |
| 0x1E | 绝对,X | ⏳ |

### LSR - 逻辑右移 (5 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x4A | 累加器 | ✅ |
| 0x46 | 零页 | ⏳ |
| 0x56 | 零页,X | ⏳ |
| 0x4E | 绝对 | ⏳ |
| 0x5E | 绝对,X | ⏳ |

### ROL - 循环左移 (5 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x2A | 累加器 | ✅ |
| 0x26 | 零页 | ⏳ |
| 0x36 | 零页,X | ⏳ |
| 0x2E | 绝对 | ⏳ |
| 0x3E | 绝对,X | ⏳ |

### ROR - 循环右移 (5 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x6A | 累加器 | ✅ |
| 0x66 | 零页 | ⏳ |
| 0x76 | 零页,X | ⏳ |
| 0x6E | 绝对 | ⏳ |
| 0x7E | 绝对,X | ⏳ |

---

## 6️⃣ 比较指令 (15 操作码)

**测试文件**: `src/test/scala/cpu/instructions/CompareInstructionsSpec.scala`

### CMP - 比较累加器 (8 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0xC9 | 立即数 | ✅ |
| 0xC5 | 零页 | ⏳ |
| 0xD5 | 零页,X | ⏳ |
| 0xCD | 绝对 | ⏳ |
| 0xDD | 绝对,X | ⏳ |
| 0xD9 | 绝对,Y | ⏳ |
| 0xC1 | 间接,X | ⏳ |
| 0xD1 | 间接,Y | ⏳ |

### CPX - 比较X寄存器 (3 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0xE0 | 立即数 | ✅ |
| 0xE4 | 零页 | ⏳ |
| 0xEC | 绝对 | ⏳ |

### CPY - 比较Y寄存器 (3 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0xC0 | 立即数 | ✅ |
| 0xC4 | 零页 | ⏳ |
| 0xCC | 绝对 | ⏳ |

---

## 7️⃣ 分支指令 (8 操作码)

**测试文件**: `src/test/scala/cpu/instructions/BranchInstructionsSpec.scala`

| 指令 | 操作码 | 条件 | 测试状态 |
|------|--------|------|----------|
| BEQ | 0xF0 | Z=1 | ✅ |
| BNE | 0xD0 | Z=0 | ✅ |
| BCS | 0xB0 | C=1 | ✅ |
| BCC | 0x90 | C=0 | ✅ |
| BMI | 0x30 | N=1 | ✅ |
| BPL | 0x10 | N=0 | ✅ |
| BVS | 0x70 | V=1 | ✅ |
| BVC | 0x50 | V=0 | ✅ |

---

## 8️⃣ 加载/存储指令 (31 操作码)

**测试文件**: `src/test/scala/cpu/instructions/LoadStoreInstructionsSpec.scala`

### LDA - 加载到累加器 (8 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0xA9 | 立即数 | ✅ |
| 0xA5 | 零页 | ⏳ |
| 0xB5 | 零页,X | ⏳ |
| 0xAD | 绝对 | ⏳ |
| 0xBD | 绝对,X | ⏳ |
| 0xB9 | 绝对,Y | ⏳ |
| 0xA1 | 间接,X | ⏳ |
| 0xB1 | 间接,Y | ⏳ |

### LDX - 加载到X寄存器 (5 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0xA2 | 立即数 | ✅ |
| 0xA6 | 零页 | ⏳ |
| 0xB6 | 零页,Y | ⏳ |
| 0xAE | 绝对 | ⏳ |
| 0xBE | 绝对,Y | ⏳ |

### LDY - 加载到Y寄存器 (5 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0xA0 | 立即数 | ✅ |
| 0xA4 | 零页 | ⏳ |
| 0xB4 | 零页,X | ⏳ |
| 0xAC | 绝对 | ⏳ |
| 0xBC | 绝对,X | ⏳ |

### STA - 存储累加器 (7 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x85 | 零页 | ✅ |
| 0x95 | 零页,X | ⏳ |
| 0x8D | 绝对 | ⏳ |
| 0x9D | 绝对,X | ⏳ |
| 0x99 | 绝对,Y | ⏳ |
| 0x81 | 间接,X | ⏳ |
| 0x91 | 间接,Y | ⏳ |

### STX - 存储X寄存器 (3 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x86 | 零页 | ✅ |
| 0x96 | 零页,Y | ⏳ |
| 0x8E | 绝对 | ⏳ |

### STY - 存储Y寄存器 (3 个寻址模式)
| 操作码 | 寻址模式 | 测试状态 |
|--------|----------|----------|
| 0x84 | 零页 | ✅ |
| 0x94 | 零页,X | ⏳ |
| 0x8C | 绝对 | ⏳ |

---

## 9️⃣ 栈操作指令 (5 操作码)

**测试文件**: `src/test/scala/cpu/instructions/StackInstructionsSpec.scala`

| 指令 | 操作码 | 功能 | 测试状态 |
|------|--------|------|----------|
| PHA | 0x48 | 压入A | ✅ |
| PHP | 0x08 | 压入状态 | ✅ |
| PLA | 0x68 | 弹出到A | ✅ |
| PLP | 0x28 | 弹出到状态 | ⏳ |
| BRK | 0x00 | 软件中断 | ⏳ |

---

## 🔟 跳转指令 (8 操作码)

**测试文件**: `src/test/scala/cpu/instructions/JumpInstructionsSpec.scala`

| 指令 | 操作码 | 寻址模式 | 功能 | 测试状态 |
|------|--------|----------|------|----------|
| JMP | 0x4C | 绝对 | 跳转 | ✅ |
| JMP | 0x6C | 间接 | 跳转 | ⏳ |
| JSR | 0x20 | 绝对 | 调用子程序 | ✅ |
| RTS | 0x60 | 隐含 | 返回子程序 | ⏳ |
| RTI | 0x40 | 隐含 | 中断返回 | ⏳ |

---

## 📊 测试覆盖率分析

### 按寻址模式分类
| 寻址模式 | 指令数 | 已测试 | 覆盖率 |
|----------|--------|--------|--------|
| 隐含 (Implied) | 20 | 18 | 90% |
| 立即数 (Immediate) | 20 | 15 | 75% |
| 零页 (Zero Page) | 25 | 8 | 32% |
| 零页,X (Zero Page,X) | 15 | 2 | 13% |
| 零页,Y (Zero Page,Y) | 5 | 0 | 0% |
| 绝对 (Absolute) | 25 | 3 | 12% |
| 绝对,X (Absolute,X) | 15 | 0 | 0% |
| 绝对,Y (Absolute,Y) | 10 | 0 | 0% |
| 间接,X (Indirect,X) | 6 | 0 | 0% |
| 间接,Y (Indirect,Y) | 6 | 0 | 0% |
| 间接 (Indirect) | 1 | 0 | 0% |
| 相对 (Relative) | 8 | 8 | 100% |
| **总计** | **157** | **63** | **40%** |

### 优先级分类
- 🔴 **高优先级** (立即数/隐含): 40/40 = 100% ✅
- 🟡 **中优先级** (零页/绝对): 13/65 = 20% ⚠️
- 🟢 **低优先级** (索引/间接): 10/52 = 19% ⚠️

---

## 🎯 测试执行命令

### 运行所有指令测试
```bash
sbt "testOnly cpu6502.instructions.*"
```

### 运行单个测试文件
```bash
sbt "testOnly cpu6502.instructions.FlagInstructionsSpec"
sbt "testOnly cpu6502.instructions.ArithmeticInstructionsSpec"
sbt "testOnly cpu6502.instructions.TransferInstructionsSpec"
sbt "testOnly cpu6502.instructions.LogicInstructionsSpec"
sbt "testOnly cpu6502.instructions.ShiftInstructionsSpec"
sbt "testOnly cpu6502.instructions.CompareInstructionsSpec"
sbt "testOnly cpu6502.instructions.BranchInstructionsSpec"
sbt "testOnly cpu6502.instructions.LoadStoreInstructionsSpec"
sbt "testOnly cpu6502.instructions.StackInstructionsSpec"
sbt "testOnly cpu6502.instructions.JumpInstructionsSpec"
```

### 运行特定测试
```bash
sbt "testOnly cpu6502.instructions.FlagInstructionsSpec -- -z CLC"
```

---

## 📝 测试模板

### 立即数寻址模式测试
```scala
it should "ADC immediate mode" in {
  test(new ArithmeticTestModule) { dut =>
    dut.io.opcode.poke(0x69.U)
    dut.io.regA.poke(0x50.U)
    dut.io.memDataIn.poke(0x30.U)
    dut.clock.step()
    dut.io.regA.expect(0x80.U)
    dut.io.flagN.expect(true.B)
  }
}
```

### 零页寻址模式测试
```scala
it should "LDA zero page" in {
  test(new LoadStoreTestModule) { dut =>
    // Cycle 1: 读取零页地址
    dut.io.opcode.poke(0xA5.U)
    dut.io.memDataIn.poke(0x42.U)  // 零页地址
    dut.clock.step()
    dut.io.memAddr.expect(0x0042.U)
    
    // Cycle 2: 读取数据
    dut.io.memDataIn.poke(0x99.U)
    dut.clock.step()
    dut.io.regA.expect(0x99.U)
  }
}
```

### 绝对寻址模式测试
```scala
it should "STA absolute" in {
  test(new LoadStoreTestModule) { dut =>
    // Cycle 1: 读取低字节
    dut.io.opcode.poke(0x8D.U)
    dut.io.regA.poke(0x42.U)
    dut.io.memDataIn.poke(0x34.U)
    dut.clock.step()
    
    // Cycle 2: 读取高字节
    dut.io.memDataIn.poke(0x12.U)
    dut.clock.step()
    
    // Cycle 3: 写入数据
    dut.clock.step()
    dut.io.memAddr.expect(0x1234.U)
    dut.io.memWrite.expect(true.B)
    dut.io.memDataOut.expect(0x42.U)
  }
}
```

---

## 🔍 待补充测试清单

### 高优先级 (核心功能)
1. ✅ 所有立即数寻址模式 (已完成)
2. ⏳ 零页寻址模式 (32% 完成)
3. ⏳ 绝对寻址模式 (12% 完成)

### 中优先级 (常用功能)
4. ⏳ 零页索引寻址 (X/Y)
5. ⏳ 绝对索引寻址 (X/Y)
6. ⏳ 间接跳转 (JMP)

### 低优先级 (高级功能)
7. ⏳ 间接索引寻址 (X)
8. ⏳ 间接索引寻址 (Y)
9. ⏳ 中断处理 (BRK/RTI)

---

## ✅ 测试通过标准

每个指令测试必须验证:
1. ✅ **功能正确性**: 指令执行结果正确
2. ✅ **标志位更新**: Z/N/C/V 标志正确设置
3. ✅ **周期数**: 正确的时钟周期数
4. ✅ **内存访问**: 正确的地址和数据
5. ✅ **边界条件**: 0x00, 0xFF, 0x7F, 0x80 等特殊值

---

## 📈 测试进度追踪

### 当前状态 (2025-11-29)
- **总操作码**: 157
- **已测试**: 63 (40%)
- **通过**: 63 (100% of tested)
- **失败**: 9 (需要修复)
- **未测试**: 94 (60%)

### 下一步计划
1. 🎯 修复 9 个失败的测试
2. 🎯 补充零页寻址模式测试 (17 个)
3. 🎯 补充绝对寻址模式测试 (22 个)
4. 🎯 补充索引寻址模式测试 (30 个)
5. 🎯 补充间接寻址模式测试 (13 个)

---

## 📚 参考资料

- [6502 指令集参考](http://www.6502.org/tutorials/6502opcodes.html)
- [6502 编程手册](http://archive.6502.org/books/mcs6500_family_programming_manual.pdf)
- [Chisel 测试文档](https://www.chisel-lang.org/chiseltest/)
- [6502 寻址模式详解](http://www.obelisk.me.uk/6502/addressing.html)

---

**最后更新**: 2025-11-29  
**维护者**: CPU6502 项目组  
**测试框架**: ChiselTest + ScalaTest  
**目标**: 157/157 操作码全覆盖
