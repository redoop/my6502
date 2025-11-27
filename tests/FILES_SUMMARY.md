# 测试文件总结

## 已创建的测试文件

### 1. 测试文档

| 文件 | 描述 | 用途 |
|------|------|------|
| `tests/TEST_CHECKLIST.md` | 详细测试清单 | 列出所有 151 种指令的测试要点 |
| `tests/TEST_PROGRESS.md` | 测试进度跟踪 | 跟踪 27 条新指令的测试进度 |
| `tests/README.md` | 测试文档 | 测试方法、策略和使用说明 |
| `tests/FILES_SUMMARY.md` | 本文件 | 测试文件总结 |
| `docs/TESTING_GUIDE.md` | 测试指南 | 完整的测试指南和参考 |

### 2. 测试代码

| 文件 | 语言 | 描述 |
|------|------|------|
| `tests/instruction_tests.asm` | 6502 汇编 | 汇编测试程序（部分完成） |
| `tests/run_instruction_tests.py` | Python | 自动化测试脚本 |
| `src/test/scala/InstructionTests.scala` | Scala | 单元测试框架 |
| `tests/example_test.scala` | Scala | 测试示例和模板 |

### 3. 测试脚本

| 文件 | 描述 |
|------|------|
| `scripts/run_tests.sh` | 运行所有测试的主脚本 |
| `scripts/verilator_build.sh` | 编译 Verilator 仿真器 |
| `scripts/verilator_run.sh` | 运行 Verilator 仿真 |
| `scripts/test_donkey_kong.sh` | Donkey Kong 快速测试 |

## 测试清单概览

### 新增指令测试（27条）

#### P0 - 关键指令（10条）
- [ ] 0x16 ASL zp,X (68次)
- [ ] 0xFE INC abs,X (66次)
- [ ] 0x0E ASL abs (53次)
- [ ] 0x36 ROL zp,X (46次)
- [ ] 0x5E LSR abs,X (40次)
- [ ] 0xE1 SBC (ind,X) (37次)
- [ ] 0xE5 SBC zp (33次)
- [ ] 0x56 LSR zp,X (30次)
- [ ] 0x3E ROL abs,X (29次)
- [ ] 0xF1 SBC (ind),Y (29次)

#### P1 - 重要指令（10条）
- [ ] 0x65 ADC zp (28次)
- [ ] 0xF6 INC zp,X (26次)
- [ ] 0x4E LSR abs (24次)
- [ ] 0x1E ASL abs,X (22次)
- [ ] 0xDE DEC abs,X (22次)
- [ ] 0xD6 DEC zp,X (21次)
- [ ] 0x2E ROL abs (17次)
- [ ] 0xF5 SBC zp,X (17次)
- [ ] 0xED SBC abs (16次)
- [ ] 0x6D ADC abs (15次)

#### P2 - 一般指令（7条）
- [ ] 0x6C JMP ind (14次)
- [ ] 0x75 ADC zp,X (12次)
- [ ] 0x7E ROR abs,X (12次)
- [ ] 0x61 ADC (ind,X) (11次)
- [ ] 0x71 ADC (ind),Y (9次)
- [ ] 0x6E ROR abs (8次)
- [ ] 0x76 ROR zp,X (5次)

## 测试分类

### 按指令类型

1. **移位指令** (12条)
   - ASL: 0x16, 0x0E, 0x1E
   - LSR: 0x56, 0x4E, 0x5E
   - ROL: 0x36, 0x2E, 0x3E
   - ROR: 0x76, 0x6E, 0x7E

2. **算术指令** (14条)
   - ADC: 0x65, 0x75, 0x6D, 0x61, 0x71
   - SBC: 0xE5, 0xF5, 0xED, 0xE1, 0xF1
   - INC: 0xF6, 0xFE
   - DEC: 0xD6, 0xDE

3. **跳转指令** (1条)
   - JMP: 0x6C

### 按寻址模式

1. **零页 X 索引** (8条)
   - 0x16, 0x56, 0x36, 0x76 (移位)
   - 0x75, 0xF5 (算术)
   - 0xF6, 0xD6 (INC/DEC)

2. **绝对寻址** (4条)
   - 0x0E, 0x4E, 0x2E, 0x6E (移位)
   - 0x6D, 0xED (算术)

3. **绝对 X 索引** (6条)
   - 0x1E, 0x5E, 0x3E, 0x7E (移位)
   - 0xFE, 0xDE (INC/DEC)

4. **零页** (2条)
   - 0x65, 0xE5 (ADC/SBC)

5. **间接 X** (2条)
   - 0x61, 0xE1 (ADC/SBC)

6. **间接 Y** (2条)
   - 0x71, 0xF1 (ADC/SBC)

7. **间接** (1条)
   - 0x6C (JMP)

## 测试命令速查

```bash
# ========================================
# 查看文档
# ========================================

# 查看测试清单
cat tests/TEST_CHECKLIST.md

# 查看测试进度
cat tests/TEST_PROGRESS.md

# 查看测试指南
cat docs/TESTING_GUIDE.md

# ========================================
# 运行测试
# ========================================

# 运行所有测试
./scripts/run_tests.sh

# 运行 P0（关键）测试
python3 tests/run_instruction_tests.py --priority P0

# 运行 P1（重要）测试
python3 tests/run_instruction_tests.py --priority P1

# 运行 P2（一般）测试
python3 tests/run_instruction_tests.py --priority P2

# 运行详细测试
python3 tests/run_instruction_tests.py --verbose

# ========================================
# Scala 单元测试
# ========================================

# 运行所有单元测试
sbt test

# 运行特定测试类
sbt "testOnly cpu6502.tests.InstructionTests"

# 运行特定测试
sbt "testOnly cpu6502.tests.InstructionTests -- -z 'ASL zp,X'"

# ========================================
# Verilator 仿真
# ========================================

# 编译 Verilator
./scripts/verilator_build.sh

# 运行 Donkey Kong
./scripts/verilator_run.sh games/Donkey-Kong.nes

# 快速测试 Donkey Kong
./scripts/test_donkey_kong.sh

# ========================================
# 分析工具
# ========================================

# 分析指令覆盖率
python3 scripts/analyze_opcodes.py games/Donkey-Kong.nes

# 只显示未实现的指令
python3 scripts/analyze_opcodes.py games/Donkey-Kong.nes | grep -A 30 "未实现"

# ========================================
# 代码生成
# ========================================

# 生成 Verilog
sbt "runMain cpu6502.CPU6502Refactored"

# 编译 Scala
sbt compile
```

## 测试工作流程

### 1. 开发阶段

```
1. 实现指令 → 2. 编写单元测试 → 3. 运行测试 → 4. 修复 bug → 5. 重复
```

### 2. 集成阶段

```
1. 所有单元测试通过 → 2. 运行集成测试 → 3. 测试真实 ROM → 4. 修复问题
```

### 3. 发布阶段

```
1. 所有测试通过 → 2. 性能测试 → 3. 回归测试 → 4. 发布
```

## 测试里程碑

### 里程碑 1: 单元测试完成
- [ ] 所有 27 条指令有单元测试
- [ ] 所有单元测试通过
- [ ] 代码覆盖率 > 90%

### 里程碑 2: 集成测试完成
- [ ] Verilator 编译成功
- [ ] 能够运行简单的测试 ROM
- [ ] Klaus 测试通过

### 里程碑 3: Donkey Kong 运行
- [ ] 游戏能够启动
- [ ] 显示标题画面
- [ ] 游戏可玩
- [ ] 无明显 bug

## 当前状态

- ✅ 所有 27 条指令已实现
- ✅ 测试框架已创建
- ✅ 测试文档已完成
- 🚧 单元测试待编写
- 🚧 集成测试待运行
- ⬜ Donkey Kong 待调试

## 下一步行动

1. **立即**: 编写 P0 指令的单元测试
2. **短期**: 完成所有单元测试
3. **中期**: 运行集成测试，修复 bug
4. **长期**: 优化性能，支持更多游戏

## 贡献指南

### 如何添加新测试

1. 在 `src/test/scala/InstructionTests.scala` 中添加测试用例
2. 参考 `tests/example_test.scala` 中的模板
3. 运行 `sbt test` 验证
4. 更新 `tests/TEST_PROGRESS.md` 中的进度

### 如何报告 bug

1. 在 `tests/TEST_PROGRESS.md` 的"已知问题"部分添加
2. 包含：指令、预期行为、实际行为、复现步骤
3. 标记优先级：🔴 高 / 🟡 中 / 🟢 低

## 联系方式

如有问题，请查看：
- 测试文档: `tests/README.md`
- 测试指南: `docs/TESTING_GUIDE.md`
- 测试清单: `tests/TEST_CHECKLIST.md`
