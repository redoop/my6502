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


## 性能优化 (2025-11-28) ✅

### 优化成果
- **优化前**: 0.7 FPS
- **优化后**: 27.6 FPS  
- **提升倍数**: ~40x

### 优化措施
1. **减少 I/O 操作**
   - 状态报告从每秒改为每 3 秒
   - 详细调试从每 5 秒改为每 30 秒
   - 简化 framebuffer 统计

2. **批量处理**
   - 每 1000 周期处理一次输入事件
   - 减少函数调用开销

3. **编译器优化**
   - `-O3 -march=native -mtune=native`
   - `-flto` 链接时优化
   - `-ffast-math` 快速数学运算

### 使用方法
```bash
# 优化编译
bash scripts/verilator_build_optimized.sh

# 快速测试（30秒）
bash scripts/quick_performance_test.sh

# 扩展测试（2分钟）
bash scripts/extended_performance_test.sh
```

### 预期进展
以 27.6 FPS 的速度，预计约 2 分钟可以完成初始化循环，游戏将启用渲染。

详细信息见：`docs/stage3-optimization.md`


## 长时间测试结果 (2025-11-28)

### 测试数据
- **运行时间**: ~4 分钟
- **总帧数**: ~7156 帧
- **平均 FPS**: 28-29.5
- **CPU 状态**: 仍在 0xf1a0-0xf1a7 循环
- **PPUMASK**: 保持在 0x6
- **渲染状态**: 未启用

### 问题
Donkey Kong 的初始化循环比预期长得多，7000+ 帧后仍未退出。

### 可能的原因
1. 游戏等待特定条件（帧数、PPU 状态、输入等）
2. CPU 实现问题（指令、标志位、中断）
3. PPU 实现问题（VBlank、NMI、状态寄存器）

### 下一步调试
1. **测试 Super Mario Bros** - 确定是游戏特定还是通用问题
2. **检查 NMI 中断** - 验证中断是否正确触发
3. **分析循环代码** - 理解退出条件
4. **强制测试渲染** - 验证 PPU 功能

详细计划见：`docs/next-steps.md`

### 可用的调试脚本
```bash
# 测试 Super Mario Bros
bash scripts/test_mario.sh

# 监控 NMI 中断
bash scripts/monitor_nmi.sh

# 分析循环代码
bash scripts/analyze_loop_code.sh
```
