# CPU LDA 指令 Bug 发现

**日期**: 2025-11-29 18:28  
**窗口**: 主研发窗口  
**优先级**: 🔴 Critical

## 问题发现

在调试 PPU 寄存器写入时，发现了一个更严重的问题：**LDA 指令没有正确执行**。

### 现象

```
[Cycle 40000] PC=0xC7A2 A=0xA9 ... Opcode=0xA9  <- LDA #$10
[Cycle 50000] PC=0xC7A5 A=0xA9 ... Opcode=0x8D  <- STA $2000
```

**预期**: LDA #$10 应该将 A 设置为 0x10  
**实际**: A 的值是 0xA9 (LDA 的 opcode)

### 游戏代码

```assembly
$C7A2: A9 10     LDA #$10      ; A 应该 = 0x10
$C7A5: 8D 00 20  STA $2000     ; 写入 PPUCTRL
```

### 根本原因

LDA 指令读取了错误的数据：
- 读取了 opcode (0xA9) 而不是立即数 (0x10)
- 或者 LDA 指令的执行逻辑有问题

## 影响范围

这是一个 **Critical** 级别的 bug：
- ❌ 所有 LDA 指令都可能受影响
- ❌ 导致 CPU 执行错误的数据
- ❌ 阻塞所有游戏功能

## 调试步骤

### 1. 检查 LDA 指令实现

查看 `src/main/scala/cpu/instructions/LoadStore.scala`:
```scala
// LDA Immediate
when(opcode === 0xA9.U) {
  // 应该读取 PC+1 的立即数
  // 而不是 opcode 本身
}
```

### 2. 检查内存读取时序

LDA #$10 的执行应该是：
1. Cycle 1: Fetch opcode (0xA9) at PC
2. Cycle 2: Read immediate value (0x10) at PC+1
3. Cycle 3: Update A register

### 3. 检查 PC 递增

PC 应该在正确的时机递增：
- Fetch 后 PC+1
- 读取立即数后 PC+1

## 下一步行动

### 优先级 1: 修复 LDA 指令
- [ ] 检查 LoadStore.scala 中的 LDA 实现
- [ ] 确认立即数读取逻辑
- [ ] 确认 PC 递增时序

### 优先级 2: 测试其他指令
- [ ] 检查其他立即数指令 (ADC, CMP, etc.)
- [ ] 确认所有指令都正确读取操作数

### 优先级 3: 回归测试
- [ ] 运行单元测试
- [ ] 确认没有破坏其他功能

## 相关文件

- `src/main/scala/cpu/instructions/LoadStore.scala`
- `src/main/scala/cpu/core/CPU6502Core.scala`
- `src/test/scala/cpu/instructions/LoadStoreInstructionsSpec.scala`

## 总结

**发现**: LDA 指令读取了 opcode 而不是立即数  
**影响**: Critical - 阻塞所有功能  
**下一步**: 修复 LDA 指令实现

---

**报告人**: 主研发窗口  
**发现时间**: 2025-11-29 18:28
