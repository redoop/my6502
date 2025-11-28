# 测试命令速查表

## 🚀 快速开始

```bash
# 运行所有测试
sbt "testOnly cpu6502.tests.P0* cpu6502.tests.P1* cpu6502.tests.P2*"
```

## 📊 按优先级运行

```bash
# P0 - 关键指令（10条，13个测试）
sbt "testOnly cpu6502.tests.P0*"

# P1 - 重要指令（10条，34个测试）
sbt "testOnly cpu6502.tests.P1*"

# P2 - 一般指令（7条，38个测试）
sbt "testOnly cpu6502.tests.P2*"
```

## 🎯 按测试类型运行

```bash
# 基础测试
sbt "testOnly cpu6502.tests.P0BasicTests cpu6502.tests.P1BasicTests cpu6502.tests.P2BasicTests"

# 分类测试
sbt "testOnly cpu6502.tests.P1CategoryTests cpu6502.tests.P2CategoryTests"

# 特殊测试（JMP indirect bug）
sbt "testOnly cpu6502.tests.P2SpecialTests"

# 标志位测试
sbt "testOnly cpu6502.tests.P0FlagTests"
```

## 🔍 按指令类型运行

```bash
# 算术指令测试
sbt "testOnly cpu6502.tests.P1CategoryTests -- -z Arithmetic"
sbt "testOnly cpu6502.tests.P2CategoryTests -- -z Arithmetic"

# 移位指令测试
sbt "testOnly cpu6502.tests.P1CategoryTests -- -z Shift"
sbt "testOnly cpu6502.tests.P2CategoryTests -- -z Shift"

# 跳转指令测试
sbt "testOnly cpu6502.tests.P2CategoryTests -- -z Jump"
```

## 🎨 按寻址模式运行

```bash
# 零页寻址
sbt "testOnly cpu6502.tests.P1CategoryTests -- -z 'zero page addressing'"

# 零页 X 索引
sbt "testOnly cpu6502.tests.P1CategoryTests -- -z 'zero page X'"

# 绝对寻址
sbt "testOnly cpu6502.tests.P1CategoryTests -- -z 'absolute addressing'"

# 绝对 X 索引
sbt "testOnly cpu6502.tests.P1CategoryTests -- -z 'absolute X'"

# 间接寻址
sbt "testOnly cpu6502.tests.P2CategoryTests -- -z 'indirect'"
```

## 🔬 运行特定指令测试

```bash
# ASL 指令
sbt "testOnly cpu6502.tests.P0BasicTests -- -z 'ASL zp,X'"
sbt "testOnly cpu6502.tests.P1BasicTests -- -z 'ASL abs,X'"

# ADC 指令
sbt "testOnly cpu6502.tests.P1BasicTests -- -z 'ADC zp'"
sbt "testOnly cpu6502.tests.P2BasicTests -- -z 'ADC zp,X'"

# SBC 指令
sbt "testOnly cpu6502.tests.P0BasicTests -- -z 'SBC zp'"
sbt "testOnly cpu6502.tests.P1BasicTests -- -z 'SBC zp,X'"

# JMP indirect
sbt "testOnly cpu6502.tests.P2BasicTests -- -z 'JMP ind'"
sbt "testOnly cpu6502.tests.P2SpecialTests"
```

## 📈 测试统计

```bash
# 查看测试摘要
sbt "testOnly cpu6502.tests.P0* cpu6502.tests.P1* cpu6502.tests.P2*" | grep -A 10 "Total number"

# 预期输出：
# Total number of tests run: 87
# Suites: completed 7, aborted 0
# Tests: succeeded 87, failed 0, canceled 0, ignored 0, pending 0
# All tests passed.
```

## 🐛 调试测试

```bash
# 运行单个测试并显示详细输出
sbt "testOnly cpu6502.tests.P0BasicTests -- -z 'smoke test'"

# 运行测试并显示所有输出
sbt "testOnly cpu6502.tests.P0BasicTests" 2>&1 | less

# 只显示失败的测试
sbt "testOnly cpu6502.tests.P0*" 2>&1 | grep -A 5 "FAILED"
```

## 🔄 持续测试

```bash
# 监视模式（文件改变时自动运行）
sbt ~testOnly cpu6502.tests.P0BasicTests

# 快速测试（只运行 P0）
sbt "testOnly cpu6502.tests.P0BasicTests"
```

## 📊 测试覆盖率

```bash
# 运行所有测试并生成覆盖率报告
sbt clean coverage test coverageReport

# 查看覆盖率
open target/scala-2.12/scoverage-report/index.html
```

## 🎯 常用组合

```bash
# 快速验证（只运行 P0）
sbt "testOnly cpu6502.tests.P0BasicTests"

# 完整验证（所有测试）
sbt "testOnly cpu6502.tests.P0* cpu6502.tests.P1* cpu6502.tests.P2*"

# 新增指令验证（P0 + P1 + P2）
sbt test

# 特定优先级验证
sbt "testOnly cpu6502.tests.P0* cpu6502.tests.P1*"
```

## 📝 测试结果解读

### 成功输出示例

```
[info] P0BasicTests:
[info] ASL zp,X (0x16) - Basic Tests
[info] - should pass basic smoke test
[info] - should be recognized as valid opcode
[info] Run completed in 16 seconds, 205 milliseconds.
[info] Total number of tests run: 13
[info] Suites: completed 1, aborted 0
[info] Tests: succeeded 13, failed 0, canceled 0, ignored 0, pending 0
[info] All tests passed.
[success] Total time: 23 s
```

### 失败输出示例

```
[info] - should pass basic smoke test *** FAILED ***
[info]   assertion failed (P0BasicTests.scala:25)
[error] Failed: Total 1, Failed 1, Errors 0, Passed 0
[error] Failed tests:
[error]   cpu6502.tests.P0BasicTests
[error] (Test / testOnly) sbt.TestsFailedException: Tests unsuccessful
```

## 🔧 故障排除

### 编译错误

```bash
# 清理并重新编译
sbt clean compile

# 只编译测试代码
sbt Test/compile
```

### 测试超时

```bash
# 增加测试超时时间（在 build.sbt 中）
Test / testOptions += Tests.Argument("-oD")
```

### 内存不足

```bash
# 增加 JVM 内存
export SBT_OPTS="-Xmx2G -XX:+UseConcMarkSweepGC"
sbt test
```

## 📚 相关命令

```bash
# 编译项目
sbt compile

# 生成 Verilog
sbt "runMain cpu6502.CPU6502Refactored"

# 运行 Verilator 仿真
./scripts/verilator_build.sh
./scripts/verilator_run.sh games/Donkey-Kong.nes

# 分析指令覆盖率
python3 scripts/analyze_opcodes.py games/Donkey-Kong.nes
```

## 🎓 学习资源

- `docs/TESTING_GUIDE.md` - 完整测试指南
- `docs/ALL_TESTS_COMPLETE.md` - 测试完成报告
- `tests/TEST_CHECKLIST.md` - 测试清单
- `tests/README.md` - 测试使用说明

---

**提示**: 使用 `sbt` 的 tab 补全功能可以快速找到测试类名
