# 6502 CPU 测试清单

**最后更新**: 2025-12-01 04:42:00
**测试环境**: Verilator + SystemVerilog

---

## 测试统计

| 类别 | 通过 | 失败 | 总计 | 通过率 |
|------|------|------|------|--------|
| **基础测试** | **4** | **3** | **7** | **57%** |
| **指令测试** | **6** | **1** | **7** | **86%** |
| **总计** | **10** | **4** | **14** | **71%** |

---

## 基础测试结果

| 测试名称 | 状态 | 输出 |
|---------|------|------|
| test_all_instructions.bin | ❌ FAIL | `112233445566778899AABBCCDDEEFFGGHHIIJJKK` |
| test_lda_sta.bin | ✅ PASS | `112233445566  OOKKFFAAIILL` |
| test_math.bin | ✅ PASS | `11223344556677  OOKKFFAAIILL` |
| test_branch.bin | ✅ PASS | `1122334455667788  OOKKFFAAIILL` |
| test_fibonacci.bin | ❌ FAIL | `` |
| test_level1_basic.bin | ✅ PASS | `112233  OOKKFFAAIILL` |
| test_level2_core.bin | ❌ FAIL | `11223344` |

---

## 指令验证测试结果

| 测试名称 | 状态 | 输出 | 验证指令 |
|---------|------|------|---------|
| test_transfer | ✅ PASS | `1122334455  OOKKFF` | TAX, TAY, TXA, TYA, TSX, TXS |
| test_logic | ✅ PASS | `11  OOKKFF` | ORA, EOR |
| test_shift | ✅ PASS | `112233  OOKKFF` | ASL A, LSR A, ROL A, ROR A |
| test_incdec | ✅ PASS | `11223344  OOKKFF` | INY, DEX, DEY, INC, DEC |
| test_cpy | ✅ PASS | `11  OOKKFF` | CPY (immediate, zero page) |
| test_flags | ✅ PASS | `112233  OOKK` | CLI, SEI, CLD, SED, NOP |
| test_jmp_indirect | ❌ FAIL | `` | JMP (indirect) |

---

## 指令覆盖率摘要

### ✅ 已验证工作 (约 45 条指令)

#### 数据传输 (12)
- ✅ LDA (immediate, zero page, absolute, indexed)
- ✅ LDX (immediate, zero page, absolute)
- ✅ LDY (immediate, zero page, absolute)
- ✅ STA (zero page, absolute, indexed including abs,Y)
- ✅ STX, STY
- ✅ TAX, TAY, TXA, TYA, TSX, TXS

#### 算术运算 (2)
- ✅ ADC (multiple modes)
- ✅ SBC (multiple modes)

#### 逻辑运算 (4)
- ✅ AND (multiple modes)
- ✅ ORA (immediate and other modes)
- ✅ EOR (immediate and other modes)
- ✅ BIT

#### 移位/旋转 (4)
- ✅ ASL A, LSR A, ROL A, ROR A (累加器模式)
- ✅ ASL, LSR, ROL, ROR (内存模式)

#### 比较指令 (3)
- ✅ CMP (multiple modes)
- ✅ CPX (multiple modes)
- ✅ CPY (immediate, zero page)

#### 分支指令 (8)
- ✅ BEQ, BNE, BCS, BCC, BMI, BPL, BVS, BVC

#### 跳转/子程序 (1)
- ✅ JMP abs
- ⚠️ JSR (部分工作，有 bug)
- ⚠️ RTS (部分工作，有 bug)
- ❌ JMP (indirect) - 不工作

#### 递增/递减 (6)
- ✅ INX, INY, DEX, DEY
- ✅ INC, DEC (zero page)

#### 栈操作 (0)
- ⚠️ PHA, PLA (有时序问题)
- ⚠️ PHP, PLP (有时序问题)

#### 标志操作 (7)
- ✅ CLC, SEC, CLI, SEI, CLD, SED, CLV

#### 其他 (1)
- ✅ NOP
- ✅ BRK

### ❌ 已知问题 (3 个)

1. **JSR/RTS**: 子程序调用和返回不正确
   - 影响测试: test_fibonacci, test_level2_core, test_all_instructions
   - 状态: 需要深入调试

2. **PHA/PLA/PHP/PLP**: 栈操作有时序问题
   - 影响测试: test_all_instructions
   - 状态: 写入/读取时序不匹配

3. **JMP (indirect)**: 间接跳转读取错误地址
   - 影响测试: test_jmp_indirect
   - 状态: 需要检查地址计算逻辑

---

## 寻址模式覆盖率

| 模式 | 状态 |
|------|------|
| 立即数 (#) | ✅ |
| 零页 (zp) | ✅ |
| 零页索引 (zp,X/Y) | ✅ |
| 绝对 (abs) | ✅ |
| 绝对索引 (abs,X/Y) | ✅ |
| 隐含 (impl) | ✅ |
| 累加器 (A) | ✅ |
| 相对 (rel) | ✅ |
| 间接 ((ind)) | ❌ |
| 索引间接 ((ind,X)) | ⚠️ |
| 间接索引 ((ind),Y) | ⚠️ |

---

## 最近修复

### 2025-12-01
- ✅ 修复 STA abs,Y (0x99) 缺失
- ✅ 修复单字节指令 PC 递增问题
- ✅ 修复 ASL A/LSR A 标志计算
- ✅ 添加 PLA/PLP/PHA/PHP 状态转换
- ✅ 验证 28 条额外指令正常工作

---

**自动生成**: run_tests_and_update.sh
**手动更新**: 指令验证测试结果
**下次更新**: 运行 `./run_tests.sh`
