# Tiny BASIC Migration Tests

## 测试驱动开发 (TDD) 进度

### 总体进度: 9/12 测试通过 (75%)

## 测试阶段

### Phase 1: I/O 层 ✅ 100%
- [x] test_io_output.asm - 字符输出测试

### Phase 2: 向量表 🔄 33%
- [ ] test_cold_start.asm - 冷启动向量 (JSR问题)
- [x] test_inline.asm - 内联测试
- [ ] test_vector_simple.asm - 简单向量测试 (JSR问题)

### Phase 3: IL 解释器 ✅ 100%
- [x] test_il_no.asm - NO 操作码
- [x] test_il_stack.asm - 栈操作

### Phase 4: 算术运算 ✅ 100%
- [x] test_add.asm - 加法测试
- [x] test_sub.asm - 减法测试

### Phase 5: 变量操作 ✅ 100%
- [x] test_var_store.asm - 变量存储

### Phase 6: 分支控制 ✅ 100%
- [x] test_branch.asm - 分支测试

### Phase 7: BASIC 框架 🔄 50%
- [x] test_basic_simple.asm - 简单框架
- [ ] test_minimal_basic.asm - 最小BASIC (循环问题)

## 运行测试

```bash
./run_tinybasic_tests.sh
```

## 当前状态

```
Phase 1: ✅ 1/1 (100%)
Phase 2: 🔄 1/3 (33%)
Phase 3: ✅ 2/2 (100%)
Phase 4: ✅ 2/2 (100%)
Phase 5: ✅ 1/1 (100%)
Phase 6: ✅ 1/1 (100%)
Phase 7: 🔄 1/2 (50%)

Total: 9/12 passed (75%)
```

## 已验证功能

✅ **基础功能**
- 字符输出 ($F000)
- 栈操作 (PHA/PLA)
- 算术运算 (ADC/SBC)
- 变量存储 (STA/LDA)
- 条件分支 (BEQ/BNE)
- 基本框架

⚠️ **已知问题**
1. JSR/RTS 在某些情况下导致问题
2. 循环输出需要优化

## 下一步

### 短期 (1-2小时)
1. 修复 JSR/RTS 问题
2. 完成 Phase 8-10 测试
3. 测试完整的 IL 操作码

### 中期 (3-5小时)
1. 适配完整的 tinybasic.asm
2. 实现所有 IL 操作码
3. 测试 BASIC 命令

### 长期 (5-10小时)
1. 完整的 BASIC 解释器
2. 交互式命令行
3. 程序存储和执行

## 文件结构

```
basic/tinybasic/
├── tinybasic.asm           # 原始完整版本
├── tinybasic_my6502.asm    # 适配版本
├── tinybasic_minimal.asm   # 最小版本
└── tests/
    ├── phase1/  ✅ I/O
    ├── phase2/  🔄 向量
    ├── phase3/  ✅ IL解释器
    ├── phase4/  ✅ 算术
    ├── phase5/  ✅ 变量
    ├── phase6/  ✅ 分支
    └── phase7/  🔄 框架
```

## 成功标准

### 当前里程碑 ✅
- [x] 基本 I/O 工作
- [x] 算术运算正确
- [x] 变量存储正常
- [x] 分支控制有效

### 下一个里程碑 📋
- [ ] 所有测试通过
- [ ] IL 解释器核心工作
- [ ] 简单 BASIC 程序运行

### 最终目标 🎯
```basic
10 PRINT "HELLO"
20 LET A=10
30 PRINT A
40 END
```
