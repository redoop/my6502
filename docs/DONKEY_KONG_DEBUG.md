# Donkey Kong 运行问题诊断

## 🐛 问题描述

Donkey Kong 运行时 CPU 跳转到向量表区域（0xFFF6-0xFFF8），导致无法正常运行。

## 📊 观察到的现象

```
帧: 4 | FPS: 3.6 | PC: 0xfff6 | SP: 0x85
帧: 3 | FPS: 2.9 | PC: 0xfff8 | SP: 0x42
帧: 4 | FPS: 3.1 | PC: 0xfff8 | SP: 0x90
```

### 异常特征

1. **PC 在向量表区域** (0xFFF0-0xFFFF)
2. **SP 变化剧烈** (0x85 → 0x42 → 0x90)
3. **执行向量表数据** (0x00, 0x8E)

## 🔍 可能的原因

### 1. 栈操作问题 ⚠️

SP 变化剧烈表明可能有栈操作问题：
- RTS/RTI 指令可能从栈中读取了错误的返回地址
- JSR 指令可能没有正确保存返回地址
- 栈溢出或下溢

### 2. 跳转指令问题

- JMP indirect 可能没有正确实现页边界 bug
- JSR/RTS 的地址计算可能有误
- 分支指令的地址计算可能有误

### 3. 中断处理问题

- NMI 中断可能没有正确处理
- BRK 指令可能有问题
- RTI 指令可能没有正确恢复状态

### 4. 指令实现 bug

某个高频使用的指令可能有 bug：
- ADC/SBC 的标志位设置
- INC/DEC 的标志位设置
- 移位指令的进位处理

## 🎯 诊断步骤

### 步骤 1: 检查初始启动

```bash
# 查看 CPU 初始化过程
./scripts/verilator_run.sh games/Donkey-Kong.nes 2>&1 | head -50
```

预期：
- Reset vector 正确读取 (0xC79E)
- PC 正确跳转到 0xC79E
- 开始执行初始化代码

### 步骤 2: 追踪 PC 变化

需要添加详细的 PC 追踪日志：
- 记录每次 PC 改变
- 记录每次跳转/分支
- 记录栈操作

### 步骤 3: 检查栈操作

重点检查：
- JSR 指令是否正确压栈
- RTS 指令是否正确出栈
- SP 的变化是否合理

### 步骤 4: 检查高频指令

Donkey Kong 中使用最频繁的指令：
1. BRK (789次) - 可能是数据，不是指令
2. ORA (ind,X) (503次)
3. ORA zp (205次)
4. ASL zp (167次)
5. PHP (175次)

## 🔧 建议的修复方向

### 优先级 1: 检查 RTS/RTI

```scala
// 检查 RTS 实现
def executeRTS(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
  // 确保：
  // 1. 正确从栈读取返回地址
  // 2. PC = 返回地址 + 1
  // 3. SP 正确增加
}
```

### 优先级 2: 检查 JSR

```scala
// 检查 JSR 实现
def executeJSR(cycle: UInt, regs: Registers, operand: UInt, memDataIn: UInt): ExecutionResult = {
  // 确保：
  // 1. 保存 PC-1 到栈
  // 2. SP 正确减少
  // 3. PC 跳转到目标地址
}
```

### 优先级 3: 检查 NMI 处理

```scala
// 检查 NMI 中断处理
is(sNMI) {
  // 确保：
  // 1. 正确保存 PC 和状态
  // 2. 正确读取 NMI 向量
  // 3. 正确跳转到中断处理程序
}
```

## 📝 调试建议

### 1. 添加详细日志

在 Verilator 测试中添加：
```cpp
if (pc_changed) {
    printf("PC: 0x%04X -> 0x%04X, Opcode: 0x%02X, SP: 0x%02X\n",
           old_pc, new_pc, opcode, sp);
}
```

### 2. 断点调试

在关键位置设置断点：
- PC 进入向量表区域时
- SP 变化超过阈值时
- 执行 JSR/RTS/RTI 时

### 3. 对比测试

与已知正确的模拟器对比：
- 记录前 1000 条指令的执行
- 对比 PC、SP、寄存器的变化
- 找出第一个不同的地方

## 🎓 参考资料

### 6502 栈操作

```
栈位置: 0x0100-0x01FF
SP 初始值: 0xFF (指向 0x01FF)

JSR:
  1. 将 PC+2 的高字节压栈
  2. 将 PC+2 的低字节压栈
  3. SP -= 2
  4. PC = 目标地址

RTS:
  1. SP += 1
  2. 读取低字节
  3. SP += 1
  4. 读取高字节
  5. PC = (高字节 << 8 | 低字节) + 1
```

### NMI 中断

```
NMI 触发时:
  1. 将 PC 高字节压栈
  2. 将 PC 低字节压栈
  3. 将状态寄存器压栈（B=0）
  4. 设置 I 标志
  5. 读取 NMI 向量 (0xFFFA-0xFFFB)
  6. PC = NMI 向量
```

## 🚀 下一步行动

1. ⬜ 添加详细的 PC 追踪日志
2. ⬜ 检查 RTS/JSR 实现
3. ⬜ 检查 NMI 处理
4. ⬜ 对比测试与参考模拟器
5. ⬜ 修复发现的 bug
6. ⬜ 重新测试 Donkey Kong

## 📊 测试计划

### 单元测试

创建针对性的单元测试：
```scala
"RTS instruction" should "correctly return from subroutine" in {
  // 测试 JSR + RTS 组合
  // 验证 PC 和 SP 的正确性
}

"NMI interrupt" should "correctly handle interrupt" in {
  // 测试 NMI 触发
  // 验证栈和 PC 的正确性
}
```

### 集成测试

使用简单的测试 ROM：
1. 只包含 JSR/RTS 的测试
2. 只包含 NMI 的测试
3. 逐步增加复杂度

---

**状态**: 🔴 问题待修复  
**优先级**: 高  
**预计时间**: 1-2 天
