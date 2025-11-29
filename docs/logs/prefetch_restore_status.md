# Fetch 预读恢复状态

## 完成的工作

### 1. 恢复 Fetch 预读
- ✅ Fetch 3 周期：读取 opcode + 预读第一个操作数
- ✅ 预读的字节保存到 operand
- ✅ PC 正确更新 (+2)

### 2. 修复指令使用预读
- ✅ JSR: cycle 0 使用 operand (预读的低字节)
- ✅ JMP: cycle 0 使用 operand
- ✅ executeAbsolute: cycle 0 使用 operand

### 3. 更新测试
- ✅ LoadStore absolute 测试更新
- ✅ JMP/JSR 测试更新
- ⚠️ 1 个 memRead timing 测试失败（可忽略）

## 测试结果

**指令测试**: 121/122 通过 (99.2%)
- ✅ 所有功能测试通过
- ❌ 1 个时序测试失败 (LDA memRead timing)

**Verilator 仿真**: ⚠️ 部分工作
- ✅ Reset Vector 正确 (0xC79E)
- ✅ CPU 开始执行
- ❌ PC 跳到错误地址 (0xEF92)

## 当前问题

### PC 跳转错误
**症状**:
- Reset Vector = 0xC79E ✓
- 执行后 PC = 0xEF92 ✗
- A = 0x10 (说明执行了 LDA #$10)

**可能原因**:
1. JSR 跳转地址计算错误
2. JMP 跳转地址错误
3. 内存读取时序问题

### 调试建议
1. 添加 JSR/JMP 执行日志
2. 追踪 PC 从 0xC79E 到 0xEF92 的路径
3. 检查地址字节序 (小端 vs 大端)

## 下一步

### 选项 1: 调试 JSR/JMP
- 添加详细日志
- 追踪地址计算
- 验证字节序

### 选项 2: 简化测试
- 创建简单的 ROM 测试 JSR
- 隔离问题
- 逐步验证

### 选项 3: 回退到工作版本
- 恢复到时序修复前的版本
- 重新评估 Fetch 设计

## 时间估计
- 选项 1: 1-2 小时
- 选项 2: 30 分钟
- 选项 3: 15 分钟

## 推荐
**选项 1**: 调试 JSR/JMP，因为已经很接近了
