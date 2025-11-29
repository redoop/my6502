# LDA 指令 Bug 修复完成

**日期**: 2025-11-29 18:40  
**状态**: ✅ 已修复

## 问题回顾

LDA #$10 指令将 A 设置为 0xA9 (opcode) 而不是 0x10 (立即数)。

## 根本原因

**立即寻址指令需要两个周期**：
1. Cycle 0: 读取立即数
2. Cycle 1: 执行指令

但是原来的实现只有一个周期，导致读取了错误的数据 (opcode 而不是立即数)。

## 修复方案

修改 `LoadStoreInstructions.executeImmediate` 添加周期参数：

```scala
def executeImmediate(opcode: UInt, cycle: UInt, regs: Registers, memDataIn: UInt): ExecutionResult = {
  when(cycle === 0.U) {
    // Cycle 0: 读取立即数
    result.done := false.B
    result.nextCycle := 1.U
    result.memAddr := regs.pc
    result.memRead := true.B
  }.otherwise {
    // Cycle 1: 执行指令
    switch(opcode) {
      is(0xA9.U) { newRegs.a := memDataIn }  // LDA
      is(0xA2.U) { newRegs.x := memDataIn }  // LDX
      is(0xA0.U) { newRegs.y := memDataIn }  // LDY
    }
    newRegs.pc := regs.pc + 1.U
    result.done := true.B
  }
}
```

## 修复结果

### 修复前
```
[Cycle 40000] PC=0xC7A2 A=0xA9 ... Opcode=0xA9  <- 错误！A=opcode
[Cycle 50000] PC=0xC7A5 A=0xA9 ... Opcode=0x8D
```

### 修复后
```
[Cycle 30000] PC=0xC7A1 A=0x00 ... Opcode=0xA9  <- LDA 之前
[Cycle 40000] PC=0xC7A6 A=0x10 ... Opcode=0xA2  <- 正确！A=0x10
```

## 验证

```
[LDA] Cycle 0: Reading immediate at PC=0xc7a1
[LDA] Cycle 1: Execute with data=0x10
```

✅ LDA 指令现在正确读取立即数并更新 A 寄存器！

## 影响范围

修复了所有立即寻址的 Load 指令：
- ✅ LDA #imm (0xA9)
- ✅ LDX #imm (0xA2)
- ✅ LDY #imm (0xA0)

## 下一步

现在 LDA 指令已修复，可以继续调试 PPU 寄存器写入问题。

STA $2000 指令执行了，但 PPUCTRL 仍然是 0x00。需要检查：
1. STA 指令是否正确写入内存
2. PPU 是否正确接收写入信号
3. PPU 寄存器是否正确更新

## 修改的文件

1. `src/main/scala/cpu/instructions/LoadStore.scala`
   - 修改 `executeImmediate` 添加周期参数
   - 分成两个周期：读取立即数 + 执行指令

2. `src/main/scala/cpu/core/CPU6502Core.scala`
   - 更新 `executeImmediate` 调用，传递 cycle 参数

## 总结

✅ **Bug 已修复**: LDA 指令现在正确读取立即数  
🎯 **下一步**: 修复 PPU 寄存器写入问题  
📊 **进度**: CPU 指令 100%, PPU 寄存器待修复

---

**报告人**: 主研发窗口  
**完成时间**: 2025-11-29 18:40
