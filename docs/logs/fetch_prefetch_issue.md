# Fetch 预读机制问题

## 问题描述

CPU Fetch 阶段预读下一个字节，导致多字节指令（如 JSR）读取错误的操作数。

## 症状

- JSR $C7E7 跳转到 0xE7E8 (错误地址)
- CPU 执行非法指令 0x07
- 游戏无法正常运行

## 根本原因

### 当前 Fetch 实现
```scala
is(sFetch) {
  when(cycle === 0.U) {
    io.memAddr := regs.pc
    io.memRead := true.B
    cycle := 1.U
  }.elsewhen(cycle === 1.U) {
    opcode := io.memDataIn
    regs.pc := regs.pc + 1.U  // PC+1
    io.memAddr := regs.pc      // 预读下一个字节
    io.memRead := true.B
    cycle := 2.U
  }.otherwise {
    // cycle 2: 预读的字节在 memDataIn，但没有保存
    cycle := 0.U
    state := sExecute
  }
}
```

### 问题
1. Fetch 预读了第一个操作数字节，但没有保存到 operand
2. Fetch 预读后没有更新 PC
3. Execute 阶段的指令不知道已经预读了，重新读取导致地址错误

### 示例：JSR $C7E7

**期望**:
```
Fetch: 读取 0x20 (JSR), PC=0xC7C3
Execute cycle 0: 读取 0xE7 (低字节) from PC=0xC7C3
Execute cycle 1: 读取 0xC7 (高字节) from PC=0xC7C4
结果: 跳转到 0xC7E7
```

**实际**:
```
Fetch cycle 1: 读取 0x20, PC+1=0xC7C3, 预读 PC=0xC7C3
Fetch cycle 2: memDataIn=0xE7 (但没保存)
Execute cycle 0: 读取 from PC=0xC7C3 → 得到 0xE8 (下一个字节!)
Execute cycle 1: 读取 from PC=0xC7C4 → 得到 0xE7
结果: 跳转到 0xE7E8 ❌
```

## 解决方案

### 方案 1: 移除预读 (简单但慢)
```scala
is(sFetch) {
  when(cycle === 0.U) {
    io.memAddr := regs.pc
    io.memRead := true.B
    cycle := 1.U
  }.otherwise {
    opcode := io.memDataIn
    regs.pc := regs.pc + 1.U
    cycle := 0.U
    state := sExecute
  }
}
```

**优点**: 简单，不破坏指令独立性  
**缺点**: 每条指令多 1 个周期，性能下降

### 方案 2: 保存预读值 (推荐)
```scala
is(sFetch) {
  when(cycle === 0.U) {
    io.memAddr := regs.pc
    io.memRead := true.B
    cycle := 1.U
  }.elsewhen(cycle === 1.U) {
    opcode := io.memDataIn
    regs.pc := regs.pc + 1.U
    io.memAddr := regs.pc
    io.memRead := true.B
    cycle := 2.U
  }.otherwise {
    operand := io.memDataIn  // 保存预读的字节
    regs.pc := regs.pc + 1.U  // PC 指向第二个操作数
    cycle := 0.U
    state := sExecute
  }
}
```

然后修改所有多字节指令使用 operand 中的预读值。

**优点**: 保持性能  
**缺点**: 需要修改所有指令和测试

### 方案 3: 条件预读
只为 1 字节指令预读，多字节指令自己读取。

**优点**: 兼容性好  
**缺点**: 需要在 Fetch 时知道指令长度（复杂）

## 影响范围

需要修改的指令：
- ✅ 1 字节: NOP, DEX, INX, etc. (不受影响)
- ⚠️ 2 字节: LDA #$nn, ADC #$nn, etc. (可能受影响)
- ❌ 3 字节: JMP $nnnn, JSR $nnnn, LDA $nnnn, etc. (严重影响)

## 临时解决方案

当前无法快速修复。建议：
1. 创建 Issue #5: "Refactor Fetch prefetch mechanism"
2. 标记为 P0 (阻塞游戏运行)
3. 需要系统性重构，预计 2-3 小时

## 测试验证

修复后需要验证：
- ✅ 所有指令测试通过
- ✅ JSR/RTS 正确工作
- ✅ JMP 正确工作
- ✅ 游戏能正常运行

## 参考

- CPU6502Core.scala: Fetch 实现
- Jump.scala: JSR/JMP 实现
- 所有指令测试: src/test/scala/cpu/instructions/
