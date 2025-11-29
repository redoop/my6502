# 下次会话任务清单

**创建日期**: 2025-11-29 17:32  
**预计时间**: 30-60 分钟  
**目标**: 让游戏可以进入和玩

---

## 🎯 主要目标

**解决 NMI 不触发问题** - 让游戏跳出等待循环

---

## 📋 任务清单

### 任务 1: 验证 PPU 是否运行 🔴 最高优先级

**问题**: 不确定 PPU 的 scanline/pixel 是否在计数

**方法**:
```cpp
// 在 testbench_main.cpp 中添加
printf("PPU: scanline=%d pixel=%d vblank=%d\n", 
       dut->ppu_scanline, 
       dut->ppu_pixel,
       dut->ppu_vblankFlag);
```

**预期结果**:
- scanline 应该从 0 计数到 261
- pixel 应该从 0 计数到 340
- vblankFlag 应该在 scanline=241 时变为 1

**如果不工作**: PPU clock 可能没连接

---

### 任务 2: 检查 CPU NMI 实现 🟠

**问题**: CPU 可能没有正确处理 NMI

**检查项**:
1. CPU6502Refactored 是否实现了 NMI 处理？
2. NMI 向量 ($FFFA-$FFFB) 是否正确读取？
3. NMI 触发时 PC 是否跳转？

**文件**: `src/main/scala/cpu6502/CPU6502Refactored.scala`

**搜索**: `nmi`, `0xFFFA`, `interrupt`

---

### 任务 3: 添加 NMI 测试 🟡

**方法**: 创建简单的 NMI 测试

```scala
// 测试代码
class NMITest extends AnyFlatSpec with ChiselScalatestTester {
  "CPU" should "respond to NMI" in {
    test(new CPU6502Refactored) { dut =>
      // 设置 NMI 向量
      // 触发 NMI
      // 验证 PC 跳转
    }
  }
}
```

---

### 任务 4: 使用 VCD 波形分析 🟡 (如果前面都不行)

**步骤**:
1. 编译带 trace 的版本
   ```bash
   ./scripts/build.sh trace
   ```

2. 运行并生成 VCD
   ```bash
   ./scripts/run.sh games/Super-Mario-Bros.nes
   ```

3. 用 GTKWave 查看
   ```bash
   gtkwave dump.vcd
   ```

**查看信号**:
- `ppu.scanline`
- `ppu.pixel`
- `ppu.vblankFlag`
- `ppu.io_nmiOut`
- `cpu.io_nmi`
- `cpu.io_memAddr` (PC)

---

## 🔧 快速修复尝试

### 尝试 1: 简化 VBlank 条件

**当前代码**:
```scala
when(scanline === 241.U && pixel === 1.U) {
  vblankFlag := true.B
}
```

**问题**: 条件太严格，可能错过

**修改为**:
```scala
when(scanline === 241.U) {
  vblankFlag := true.B
}
```

---

### 尝试 2: 检查 PPU 是否被 reset

**添加**:
```scala
// PPURefactored.scala
when(reset.asBool) {
  printf("PPU Reset!\n")
}
```

---

### 尝试 3: 强制设置 VBlank

**临时测试**:
```scala
// 强制 VBlank 始终为 true
val vblankFlag = RegInit(true.B)
```

如果这样游戏能继续，说明问题确实在 VBlank 触发。

---

## 📚 参考资料

### NES PPU 时序
- 每帧 262 scanlines (0-261)
- 每 scanline 341 pixels (0-340)
- VBlank 在 scanline 241 开始
- VBlank 在 scanline 261 结束

### NES NMI
- NMI 向量: $FFFA-$FFFB
- 触发条件: PPUCTRL.7 = 1 && VBlank = 1
- NMI 处理: 保存状态，跳转到 NMI 向量

### 6502 NMI 处理
1. Push PC high byte
2. Push PC low byte
3. Push Status register
4. Set I flag
5. Load PC from $FFFA-$FFFB
6. Jump to NMI handler

---

## 🎯 成功标准

### 最小成功
- [ ] 看到 VBlank 触发
- [ ] 看到 NMI 信号
- [ ] PC 从 0x952b 跳出

### 完全成功
- [ ] 游戏进入主循环
- [ ] 游戏响应输入
- [ ] 可以进入游戏

---

## 🚨 如果都不行

### Plan B: 测试更简单的游戏

尝试 Mapper 0 的简单游戏：
- Donkey Kong (已测试，也卡住)
- 其他 NROM 游戏

### Plan C: 简化测试

创建最小测试 ROM：
1. 设置 NMI 向量
2. 启用 NMI
3. 进入等待循环
4. NMI 处理改变屏幕颜色

---

## 📝 调试检查清单

开始前检查：
- [ ] 代码已提交
- [ ] 环境干净
- [ ] 文档已更新

调试时记录：
- [ ] 每个尝试的结果
- [ ] 观察到的现象
- [ ] 修改的代码

完成后：
- [ ] 更新文档
- [ ] 提交代码
- [ ] 创建 issue/PR

---

## ⏱️ 时间分配

- **任务 1**: 10 分钟 (验证 PPU)
- **任务 2**: 15 分钟 (检查 CPU NMI)
- **任务 3**: 10 分钟 (NMI 测试)
- **任务 4**: 15 分钟 (VCD 分析)
- **总计**: 50 分钟

---

## 💡 提示

1. **先验证，后修复** - 确认问题再改代码
2. **一次改一个** - 避免多个变量
3. **记录结果** - 每次尝试都记录
4. **保持简单** - 从最简单的开始

---

**创建时间**: 2025-11-29 17:32  
**下次会话**: 验证 PPU 运行状态  
**预计完成**: 让游戏跳出等待循环
