# 6502 指令集测试指南

## 概述

本文档提供了完整的 6502 指令集测试指南，包括测试策略、测试方法和测试清单。

## 测试文件清单

### 已创建的测试文件

1. **tests/TEST_CHECKLIST.md** - 详细的测试清单，包含所有 151 种指令
2. **tests/TEST_PROGRESS.md** - 测试进度跟踪表
3. **tests/README.md** - 测试文档和使用说明
4. **tests/instruction_tests.asm** - 汇编测试程序（部分完成）
5. **tests/run_instruction_tests.py** - Python 自动化测试脚本
6. **src/test/scala/InstructionTests.scala** - Scala 单元测试框架
7. **tests/example_test.scala** - 测试示例和模板
8. **scripts/run_tests.sh** - 测试运行脚本

## 测试优先级

### 为什么要分优先级？

Donkey Kong 使用了 151 种不同的指令，但使用频率差异很大。我们按照使用频率将新增的 27 条指令分为三个优先级：

### P0 - 关键指令（10条，使用频率 >25次）

这些指令必须首先测试并确保正确，因为它们在游戏中被频繁使用：

```
1. 0x16 ASL zp,X      (68次) - 最高频
2. 0xFE INC abs,X     (66次)
3. 0x0E ASL abs       (53次)
4. 0x36 ROL zp,X      (46次)
5. 0x5E LSR abs,X     (40次)
6. 0xE1 SBC (ind,X)   (37次)
7. 0xE5 SBC zp        (33次)
8. 0x56 LSR zp,X      (30次)
9. 0x3E ROL abs,X     (29次)
10. 0xF1 SBC (ind),Y  (29次)
```

### P1 - 重要指令（10条，使用频率 10-25次）

这些指令也很重要，应该在 P0 测试完成后立即测试。

### P2 - 一般指令（7条，使用频率 <10次）

这些指令使用频率较低，可以最后测试。

## 测试方法

### 1. 单元测试（Scala/Chisel）

**优点**:
- 快速执行
- 精确控制
- 易于调试
- 可以测试边界情况

**示例**:

```scala
"ASL zp,X (0x16)" should "correctly shift left" in {
  test(new CPU6502Core) { dut =>
    // 初始化
    dut.io.reset.poke(true.B)
    dut.clock.step(1)
    dut.io.reset.poke(false.B)
    
    // 设置测试数据
    // 执行指令
    // 验证结果
  }
}
```

**运行**:
```bash
sbt test
sbt "testOnly cpu6502.tests.InstructionTests"
```

### 2. 集成测试（Verilator）

**优点**:
- 真实硬件行为
- 完整系统测试
- 可以运行真实 ROM

**运行**:
```bash
./scripts/verilator_build.sh
./scripts/verilator_run.sh games/Donkey-Kong.nes
```

### 3. 自动化测试（Python）

**优点**:
- 批量测试
- 自动生成报告
- 易于集成 CI/CD

**运行**:
```bash
python3 tests/run_instruction_tests.py
python3 tests/run_instruction_tests.py --priority P0
```

## 测试策略

### 阶段 1: 单指令测试（当前阶段）

为每条指令创建独立的测试用例：

```
测试 ASL zp,X:
  ✓ 正常左移
  ✓ 进位标志设置
  ✓ 零标志设置
  ✓ 负标志设置
  ✓ 地址计算
  ✓ 边界情况
```

### 阶段 2: 指令组合测试

测试多条指令的组合：

```
测试序列:
  LDA #$42
  STA $10
  LDX #$05
  ASL $10,X
  验证结果
```

### 阶段 3: 真实程序测试

使用真实的测试 ROM：

1. **Klaus Dormann 功能测试** - 标准的 6502 测试套件
2. **Donkey Kong** - 实际游戏
3. **其他 NES 游戏** - 回归测试

## 测试清单使用方法

### 1. 查看测试清单

```bash
cat tests/TEST_CHECKLIST.md
```

### 2. 更新测试进度

编辑 `tests/TEST_PROGRESS.md`，将 ⬜ 改为 ✅：

```markdown
| 1 | 0x16 | ASL zp,X | 68 | ✅ | ✅ | ✅ | ✅ 通过 | |
```

### 3. 运行测试

```bash
# 运行所有测试
./scripts/run_tests.sh

# 运行特定优先级
python3 tests/run_instruction_tests.py --priority P0
```

### 4. 记录结果

在 `tests/TEST_PROGRESS.md` 中记录测试结果和问题。

## 常见测试场景

### 场景 1: 测试移位指令

```
输入: 0x42 (0100 0010)

ASL: 0x84 (1000 0100), C=0, N=1, Z=0
LSR: 0x21 (0010 0001), C=0, N=0, Z=0
ROL (C=0): 0x84, C=0, N=1, Z=0
ROL (C=1): 0x85, C=0, N=1, Z=0
ROR (C=0): 0x21, C=0, N=0, Z=0
ROR (C=1): 0xA1, C=0, N=1, Z=0
```

### 场景 2: 测试算术指令

```
ADC:
  A=0x50, M=0x10, C=0 → A=0x60, C=0, V=0
  A=0xFF, M=0x01, C=0 → A=0x00, C=1, V=0
  A=0x50, M=0x50, C=0 → A=0xA0, C=0, V=1

SBC:
  A=0x50, M=0x10, C=1 → A=0x40, C=1, V=0
  A=0x00, M=0x01, C=1 → A=0xFF, C=0, V=0
```

### 场景 3: 测试寻址模式

```
零页 X 索引:
  指令: ASL $10,X
  X=0x05 → 地址 = $15
  X=0xFF → 地址 = $0F (回绕)

绝对 X 索引:
  指令: INC $1000,X
  X=0x10 → 地址 = $1010
  X=0xFF → 地址 = $10FF

间接 X 索引:
  指令: ADC ($10,X)
  X=0x04 → 读取 $14-$15 的地址
```

## 调试技巧

### 1. 使用详细输出

```bash
python3 tests/run_instruction_tests.py --verbose
```

### 2. 单步执行

在 Scala 测试中添加打印：

```scala
println(s"PC: ${dut.io.debug.pc.peek()}")
println(s"A: ${dut.io.debug.a.peek()}")
println(s"Flags: ${dut.io.debug.flags.peek()}")
```

### 3. 波形查看

使用 Verilator 生成波形文件：

```bash
./scripts/verilator_run.sh --trace games/Donkey-Kong.nes
gtkwave trace.vcd
```

### 4. 对比测试

与已知正确的模拟器对比执行结果。

## 测试报告模板

```markdown
# 测试报告

**日期**: 2025-11-28
**测试人员**: [姓名]
**版本**: commit abc123

## 测试摘要

- 总计: 27 条指令
- 通过: 25 条
- 失败: 2 条
- 通过率: 92.6%

## 失败指令

### 1. 0x6C JMP ind

**问题**: 页边界 bug 未正确实现

**预期**: 当间接地址在 0x??FF 时，应该回绕到同一页
**实际**: 跨页读取了下一页的数据

**修复建议**: 
```scala
val indirectAddrHigh = Mux(operand(7, 0) === 0xFF.U,
  Cat(operand(15, 8), 0.U(8.W)),  // 回绕
  operand + 1.U)
```

### 2. 0xFE INC abs,X

**问题**: 负标志未正确设置

**预期**: 当结果 >= 0x80 时，N=1
**实际**: N 始终为 0

**修复建议**: 检查标志位设置逻辑

## 性能指标

- 平均测试时间: 2.3 秒/指令
- 最慢测试: JMP ind (5.1 秒)
- 最快测试: NOP (0.1 秒)

## 下一步

1. 修复 JMP indirect 的页边界处理
2. 修复 INC abs,X 的标志位逻辑
3. 重新运行测试
4. 更新测试进度表
```

## 持续集成

### GitHub Actions 配置

```yaml
name: Test
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Setup Scala
        uses: olafurpg/setup-scala@v10
        
      - name: Run tests
        run: ./scripts/run_tests.sh
        
      - name: Upload test results
        uses: actions/upload-artifact@v2
        with:
          name: test-results
          path: test-results/
```

## 参考资料

1. **6502 指令集**: http://www.6502.org/tutorials/6502opcodes.html
2. **Klaus 测试**: https://github.com/Klaus2m5/6502_65C02_functional_tests
3. **NES Dev Wiki**: https://wiki.nesdev.com/
4. **ChiselTest 文档**: https://www.chisel-lang.org/chiseltest/

## 快速命令参考

```bash
# 查看测试清单
cat tests/TEST_CHECKLIST.md

# 查看测试进度
cat tests/TEST_PROGRESS.md

# 运行所有测试
./scripts/run_tests.sh

# 运行 P0 测试
python3 tests/run_instruction_tests.py --priority P0

# 运行单元测试
sbt test

# 编译 Verilator
./scripts/verilator_build.sh

# 运行 Donkey Kong
./scripts/verilator_run.sh games/Donkey-Kong.nes

# 分析指令覆盖率
python3 scripts/analyze_opcodes.py games/Donkey-Kong.nes
```
