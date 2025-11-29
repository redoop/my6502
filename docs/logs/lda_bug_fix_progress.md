# LDA 指令 Bug 修复进度

**日期**: 2025-11-29 18:33  
**状态**: 🔍 调试中

## 问题描述

LDA #$10 指令将 A 设置为 0xA9 (opcode) 而不是 0x10 (立即数)。

## 调试发现

### 1. LDA 指令没有进入 Execute 状态

```
[Cycle 40000] PC=0xC7A2 A=0xA9 State=Fetch(1) Cycle=1 Opcode=0xA9  <- LDA
[Cycle 50000] PC=0xC7A5 A=0xA9 State=Fetch(1) Cycle=0 Opcode=0x8D  <- STA
```

**问题**: LDA 指令直接从 Fetch 跳到下一条指令的 Fetch，完全跳过了 Execute 状态！

### 2. A 寄存器被设置为 opcode

- Cycle 30000: A=0x00 (CLD 之前)
- Cycle 40000: A=0xA9 (LDA 之后) ← 错误！
- Cycle 80000: A=0x00 (LDA $2002 之后)

### 3. 调试输出没有触发

添加的调试输出都没有触发：
- `[Dispatch] LDA/LDX/LDY immediate` - 没有输出
- `[LDA] Cycle 0/1` - 没有输出

**结论**: `dispatchInstruction` 和 `executeImmediate` 都没有被调用！

## 根本原因分析

### 可能原因 1: Fetch 状态没有正确转换到 Execute

```scala
is(sFetch) {
  when(cycle === 0.U) {
    // Cycle 0: 发出读请求
    cycle := 1.U
  }.otherwise {
    // Cycle 1: 读取数据并进入 Execute
    opcode := io.memDataIn
    regs.pc := regs.pc + 1.U
    cycle := 0.U
    state := sExecute  // ← 这里应该转换到 Execute
  }
}
```

**问题**: `state := sExecute` 可能没有生效？

### 可能原因 2: Execute 状态立即完成

如果 Execute 状态在同一个周期内完成，可能会立即返回 Fetch：

```scala
is(sExecute) {
  execResult := dispatchInstruction(...)
  regs := execResult.regs
  when(execResult.done) {
    state := sFetch  // ← 立即返回 Fetch？
  }
}
```

### 可能原因 3: Chisel 组合逻辑问题

`execResult` 是 Wire，在每个状态都会被计算。可能存在时序问题。

## 下一步调试

### 1. 添加状态转换调试

```scala
is(sFetch) {
  when(cycle === 1.U) {
    printf("[Fetch] Transitioning to Execute: opcode=0x%x\n", io.memDataIn)
    state := sExecute
  }
}

is(sExecute) {
  printf("[Execute] Entered with opcode=0x%x cycle=%d\n", opcode, cycle)
  // ...
}
```

### 2. 检查 Execute 状态是否被跳过

查看 VCD 波形，确认状态机的转换。

### 3. 检查 execResult.done 的值

可能 `execResult.done` 在 Execute 进入时就是 true，导致立即返回 Fetch。

## 修复尝试

### 尝试 1: 添加周期参数 ✅ 完成

修改 `executeImmediate` 添加 cycle 参数，分成两个周期：
- Cycle 0: 读取立即数
- Cycle 1: 执行指令

**结果**: 没有效果，因为 Execute 状态根本没有被进入。

### 尝试 2: 添加调试输出 ✅ 完成

添加了多个调试输出来追踪执行流程。

**结果**: 没有任何输出，确认 Execute 状态没有被进入。

## 总结

**核心问题**: LDA 指令没有进入 Execute 状态  
**症状**: A 寄存器被设置为 opcode 而不是立即数  
**下一步**: 添加状态转换调试，确认 Fetch → Execute 的转换

---

**报告人**: 主研发窗口  
**更新时间**: 2025-11-29 18:33
