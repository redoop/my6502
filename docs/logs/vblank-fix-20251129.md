# VBlank 修复总结 - 2025-11-29 19:30

## 问题描述

Donkey Kong 卡在死循环，一直等待 VBlank：
```
PC: 0xC79F - 0xC7AD (循环)
等待: PPUSTATUS bit 7 (VBlank)
实际: PPUSTATUS = 0x40 (VBlank = 0)
```

## 单元测试驱动修复

### 1. 创建 VBlank 单元测试 ✅

**测试文件**: `src/test/scala/nes/ppu/PPUVBlankTest.scala`

**测试用例**:
1. ✅ VBlank 在 scanline 241 设置
2. ✅ PPUSTATUS bit 7 在 VBlank 期间为 1
3. ✅ NMI 在 VBlank 开始时触发（如果启用）

### 2. 发现问题 🔍

**调试测试**: `PPUVBlankDebugTest.scala`

**发现**:
```
Scanline 241 pixel 0: vblank=0
Scanline 241 pixel 1: vblank=0  ❌ 应该是 1
Scanline 241 pixel 2: vblank=1  ✅ 延迟了一个周期
```

**根本原因**: 寄存器延迟
```scala
val vblankFlag = RegInit(false.B)  // 寄存器

when(scanline === 241.U && pixel === 1.U) {
  vblankFlag := true.B  // 赋值在下一个周期生效
}
```

### 3. 修复方案 ✅

**修改**: `src/main/scala/nes/PPURefactored.scala`

**Before**:
```scala
when(scanline === 241.U && pixel === 1.U) {
  vblankFlag := true.B  // pixel 2 才生效
}
```

**After**:
```scala
when(scanline === 241.U && pixel === 0.U) {
  vblankFlag := true.B  // pixel 1 生效
}
```

**原理**: 提前一个周期设置，补偿寄存器延迟

### 4. 验证结果 ✅

```
Scanline 241 pixel 0: vblank=0
Scanline 241 pixel 1: vblank=1  ✅ 正确
Scanline 241 pixel 2: vblank=1  ✅ 保持
```

**测试结果**:
```
✓ should generate VBlank at scanline 241
✓ should set PPUSTATUS bit 7 during VBlank
✓ should generate NMI when VBlank starts and NMI is enabled
```

## 单元测试的价值

### 1. 快速定位问题
- 不需要运行完整游戏
- 直接测试 PPU VBlank 功能
- 10 秒内发现问题

### 2. 精确验证
- 逐周期检查 VBlank 标志
- 验证 PPUSTATUS 寄存器
- 验证 NMI 触发时序

### 3. 防止回归
- 测试永久保留
- 任何修改都会被验证
- 确保功能不被破坏

## 下一步

### 立即验证
```bash
# 重新编译 Verilator
./scripts/build.sh fast

# 运行 Donkey Kong
./scripts/run.sh games/Donkey-Kong.nes
```

### 预期结果
- ✅ CPU 不再卡在 VBlank 等待循环
- ✅ 游戏初始化继续进行
- ✅ 可能看到画面或进一步的初始化

## 技术细节

### NES PPU 时序
```
Scanline 0-239:   可见区域 (240 lines)
Scanline 240:     Post-render (1 line)
Scanline 241:     VBlank 开始 ⭐
Scanline 242-260: VBlank 期间
Scanline 261:     Pre-render
```

### VBlank 标志
- **设置**: Scanline 241, Pixel 1
- **清除**: 读取 PPUSTATUS 或 Scanline 261
- **用途**: CPU 等待 VBlank 来更新图形

### NMI 中断
- **触发**: VBlank 开始 + PPUCTRL bit 7 = 1
- **用途**: 通知 CPU 进入 VBlank，可以安全更新 PPU
- **时序**: 单周期脉冲

## 测试代码示例

```scala
test(new PPURefactored) { dut =>
  // 运行到 scanline 241
  dut.clock.step(241 * 341 + 1)
  
  // 验证 VBlank
  dut.io.vblank.expect(true.B)
  
  // 验证 PPUSTATUS
  dut.io.cpuAddr.poke(2.U)
  dut.io.cpuRead.poke(true.B)
  dut.clock.step(1)
  
  val status = dut.io.cpuDataOut.peek().litValue
  assert((status & 0x80) != 0)  // Bit 7 = VBlank
}
```

## 总结

✅ **问题**: VBlank 延迟一个周期
✅ **方法**: 单元测试驱动
✅ **修复**: 提前一个周期设置
✅ **验证**: 所有测试通过

**时间**: 30 分钟
- 编写测试: 10 分钟
- 调试发现: 10 分钟
- 修复验证: 10 分钟

**单元测试 > 集成测试** 用于精确时序问题！
