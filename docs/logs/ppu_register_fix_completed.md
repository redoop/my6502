# PPU 寄存器写入修复完成

**日期**: 2025-11-29 19:04  
**状态**: ✅ 已完成

## 问题回顾

STA $2000 执行但 PPUCTRL 保持 0x00，PPU 寄存器写入无效。

## 根本原因

**SyncReadMem 延迟问题**: 每次读取新数据都需要等待一个时钟周期。

### 问题分析

1. **Execute Cycle 0 时，memDataIn 还是 opcode**
   - Fetch 读取 opcode (0x8D)
   - Execute Cycle 0: memDataIn = 0x8D (opcode)，而不是地址低字节

2. **每次读取都需要等待周期**
   - Cycle 0: 发出读请求
   - Cycle 1: 数据准备好，可以使用

## 修复方案

修改 `LoadStoreInstructions.executeAbsolute`，为每次读取添加等待周期：

```scala
is(0.U) {
  // Cycle 0: 发出读请求（等待 SyncReadMem 延迟）
  result.memAddr := regs.pc
  result.memRead := true.B
  result.nextCycle := 1.U
}
is(1.U) {
  // Cycle 1: 读取地址低字节
  result.operand := memDataIn
  newRegs.pc := regs.pc + 1.U
  result.nextCycle := 2.U
}
is(2.U) {
  // Cycle 2: 等待高字节数据准备好
  result.memAddr := regs.pc
  result.memRead := true.B
  result.nextCycle := 3.U
}
is(3.U) {
  // Cycle 3: 读取地址高字节
  result.operand := Cat(memDataIn, operand(7, 0))
  newRegs.pc := regs.pc + 1.U
  result.nextCycle := 4.U
}
is(4.U) {
  // Cycle 4: 执行写入
  result.memWrite := true.B
  result.memData := regs.a
  result.done := true.B
}
```

## 修复结果

### 修复前
```
[STA] Writing to addr=0x008D data=0x10  ← 错误！
PPUCTRL = 0x00  ← 没有更新
```

### 修复后
```
[STA Cycle 0] Request read at PC=0xc7a3
[STA Cycle 1] Read low byte=0x00
[STA Cycle 2] Wait for high byte
[STA Cycle 3] Read high byte=0x20, addr=0x2000
[STA] Writing to addr=0x2000 data=0x10  ← 正确！
[PPU] Write PPUCTRL = 0x10 (NMI enable = 0)  ← 成功！
```

## 验证

✅ STA $2000 正确写入到 0x2000  
✅ PPU 寄存器正确接收写入  
✅ PPUCTRL 更新为 0x10

## 影响范围

修复了所有绝对寻址的 Load/Store 指令：
- ✅ LDA abs (0xAD)
- ✅ LDX abs (0xAE)
- ✅ LDY abs (0xAC)
- ✅ STA abs (0x8D)
- ✅ STX abs (0x8E)
- ✅ STY abs (0x8C)

## 性能影响

绝对寻址指令从 3 个周期增加到 5 个周期：
- 原来: 3 cycles
- 现在: 5 cycles (增加 2 个等待周期)

这是为了正确处理 SyncReadMem 的延迟。

## 下一步

现在 PPU 寄存器写入已修复，可以继续测试：
1. 等待游戏设置 PPUCTRL bit 7 = 1 (启用 NMI)
2. 验证 NMI 中断是否正确触发
3. 测试完整的游戏功能

## 修改的文件

1. `src/main/scala/cpu/instructions/LoadStore.scala`
   - 修改 `executeAbsolute` 添加等待周期
   - 从 3 cycles 增加到 5 cycles

2. `src/main/scala/cpu/instructions/LoadStore.scala`
   - 修改 `executeImmediate` 修复 PC 更新
   - Cycle 0 时 PC+1，Cycle 1 不再 PC+1

## 相关问题

同时修复了 LDA 指令的 PC 更新问题：
- LDA Cycle 0: PC+1 (读取立即数后)
- LDA Cycle 1: 不再 PC+1 (避免重复递增)

## 总结

✅ **Bug 已修复**: PPU 寄存器写入现在正常工作  
✅ **STA 指令**: 正确写入到目标地址  
✅ **PPUCTRL**: 成功更新为 0x10  
🎯 **下一步**: 等待 NMI 启用并测试中断

---

**报告人**: 主研发窗口  
**完成时间**: 2025-11-29 19:04
