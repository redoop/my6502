# 调试工具总结

## 🎯 目标

为 Donkey Kong 运行问题创建了完整的调试工具集。

## ✅ 已创建的工具

### 1. 详细追踪程序

**文件**: `verilator/nes_testbench_debug.cpp`

**功能**:
- 记录最近 100 条指令历史
- 检测向量表访问（PC >= 0xFFF0）
- 检测 SP 异常变化（变化 > 10）
- 追踪 JSR/RTS 调用
- 统计 PC 频率
- 自动检测问题并打印历史

**使用**:
```bash
./scripts/debug_donkey_kong.sh
```

### 2. 日志分析脚本

**文件**: `scripts/analyze_execution.py`

**功能**:
- 解析执行日志
- 统计最频繁的 PC 地址
- 检测向量表访问
- 检测 SP 异常跳变
- 检测可能的死循环

**使用**:
```bash
# 捕获日志
timeout 10 ./scripts/verilator_run.sh games/Donkey-Kong.nes 2>&1 | tee execution.log

# 分析日志
python3 scripts/analyze_execution.py execution.log
```

### 3. 快速调试脚本

**文件**: `scripts/quick_debug.sh`

**功能**:
- 运行 10 秒并捕获日志
- 自动分析向量表访问
- 显示 SP 变化
- 查找错误信息

**使用**:
```bash
./scripts/quick_debug.sh
```

### 4. 调试指南

**文件**: `docs/DEBUG_GUIDE.md`

**内容**:
- 问题描述和现象
- 可能的原因分析
- 详细的调试步骤
- 修复建议
- 6502 栈操作参考

## 📊 调试流程

### 方法 1: 使用详细追踪

```bash
# 1. 编译调试版本
./scripts/debug_donkey_kong.sh

# 2. 查看输出
# - 自动检测问题
# - 打印最近指令历史
# - 显示统计信息
```

### 方法 2: 使用日志分析

```bash
# 1. 捕获日志
timeout 10 ./scripts/verilator_run.sh games/Donkey-Kong.nes 2>&1 | tee dk.log

# 2. 分析日志
python3 scripts/analyze_execution.py dk.log

# 3. 查看结果
# - 最频繁的 PC
# - 向量表访问
# - SP 异常跳变
```

### 方法 3: 快速调试

```bash
# 一键运行
./scripts/quick_debug.sh

# 查看 dk_debug.log
less dk_debug.log
```

## 🔍 关键检查点

### 1. RTS 指令

```scala
// 检查点：
// 1. SP 是否正确增加（+2）
// 2. 读取地址是否正确（0x0100 + SP）
// 3. PC 是否正确加 1
```

### 2. JSR 指令

```scala
// 检查点：
// 1. 保存的是 PC+2 还是其他值
// 2. SP 是否正确减少（-2）
// 3. 栈地址计算是否正确
```

### 3. NMI 中断

```scala
// 检查点：
// 1. NMI 向量读取是否正确
// 2. 返回地址保存是否正确
// 3. RTI 恢复是否正确
```

## 📝 日志格式

### 标准输出

```
PC:0x1234 Op:0x20 (JSR         ) A:0x00 X:0x00 Y:0x00 SP:0xFD St:2 Cy:0 [----]
```

### 特殊标记

```
📍 JSR 调用: PC=0x1234 SP=0xFD
📍 RTS 返回: PC=0x5678 SP=0xFF
⚠️  警告: SP 变化异常
⚠️  警告: 频繁访问向量表区域
🚨 错误: CPU 在向量表区域执行代码
```

## 🎯 预期结果

### 正常执行

```
PC 范围: 0x8000 - 0xFFEF
SP 范围: 0xF0 - 0xFF
SP 变化: ±1 或 ±2（JSR/RTS）
```

### 异常执行

```
PC 在向量表: 0xFFF0 - 0xFFFF ❌
SP 剧烈变化: 变化 > 10 ❌
SP 超出范围: < 0x00 或 > 0xFF ❌
```

## 🔧 下一步行动

1. ⬜ 运行快速调试，捕获日志
2. ⬜ 分析日志，找出第一次异常
3. ⬜ 检查 RTS/JSR 实现
4. ⬜ 添加断言和额外日志
5. ⬜ 修复 bug
6. ⬜ 重新测试

## 📚 相关文档

- `docs/DEBUG_GUIDE.md` - 详细调试指南
- `docs/DONKEY_KONG_DEBUG.md` - 问题诊断
- `docs/ALL_TESTS_COMPLETE.md` - 测试完成报告

## 🎉 工具统计

- **C++ 代码**: ~400 行（详细追踪）
- **Python 代码**: ~100 行（日志分析）
- **Shell 脚本**: ~50 行（自动化）
- **文档**: ~500 行（指南和说明）

---

**状态**: ✅ 调试工具已完成  
**下一步**: 运行调试并分析结果
