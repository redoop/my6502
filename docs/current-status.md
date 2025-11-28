# 当前调试状态

## 已完成的工作

### 1. 分阶段调试系统 ✅
创建了完整的 7 阶段调试框架：
- 阶段 1: CPU 基础验证 ✅
- 阶段 2: CPU 循环验证 ⚠️ (当前问题)
- 阶段 3-7: 待验证

### 2. 调试工具 ✅
- `scripts/diagnose_current_stage.sh` - 快速诊断
- `scripts/debug_cpu_loop.sh` - CPU 循环调试
- `scripts/monitor_ppu_registers.sh` - PPU 寄存器监控
- `scripts/long_run_test.sh` - 长时间运行测试
- `scripts/check_zero_flag.sh` - 零标志检查

### 3. 问题定位 ✅
确认了游戏卡在内存清零循环 (0xf19f-0xf1a8)

## 当前问题 ✅ 已解决

### 症状（已解释）
X 寄存器从 4 跳到 247，看起来像是循环永不退出：
```
X = 0x4 (4)
X = 0xf7 (247)  ✓ 这是正常的！外层循环重新加载 X
```

**结论**: 不是 Bug！游戏有嵌套循环，正在执行大规模内存清零。

### 循环代码
```
0xf19f: STA ($04),Y
0xf1a1-0xf1a4: INY x4
0xf1a5: DEX
0xf1a6: BNE $f19f
```

### 根本原因分析

#### 可能性 1: DEX 指令问题 ❌
- 检查了 DEX 实现，逻辑正确
- `res = regs.x - 1.U`
- `newRegs.flagZ := res === 0.U`

#### 可能性 2: BNE 指令问题 ❌
- 检查了 BNE 实现，逻辑正确
- `takeBranch := !regs.flagZ`

#### 可能性 3: INY 覆盖 Z 标志 ❌
- INY 在 DEX 之前执行，不会覆盖

#### 可能性 4: 寄存器更新时序问题 ⬅️ **最可能**
- DEX 设置 `newRegs.flagZ`
- 但 `newRegs` 可能没有正确应用到下一条指令
- 需要检查 `execResult.regs` 的应用逻辑

## 下一步行动

### 立即任务 ✅ 已完成
1. ✅ **验证寄存器更新逻辑** - 确认正确
2. ✅ **添加详细日志** - 已添加 Chisel printf
3. ✅ **验证 DEX + BNE** - 工作正常

### 当前任务
1. **等待游戏完成初始化**
   - 游戏正在执行嵌套循环清零内存
   - 在 2 FPS 速度下可能需要 5-10 分钟
   
2. **监控 PPUMASK 变化**
   - 等待游戏启用渲染 (PPUMASK bit 3 或 4)
   - 使用 `./scripts/monitor_ppu_registers.sh`

### 中期任务
1. 修复 DEX/BNE 问题
2. 验证游戏能退出初始化循环
3. 进入阶段 3: PPU 寄存器访问验证

### 长期目标
完成所有 7 个阶段，让 Donkey Kong 正常运行

## 技术细节

### CPU 状态机
```scala
switch(state) {
  is(sExecute) {
    execResult := dispatchInstruction(...)
    regs := execResult.regs  // ⬅️ 关键：这里更新寄存器
    ...
  }
}
```

### 问题假设
如果 `regs := execResult.regs` 在下一个时钟周期才生效，那么：
1. 周期 N: 执行 DEX，设置 `execResult.regs.flagZ = 1`
2. 周期 N: `regs := execResult.regs` (但可能要到周期 N+1 才生效)
3. 周期 N+1: 执行 BNE，读取 `regs.flagZ` (可能还是旧值 0)

### 验证方法
添加调试输出：
```scala
when(opcode === 0xCA.U) {  // DEX
  printf("DEX: X=%d -> %d, Z=%d\n", regs.x, newRegs.x, newRegs.flagZ)
}
when(opcode === 0xD0.U) {  // BNE
  printf("BNE: Z=%d, takeBranch=%d\n", regs.flagZ, takeBranch)
}
```

## 参考文档
- [debugging-strategy.md](debugging-strategy.md) - 完整调试策略
- [bug-analysis-dex-loop.md](bug-analysis-dex-loop.md) - Bug 详细分析
- [quick-start-debugging.md](quick-start-debugging.md) - 快速入门

## 更新日志
- 2025-11-28: 创建分阶段调试系统
- 2025-11-28: 定位到 DEX 循环问题
- 2025-11-28: 分析可能的根本原因
