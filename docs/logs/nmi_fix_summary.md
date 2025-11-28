# NMI 问题修复总结

## 日期
2025年11月28日

## 问题诊断

### 1. 原始问题
运行 `scripts/test_nmi_game.sh` 时，游戏加载成功但未检测到 NMI 中断触发。

### 2. 根本原因

#### 问题 A: ROM 地址映射不匹配 ✅ 已修复
**位置:** `src/main/scala/nes/MemoryController.scala`

**问题描述:**
- ROM 加载逻辑使用 15 位地址 `(14, 0)`
- ROM 读取逻辑使用 14 位地址 `(13, 0)`
- 导致地址映射不一致，Reset 向量无法正确读取

**修复:**
```scala
// 修复前
val romAddr = (io.cpuAddr - 0x8000.U)(13, 0)  // 14 位，只支持 16KB

// 修复后
val romAddr = (io.cpuAddr - 0x8000.U)(14, 0)  // 15 位，支持 32KB
```

**验证:** 
- 创建了 `ROMLoadTest.scala` 测试
- 测试通过 ✅
- Reset 向量现在可以正确读取

#### 问题 B: PPUSTATUS 读取清除 NMI 信号 ⚠️ 待修复
**位置:** `src/main/scala/nes/PPUSimplified.scala`

**问题描述:**
```scala
when(vblankClearNext) {
  vblankFlag := false.B
  nmiOccurred := false.B  // ⚠️ 这会清除 NMI 信号！
  vblankClearNext := false.B
}
```

读取 PPUSTATUS (0x2002) 会清除 `vblankFlag` 和 `nmiOccurred`。
根据 NES 规范，读取 PPUSTATUS 应该只清除 VBlank 标志，不应该清除 NMI 信号。

**建议修复:**
```scala
when(vblankClearNext) {
  vblankFlag := false.B
  // 不要清除 nmiOccurred，让它在下一帧开始时自然清除
  vblankClearNext := false.B
}
```

#### 问题 C: PPU 时钟速度 ⚠️ 需要验证
**观察:**
- 诊断测试显示扫描线计数器工作正常
- 但到达 VBlank (扫描线 241) 需要很长时间
- 30000 个周期只到了扫描线 88

**分析:**
- NES PPU 应该每帧 341×262 = 89342 个 PPU 周期
- 如果 CPU 和 PPU 共享同一个时钟，这是正常的
- 但测试运行很慢，可能需要优化

## 修复状态

### ✅ 已完成
1. ROM 地址映射修复
2. ROM 加载测试验证通过
3. 诊断测试确认 PPUCTRL 可以正确设置

### ⚠️ 待完成
1. 修复 PPUSTATUS 读取清除 NMI 的问题
2. 验证 NMI 边沿检测逻辑
3. 运行完整的 NMI 测试

### 📝 建议的下一步

#### 步骤 1: 修复 PPUSTATUS 读取逻辑
```scala
// 在 PPUSimplified.scala 中
when(vblankClearNext) {
  vblankFlag := false.B
  // nmiOccurred := false.B  // 删除这行
  vblankClearNext := false.B
}
```

#### 步骤 2: 运行 NMI 测试
```bash
sbt "testOnly nes.NMITest"
```

#### 步骤 3: 运行游戏 NMI 测试
```bash
sbt "testOnly nes.GameNMITest"
```

#### 步骤 4: 运行实际游戏测试
```bash
bash scripts/test_nmi_game.sh
```

## 技术细节

### NMI 触发流程
1. PPU 扫描线到达 241，像素 1
2. PPU 设置 `vblankFlag := true.B`
3. 如果 `ppuCtrl(7) == 1`，设置 `nmiOccurred := true.B`
4. `io.nmiOut := nmiOccurred` 输出到 CPU
5. CPU 检测 NMI 上升沿（从 false 到 true）
6. CPU 设置 `nmiPending := true.B`
7. 在下一个指令边界，CPU 进入 NMI 状态
8. CPU 执行 NMI 中断序列

### NMI 清除时机
- `nmiOccurred` 应该在下一帧开始时清除（扫描线 261）
- 读取 PPUSTATUS 只清除 `vblankFlag`，不清除 `nmiOccurred`
- 这确保 CPU 有足够时间响应 NMI

## 测试文件
- `src/test/scala/nes/ROMLoadTest.scala` - ROM 加载测试 ✅
- `src/test/scala/nes/NMIDiagnosisTest.scala` - NMI 诊断测试 🔄
- `src/test/scala/nes/NMITest.scala` - NMI 功能测试 ⏳
- `src/test/scala/nes/GameNMITest.scala` - 游戏 NMI 测试 ⏳

## 参考资料
- NES Dev Wiki: https://www.nesdev.org/wiki/PPU_registers
- NES Dev Wiki: https://www.nesdev.org/wiki/NMI
