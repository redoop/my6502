# Tiny BASIC Migration Tests

## 测试驱动开发 (TDD) 方法

本目录包含将 tinybasic.asm 移植到 my6502 的分阶段测试。

## 测试阶段

### Phase 1: I/O 层 ✅
- [x] test_io_output.asm - 字符输出测试

### Phase 2: 向量表 🔄
- [ ] test_cold_start.asm - 冷启动向量
- [x] test_inline.asm - 内联测试
- [ ] test_vector_simple.asm - 简单向量测试

### Phase 3: IL 解释器 📋
- [ ] test_il_no.asm - NO 操作码
- [ ] test_il_lb.asm - LB 操作码
- [ ] test_il_pc.asm - PC 操作码

### Phase 4-10: 待实现

## 运行测试

```bash
./run_tinybasic_tests.sh
```

## 当前状态

- ✅ Phase 1: 1/1 通过
- 🔄 Phase 2: 1/3 通过
- 📋 Phase 3-10: 待实现

## 已知问题

1. JSR/RTS 在某些情况下导致无限循环
2. 需要调试栈操作

## 下一步

1. 修复 Phase 2 的向量测试
2. 实现 Phase 3 的 IL 操作码测试
3. 逐步完成所有 10 个阶段
