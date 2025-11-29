# Fetch 重构状态

## 完成的工作

### 1. 移除 Fetch 预读
- ✅ Fetch 从 3 周期减少到 2 周期
- ✅ 移除了预读下一个字节的逻辑
- ✅ 简化了 Fetch 状态机

### 2. 优化指令实现
- ✅ executeAbsolute 从 5 周期优化到 3 周期
- ✅ 使用组合逻辑在 cycle 2 立即读取数据
- ✅ 所有指令测试通过 (122+/122+)

## 当前问题

### Verilator 仿真卡住
**症状**:
- CPU 卡在 PC=0xC7A4, cycle=1
- STA $2000 指令无法完成
- PPUCTRL 没有被写入

**可能原因**:
1. 内存读取延迟 - Verilator testbench 的内存模型可能有延迟
2. 时序不匹配 - 移除预读后，内存读取时序变化
3. SyncReadMem 延迟 - Chisel 的 SyncReadMem 有 1 周期延迟

### 测试 vs 仿真差异
- ✅ Chisel 测试: 所有通过
- ❌ Verilator 仿真: 卡住

说明问题在 Verilator testbench 或内存模型。

## 下一步

### 选项 1: 修复 Verilator testbench
- 检查内存读取延迟
- 添加等待周期
- 同步内存访问

### 选项 2: 恢复 Fetch 预读
- 回退到原始设计
- 保持 3 周期 Fetch
- 修复 JSR 使用预读值

### 选项 3: 添加内存延迟补偿
- 在指令中添加额外等待周期
- 适应 SyncReadMem 的延迟
- 但会降低性能

## 推荐方案

**方案 2**: 恢复 Fetch 预读，但正确实现

原因:
1. Fetch 预读是性能优化，符合流水线设计
2. 问题不是预读本身，而是如何使用预读的数据
3. 只需要修复 JSR/JMP 等指令正确使用 operand

### 实现步骤
1. 恢复 Fetch 3 周期，保存预读到 operand
2. 修改 JSR: cycle 0 使用 operand (预读的低字节)
3. 修改 JMP: 同样使用 operand
4. 更新测试以匹配新的时序

## 时间估计
- 方案 1: 2-3 小时 (调试 Verilator)
- 方案 2: 1 小时 (恢复并修复)
- 方案 3: 1-2 小时 (添加延迟)

推荐: **方案 2** (最快且正确)
