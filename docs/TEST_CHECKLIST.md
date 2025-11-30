# 6502 CPU 测试清单

**最后更新**: 2025-12-01 04:36:04
**测试环境**: Verilator + SystemVerilog

---

## 测试统计

| 类别 | 通过 | 失败 | 总计 | 通过率 |
|------|------|------|------|--------|
| **总计** | **4** | **3** | **7** | **57%** |

---

## 测试结果详情

| test_all_instructions.bin | ❌ FAIL | `112233445566778899AABBCCDDEEFFGGHHIIJJKK` |
| test_lda_sta.bin | ✅ PASS | `112233445566  OOKKFFAAIILL` |
| test_math.bin | ✅ PASS | `11223344556677  OOKKFFAAIILL` |
| test_branch.bin | ✅ PASS | `1122334455667788  OOKKFFAAIILL` |
| test_fibonacci.bin | ❌ FAIL | `` |
| test_level1_basic.bin | ✅ PASS | `112233  OOKKFFAAIILL` |
| test_level2_core.bin | ❌ FAIL | `11223344` |

---

## 指令覆盖率摘要

### 已测试指令类别
- ✅ 数据传输: LDA, LDX, LDY, STA
- ✅ 算术运算: ADC, SBC
- ✅ 逻辑运算: AND (部分)
- ✅ 比较指令: CMP, CPX
- ✅ 分支指令: 全部 8 个
- ✅ 跳转/子程序: JMP, JSR, RTS
- ✅ 栈操作: PHA, PLA
- ✅ 标志操作: CLC, SEC, CLV
- ✅ 递增: INX

### 待测试指令
- ❌ 传送指令: TAX, TAY, TXA, TYA, TSX, TXS
- ❌ 逻辑运算: ORA, EOR
- ❌ 移位/旋转: ASL, LSR, ROL, ROR (累加器模式)
- ❌ 递增/递减: INY, DEX, DEY, INC, DEC
- ❌ 比较: CPY
- ❌ 栈操作: PHP, PLP
- ❌ 标志操作: CLI, SEI, CLD, SED
- ❌ 其他: NOP, JMP (indirect)

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
| 索引间接 ((ind,X)) | ❌ |
| 间接索引 ((ind),Y) | ❌ |

---

**自动生成**: run_tests_and_update.sh
**下次更新**: 运行 `./run_tests_and_update.sh`
