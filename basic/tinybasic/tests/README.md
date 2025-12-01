# Tiny BASIC Migration Tests

## 测试驱动开发 (TDD) 进度

### 总体进度: 12/12 测试通过 (100%) ✅

## 测试阶段

### Phase 1: I/O 层 ✅ 100%
- [x] test_io_output.asm - 字符输出测试

### Phase 2: 向量表 ✅ 100%
- [x] test_cold_start.asm - 冷启动向量
- [x] test_inline.asm - 内联测试
- [x] test_vector_simple.asm - 简单向量测试

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

### Phase 7: BASIC 框架 ✅ 100%
- [x] test_basic_simple.asm - 简单框架
- [x] test_minimal_basic.asm - 最小BASIC

## 运行测试

```bash
./run_tinybasic_tests.sh
```

## 当前状态

```
Phase 1: ✅ 1/1 (100%)
Phase 2: ✅ 3/3 (100%)
Phase 3: ✅ 2/2 (100%)
Phase 4: ✅ 2/2 (100%)
Phase 5: ✅ 1/1 (100%)
Phase 6: ✅ 1/1 (100%)
Phase 7: ✅ 2/2 (100%)

Total: 12/12 passed (100%) ✅
```

## 已验证功能

✅ **基础功能**
- 字符输出 ($F000)
- 冷启动/热启动向量
- JSR/RTS 子程序调用
- 栈操作 (PHA/PLA)
- 算术运算 (ADC/SBC)
- 变量存储 (STA/LDA)
- 条件分支 (BEQ/BNE)
- BASIC 框架

## 关键发现

### 内存映射
- 代码加载地址: **$0300** (不是 $0200)
- Reset vector: $FFFC
- 输出端口: $F000
- 输入端口: $F001

### 测试运行器行为
```c
memcpy(&mem[0x0300], buf, size - 2);  // 代码加载到 $0300
mem[0xFFFC] = buf[size-2];            // Reset vector
mem[0xFFFD] = buf[size-1];
```

## 下一步

### 已完成 ✅
- [x] 所有基础测试通过
- [x] 核心功能验证
- [x] 内存映射确认

### 下一阶段 📋
1. 实现完整的 IL 解释器
2. 测试所有 47 个 IL 操作码
3. 运行真正的 BASIC 程序

## 文件结构

```
basic/tinybasic/
├── tinybasic.asm           # 原始完整版本
├── tinybasic_my6502.asm    # 适配版本
├── tinybasic_minimal.asm   # 最小版本
└── tests/
    ├── phase1/  ✅ I/O (1/1)
    ├── phase2/  ✅ 向量 (3/3)
    ├── phase3/  ✅ IL解释器 (2/2)
    ├── phase4/  ✅ 算术 (2/2)
    ├── phase5/  ✅ 变量 (1/1)
    ├── phase6/  ✅ 分支 (1/1)
    └── phase7/  ✅ 框架 (2/2)
```

## 成功！

所有测试通过，核心功能已验证，可以开始实现完整的 Tiny BASIC 解释器。
