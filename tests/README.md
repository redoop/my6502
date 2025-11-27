# 6502 指令集测试文档

## 概述

本目录包含 6502 CPU 的完整测试套件，用于验证所有 151 种指令的正确性。

## 测试文件结构

```
tests/
├── README.md                    # 本文件
├── TEST_CHECKLIST.md           # 详细测试清单
├── instruction_tests.asm       # 汇编测试程序
├── run_instruction_tests.py    # Python 自动化测试
└── test_roms/                  # 测试 ROM 文件
    ├── klaus_test.bin          # Klaus Dormann 功能测试
    └── individual/             # 单个指令测试 ROM
```

## 快速开始

### 运行所有测试

```bash
./scripts/run_tests.sh
```

### 运行特定优先级的测试

```bash
# 只测试 P0（关键）指令
python3 tests/run_instruction_tests.py --priority P0

# 只测试 P1（重要）指令
python3 tests/run_instruction_tests.py --priority P1

# 只测试 P2（一般）指令
python3 tests/run_instruction_tests.py --priority P2
```

### 运行 Scala 单元测试

```bash
sbt test
```

### 运行单个测试

```bash
sbt "testOnly cpu6502.tests.InstructionTests"
```

## 测试优先级

### P0 - 关键指令（必须首先通过）

这些指令在 Donkey Kong 中使用频率最高（>25次），必须确保正确：

1. **0x16 ASL zp,X** (68次) - 零页X索引左移
2. **0xFE INC abs,X** (66次) - 绝对X索引递增
3. **0x0E ASL abs** (53次) - 绝对地址左移
4. **0x36 ROL zp,X** (46次) - 零页X索引循环左移
5. **0x5E LSR abs,X** (40次) - 绝对X索引逻辑右移
6. **0xE1 SBC (ind,X)** (37次) - 间接X索引减法
7. **0xE5 SBC zp** (33次) - 零页减法
8. **0x56 LSR zp,X** (30次) - 零页X索引逻辑右移
9. **0x3E ROL abs,X** (29次) - 绝对X索引循环左移
10. **0xF1 SBC (ind),Y** (29次) - 间接Y索引减法

### P1 - 重要指令（应该通过）

使用频率中等（10-25次）：

11. **0x65 ADC zp** (28次)
12. **0xF6 INC zp,X** (26次)
13. **0x4E LSR abs** (24次)
14. **0x1E ASL abs,X** (22次)
15. **0xDE DEC abs,X** (22次)
16. **0xD6 DEC zp,X** (21次)
17. **0x2E ROL abs** (17次)
18. **0xF5 SBC zp,X** (17次)
19. **0xED SBC abs** (16次)
20. **0x6D ADC abs** (15次)

### P2 - 一般指令（可以稍后测试）

使用频率较低（<10次）：

21. **0x6C JMP ind** (14次)
22. **0x75 ADC zp,X** (12次)
23. **0x7E ROR abs,X** (12次)
24. **0x61 ADC (ind,X)** (11次)
25. **0x71 ADC (ind),Y** (9次)
26. **0x6E ROR abs** (8次)
27. **0x76 ROR zp,X** (5次)

## 测试方法

### 1. 单元测试（Scala/Chisel）

使用 ChiselTest 框架测试每条指令：

```scala
it should "correctly execute ASL zp,X (0x16)" in {
  test(new CPU6502Core) { dut =>
    // 1. 初始化 CPU
    dut.io.reset.poke(true.B)
    dut.clock.step(1)
    dut.io.reset.poke(false.B)
    
    // 2. 设置测试数据
    // 在零页 0x10 写入 0x42
    // 设置 X = 0x05
    
    // 3. 执行 ASL $10,X 指令
    
    // 4. 验证结果
    // 零页 0x15 应该是 0x84
    // 进位标志应该是 0
    // 负标志应该是 1
    // 零标志应该是 0
  }
}
```

### 2. 集成测试（Verilator）

使用真实 ROM 测试：

```bash
# 测试 Klaus Dormann 功能测试
./scripts/verilator_run.sh tests/test_roms/klaus_test.bin

# 测试 Donkey Kong
./scripts/verilator_run.sh games/Donkey-Kong.nes
```

### 3. 对比测试

与已知正确的模拟器对比：

```bash
# 运行参考模拟器
nestest reference_emulator

# 运行我们的实现
nestest our_implementation

# 对比结果
diff reference.log our.log
```

## 测试用例设计

### 移位指令测试要点

#### ASL (Arithmetic Shift Left)

```
测试用例 1: 正常左移
  输入: 0x42 (0100 0010)
  输出: 0x84 (1000 0100)
  标志: C=0, N=1, Z=0

测试用例 2: 进位设置
  输入: 0x80 (1000 0000)
  输出: 0x00 (0000 0000)
  标志: C=1, N=0, Z=1

测试用例 3: 零页X索引
  地址: $10,X (X=5 → $15)
  验证: 正确的地址计算
```

#### LSR (Logical Shift Right)

```
测试用例 1: 正常右移
  输入: 0x42 (0100 0010)
  输出: 0x21 (0010 0001)
  标志: C=0, N=0, Z=0

测试用例 2: 进位设置
  输入: 0x01 (0000 0001)
  输出: 0x00 (0000 0000)
  标志: C=1, N=0, Z=1
```

#### ROL (Rotate Left)

```
测试用例 1: 正常旋转（C=0）
  输入: 0x42, C=0
  输出: 0x84
  标志: C=0, N=1, Z=0

测试用例 2: 进位旋转（C=1）
  输入: 0x42, C=1
  输出: 0x85
  标志: C=0, N=1, Z=0

测试用例 3: 连续旋转
  验证: 旋转 9 次后恢复原值
```

#### ROR (Rotate Right)

```
测试用例 1: 正常旋转（C=0）
  输入: 0x42, C=0
  输出: 0x21
  标志: C=0, N=0, Z=0

测试用例 2: 进位旋转（C=1）
  输入: 0x42, C=1
  输出: 0xA1
  标志: C=0, N=1, Z=0
```

### 算术指令测试要点

#### ADC (Add with Carry)

```
测试用例 1: 无进位加法
  A=0x50, M=0x10, C=0
  结果: A=0x60, C=0, V=0, N=0, Z=0

测试用例 2: 有进位加法
  A=0xFF, M=0x01, C=0
  结果: A=0x00, C=1, V=0, N=0, Z=1

测试用例 3: 溢出测试
  A=0x50, M=0x50, C=0
  结果: A=0xA0, C=0, V=1, N=1, Z=0

测试用例 4: 带进位加法
  A=0x50, M=0x10, C=1
  结果: A=0x61, C=0, V=0, N=0, Z=0
```

#### SBC (Subtract with Carry)

```
测试用例 1: 无借位减法
  A=0x50, M=0x10, C=1
  结果: A=0x40, C=1, V=0, N=0, Z=0

测试用例 2: 有借位减法
  A=0x00, M=0x01, C=1
  结果: A=0xFF, C=0, V=0, N=1, Z=0

测试用例 3: 溢出测试
  A=0x50, M=0xB0, C=1
  结果: A=0xA0, C=0, V=1, N=1, Z=0
```

#### INC/DEC

```
测试用例 1: 正常递增/递减
  输入: 0x42
  INC: 0x43, N=0, Z=0
  DEC: 0x41, N=0, Z=0

测试用例 2: 零点测试
  INC: 0xFF → 0x00, N=0, Z=1
  DEC: 0x01 → 0x00, N=0, Z=1

测试用例 3: 回绕测试
  INC: 0xFF → 0x00
  DEC: 0x00 → 0xFF, N=1, Z=0
```

### JMP indirect 特殊测试

```
测试用例 1: 正常间接跳转
  间接地址: 0x1234
  [0x1234] = 0x00
  [0x1235] = 0x80
  结果: PC = 0x8000

测试用例 2: 页边界 bug
  间接地址: 0x12FF
  [0x12FF] = 0x00
  [0x1200] = 0x80  ← 注意：不是 0x1300！
  结果: PC = 0x8000
  
  这是 6502 的硬件 bug，必须正确实现！
```

## 测试报告

每次测试后生成报告：

```
测试日期: 2025-11-28
测试版本: commit abc123
测试人员: [姓名]

=== 测试结果 ===
总计: 27/151 条新指令
通过: 25/27
失败: 2/27

=== 失败指令 ===
1. 0x6C JMP ind - 页边界 bug 未正确实现
2. 0xFE INC abs,X - 标志位设置错误

=== 性能指标 ===
平均指令周期: 4.2
最慢指令: JMP ind (5 周期)
最快指令: NOP (2 周期)

=== 建议 ===
1. 修复 JMP indirect 的页边界处理
2. 检查 INC abs,X 的标志位逻辑
```

## 持续集成

在 CI/CD 流程中自动运行测试：

```yaml
# .github/workflows/test.yml
name: Test
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run tests
        run: ./scripts/run_tests.sh
```

## 参考资料

1. [6502 指令集参考](http://www.6502.org/tutorials/6502opcodes.html)
2. [Klaus Dormann 功能测试](https://github.com/Klaus2m5/6502_65C02_functional_tests)
3. [NES 开发 Wiki](https://wiki.nesdev.com/)
4. [6502 时序图](http://www.obelisk.me.uk/6502/reference.html)
