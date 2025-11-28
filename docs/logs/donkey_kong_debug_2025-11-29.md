# Donkey Kong 调试日志 - 2025-11-29

## 问题描述
游戏运行时 CPU PC 卡在 0xc7aa，不再前进。

## 调试过程

### 1. 发现问题
- PC 在启动时能够从 0xc79e 前进到 0xc7aa
- 但是到了 0xc7aa 就停止不动
- state=1 (sFetch), cycle=0

### 2. 分析 0xc7aa 的指令
```
0xc7aa: 0x20 0x29 0x80 = JSR $8029
```

JSR 应该：
1. 将返回地址压栈
2. 跳转到 0x8029

### 3. 检查 JSR 目标
```
0x8029: 0x60 = RTS
```

所以 JSR 0x8029 应该立即返回到 0xc7ad。

### 4. 发现的 Bug

#### Bug 1: JSR cycle 1 没有更新 PC
在 `Jump.scala` 的 `executeJSR` 中，cycle 1 读取高字节后没有更新 PC。

**修复**: 添加 `newRegs.pc := regs.pc + 1.U`

#### Bug 2: JSR 压栈地址错误
6502 的 JSR/RTS 约定：
- JSR 应该压栈 PC+2（指向 JSR 的最后一个字节）
- RTS 弹出地址并 +1

原实现压栈的是 PC（已经是 PC+3），导致 RTS 返回到错误的地址。

**修复**: 在 cycle 2 和 3 压栈 `PC-1` 而不是 `PC`

### 5. 修复后的代码
```scala
is(1.U) {
  result.memAddr := regs.pc
  result.memRead := true.B
  result.operand := Cat(memDataIn, operand(7, 0))
  newRegs.pc := regs.pc + 1.U  // 添加这行
  result.regs := newRegs
  result.nextCycle := 2.U
}
is(2.U) {
  val returnAddr = regs.pc - 1.U  // 使用 PC-1
  result.memAddr := Cat(0x01.U(8.W), regs.sp)
  result.memData := returnAddr(15, 8)
  ...
}
is(3.U) {
  val returnAddr = regs.pc - 1.U  // 使用 PC-1
  result.memAddr := Cat(0x01.U(8.W), regs.sp)
  result.memData := returnAddr(7, 0)
  ...
}
```

### 6. 测试结果
修复后重新生成 Verilog 并测试，但问题依然存在。

### 7. 下一步
需要更深入的调试：
1. 添加 Verilator 波形输出
2. 检查 opcode 是否被正确读取
3. 检查 JSR 指令是否被正确分发到 JumpInstructions
4. 检查内存读取是否正常工作

## 可能的原因
1. 内存接口时序问题
2. opcode 读取不正确
3. 指令分发逻辑有问题
4. Chisel 生成的 Verilog 有问题

## 建议
1. 创建一个简单的 JSR/RTS 测试用例
2. 使用 Verilator 的 VCD 波形输出进行详细分析
3. 在 testbench 中添加更详细的 CPU 状态输出
