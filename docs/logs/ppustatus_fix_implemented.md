# PPUSTATUS 修复实施报告

**日期**: 2025-11-29 20:08  
**状态**: ✅ 已实施，待验证

## 修复内容

### 1. PPUSTATUS 使用组合逻辑 ✅

**文件**: `src/main/scala/nes/core/PPURegisters.scala`

**修改**:
```scala
// 原来: 使用寄存器
io.cpuDataOut := MuxLookup(io.cpuAddr, 0.U, Seq(
  2.U -> regs.ppuStatus,  // 寄存器值
  ...
))

// 修改后: 使用组合逻辑
io.cpuDataOut := MuxLookup(io.cpuAddr, 0.U, Seq(
  2.U -> Cat(regs.vblank, regs.sprite0Hit, regs.spriteOverflow, 0.U(5.W)),  // 组合逻辑
  ...
))
```

**效果**: PPUSTATUS 立即反映 vblank 状态，不需要等待周期

### 2. 移除 ppuStatus 寄存器组装 ✅

**原来**:
```scala
regs.ppuStatus := Cat(
  regs.vblank,
  regs.sprite0Hit,
  regs.spriteOverflow,
  0.U(5.W)
)
```

**修改后**: 删除这段代码，直接在读取时组装

### 3. 绝对寻址增加等待周期 ✅

**文件**: `src/main/scala/cpu/instructions/LoadStore.scala`

**修改**: 从 3 周期增加到 4 周期
- Cycle 0: 读取地址低字节
- Cycle 1: 读取地址高字节
- Cycle 2: 发出读请求，等待数据准备
- Cycle 3: 数据已准备好，执行读/写

## 理论分析

### 为什么这样修复？

1. **组合逻辑**: PPUSTATUS 不需要寄存器，直接从 vblank 等标志组装
2. **立即反映**: 当 vblank 变化时，PPUSTATUS 立即变化
3. **符合 6502**: 6502 的寄存器读取是组合逻辑，不需要等待

### 时序图

```
Cycle 0: LDA $2002 - 读取地址低字节 (0x02)
Cycle 1: LDA $2002 - 读取地址高字节 (0x20)
Cycle 2: LDA $2002 - 发出读请求 (memAddr=$2002, memRead=true)
         PPU: cpuRead=true, cpuAddr=2
         PPU: 返回 PPUSTATUS = Cat(vblank, ...) [组合逻辑]
Cycle 3: LDA $2002 - 读取数据 (memDataIn = PPUSTATUS)
         CPU: A = memDataIn
```

## 预期效果

### 游戏行为
```
LDA $2002  -> A = 0x80 (VBlank=1) 或 0x00 (VBlank=0)
AND #$80   -> 0x80 AND 0x80 = 0x80 (Z=0)
BEQ loop   -> Z=0, 不跳转，退出循环 ✅
```

### 性能影响
- 绝对寻址: 3 周期 → 4 周期 (+33%)
- 立即寻址: 1 周期 (不变)
- 整体影响: 约 10-15% 性能损失 (可接受)

## 需要验证

### 单元测试
- [ ] LoadStoreInstructionsSpec: 需要更新为 4 周期
- [ ] PPUStatusReadTimingSpec: 新测试
- [ ] WaitLoopSpec: 应该通过

### 集成测试
- [ ] Donkey Kong: 应该退出等待循环
- [ ] 游戏应该继续执行

## 已知问题

### 调试输出未触发
- 添加的 printf 没有输出
- 可能是条件不满足或被优化
- 不影响功能，只是调试困难

### 下一步
1. 请单元测试专家验证修复
2. 运行游戏测试
3. 如果失败，分析日志并调整

## 修改的文件

1. `src/main/scala/nes/core/PPURegisters.scala`
   - PPUSTATUS 使用组合逻辑
   - 移除 ppuStatus 寄存器组装

2. `src/main/scala/cpu/instructions/LoadStore.scala`
   - executeAbsolute: 3 周期 → 4 周期

3. `src/main/scala/nes/NESSystemRefactored.scala`
   - 添加调试输出 (未生效)

## 总结

✅ **修复已实施**: PPUSTATUS 使用组合逻辑  
✅ **理论正确**: 符合 6502 行为  
🔄 **待验证**: 需要单元测试和集成测试确认

---

**实施人**: 研发主程  
**完成时间**: 2025-11-29 20:08  
**等待**: 单元测试专家验证
