# Donkey Kong 调试指南

## 🎯 目标

找出为什么 Donkey Kong 运行时 CPU 会跳转到向量表区域（0xFFF0-0xFFFF）。

## 🔧 调试工具

### 1. 详细追踪版本

使用增强的测试程序，记录每条指令的执行：

```bash
# 编译并运行调试版本
./scripts/debug_donkey_kong.sh
```

特点：
- 记录最近 100 条指令历史
- 检测向量表访问
- 检测 SP 异常变化
- 追踪 JSR/RTS 调用
- 统计 PC 频率

### 2. 日志分析

捕获执行日志并分析：

```bash
# 运行并保存日志
timeout 10 ./scripts/verilator_run.sh games/Donkey-Kong.nes 2>&1 | tee execution.log

# 分析日志
python3 scripts/analyze_execution.py execution.log
```

分析内容：
- 最频繁的 PC 地址
- 向量表访问次数和位置
- SP 异常跳变
- 可能的死循环

### 3. 对比参考模拟器

使用已知正确的模拟器对比：

```bash
# 使用 FCEUX 或其他模拟器
fceux --loadlua trace.lua games/Donkey-Kong.nes

# 对比前 1000 条指令
diff our_trace.log reference_trace.log
```

## 📊 当前观察

### 问题现象

```
帧: 4 | FPS: 3.6 | PC: 0xfff6 | SP: 0x85
帧: 3 | FPS: 2.9 | PC: 0xfff8 | SP: 0x42
帧: 4 | FPS: 3.1 | PC: 0xfff8 | SP: 0x90
```

### 异常特征

1. **PC 在向量表区域** (0xFFF6, 0xFFF8)
2. **SP 变化剧烈** (0x85 → 0x42 → 0x90)
3. **执行向量表数据** (0x00, 0x8E)

## 🔍 可能的原因

### 1. RTS 指令问题 ⚠️ 高优先级

RTS 可能从栈中读取了错误的返回地址：

```scala
// 检查点：
// 1. SP 是否正确增加
// 2. 读取的地址是否正确
// 3. PC = 返回地址 + 1 是否正确
```

### 2. JSR 指令问题

JSR 可能没有正确保存返回地址：

```scala
// 检查点：
// 1. 保存的是 PC-1 还是 PC+2？
// 2. SP 是否正确减少
// 3. 栈地址计算是否正确
```

### 3. NMI 中断问题

NMI 可能没有正确处理：

```scala
// 检查点：
// 1. NMI 向量是否正确读取
// 2. 返回地址是否正确保存
// 3. RTI 是否正确恢复状态
```

### 4. 栈溢出

栈可能溢出或下溢：

```
正常栈范围: 0x0100-0x01FF
SP 初始值: 0xFD (指向 0x01FD)

如果 SP < 0x00 或 SP > 0xFF，可能有问题
```

## 🎯 调试步骤

### 步骤 1: 捕获初始执行

```bash
# 运行 10 秒并保存日志
timeout 10 ./scripts/verilator_run.sh games/Donkey-Kong.nes 2>&1 | tee dk_trace.log

# 查看前 100 行
head -100 dk_trace.log

# 查找向量表访问
grep "0xfff" dk_trace.log
```

### 步骤 2: 分析日志

```bash
# 运行分析脚本
python3 scripts/analyze_execution.py dk_trace.log

# 查看结果：
# - 最频繁的 PC
# - 向量表访问
# - SP 异常跳变
```

### 步骤 3: 检查特定指令

```bash
# 查找 JSR 调用
grep "JSR" dk_trace.log

# 查找 RTS 返回
grep "RTS" dk_trace.log

# 查找 NMI
grep "NMI" dk_trace.log
```

### 步骤 4: 对比参考

如果有参考模拟器的日志：

```bash
# 对比前 1000 行
diff <(head -1000 dk_trace.log) <(head -1000 reference.log)

# 找出第一个不同的地方
diff -y dk_trace.log reference.log | grep "|" | head -1
```

## 🔧 修复建议

### 检查 RTS 实现

```scala
// src/main/scala/cpu/instructions/Jump.scala
def executeRTS(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
  // 周期 0: SP += 1
  // 周期 1: 读取低字节，SP += 1
  // 周期 2: 读取高字节，PC = (高字节 << 8 | 低字节) + 1
  
  // ⚠️ 检查：
  // 1. SP 增加的时机是否正确
  // 2. 读取地址是否正确 (0x0100 + SP)
  // 3. PC 是否正确加 1
}
```

### 检查 JSR 实现

```scala
def executeJSR(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
  // 周期 0: 读取目标地址低字节
  // 周期 1: 读取目标地址高字节
  // 周期 2: 保存 PC 高字节，SP -= 1
  // 周期 3: 保存 PC 低字节，SP -= 1，PC = 目标地址
  
  // ⚠️ 检查：
  // 1. 保存的 PC 是当前 PC 还是 PC-1？
  // 2. 栈地址是否正确
}
```

### 添加断言

在代码中添加断言来捕获问题：

```scala
// 检查 SP 范围
assert(regs.sp >= 0.U && regs.sp <= 0xFF.U, "SP out of range")

// 检查 PC 不在向量表
when(regs.pc >= 0xFFF0.U && regs.pc <= 0xFFFF.U && state === sExecute) {
  printf("ERROR: Executing in vector table area!\n")
}
```

## 📝 调试日志格式

### 标准格式

```
PC:0x1234 Op:0x20 (JSR         ) A:0x00 X:0x00 Y:0x00 SP:0xFD St:2 Cy:0 [----]
```

字段说明：
- PC: 程序计数器
- Op: 操作码
- A/X/Y: 寄存器
- SP: 栈指针
- St: CPU 状态 (0=Reset, 1=Fetch, 2=Execute)
- Cy: 指令周期
- [NVZC]: 标志位 (N=负数, V=溢出, Z=零, C=进位)

### 特殊标记

```
📍 JSR 调用: PC=0x1234 SP=0xFD
📍 RTS 返回: PC=0x5678 SP=0xFF
⚠️  警告: SP 变化异常 (0xFD -> 0x42)
⚠️  警告: 频繁访问向量表区域!
🚨 错误: CPU 在向量表区域执行代码!
```

## 🎓 6502 栈操作参考

### JSR (Jump to Subroutine)

```
指令: JSR $1234

执行过程:
1. 读取目标地址低字节 ($1234 的低字节)
2. 读取目标地址高字节 ($1234 的高字节)
3. 将 (PC+2) 的高字节压栈
4. 将 (PC+2) 的低字节压栈
5. PC = $1234

注意: 保存的是 PC+2，不是 PC+3
```

### RTS (Return from Subroutine)

```
指令: RTS

执行过程:
1. SP += 1
2. 从栈读取低字节
3. SP += 1
4. 从栈读取高字节
5. PC = (高字节 << 8 | 低字节) + 1

注意: 读取后要加 1
```

### 栈地址计算

```
栈位置: 0x0100 - 0x01FF
栈地址 = 0x0100 + SP

例如:
SP = 0xFD → 栈地址 = 0x01FD
SP = 0x00 → 栈地址 = 0x0100
SP = 0xFF → 栈地址 = 0x01FF
```

## 🚀 下一步

1. ⬜ 运行调试版本，捕获详细日志
2. ⬜ 分析日志，找出第一次跳转到向量表的位置
3. ⬜ 检查该位置之前的 JSR/RTS 调用
4. ⬜ 验证栈操作是否正确
5. ⬜ 修复发现的 bug
6. ⬜ 重新测试

## 📚 参考资料

- [6502 指令集参考](http://www.6502.org/tutorials/6502opcodes.html)
- [6502 时序图](http://www.obelisk.me.uk/6502/reference.html)
- [NES Dev Wiki](https://wiki.nesdev.com/)

---

**状态**: 🔧 调试工具已准备  
**下一步**: 运行调试并分析日志
