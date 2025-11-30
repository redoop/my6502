# 6502 CPU 测试套件

## 测试结构

```
test_suite/
├── 01_basic/          # 基础指令测试
│   ├── test_lda.asm   # Load/Store
│   ├── test_math.asm  # ADC/SBC
│   ├── test_logic.asm # AND/ORA/EOR
│   └── test_shift.asm # ASL/LSR/ROL/ROR
├── 02_control/        # 控制流测试
│   ├── test_branch.asm
│   ├── test_jump.asm
│   └── test_subroutine.asm
├── 03_flags/          # 标志位测试
│   ├── test_carry.asm
│   ├── test_zero.asm
│   └── test_overflow.asm
├── 04_addressing/     # 寻址模式测试
│   ├── test_immediate.asm
│   ├── test_zeropage.asm
│   ├── test_absolute.asm
│   └── test_indirect.asm
└── 05_integration/    # 集成测试
    ├── test_fibonacci.asm
    ├── test_sort.asm
    └── test_string.asm
```

## 运行测试

```bash
# 编译所有测试
./compile_tests.sh

# 运行单个测试
make test TEST=test_lda

# 运行所有测试
make test-all
```

## 测试输出格式

每个测试通过 $F000 输出结果：
- 'P' (0x50) = Pass
- 'F' (0x46) = Fail
- 后跟测试编号
