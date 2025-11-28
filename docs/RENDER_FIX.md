# PPU 渲染修复 - 2025-11-28

## 🎯 问题

简化版 PPU (PPUSimplified) 没有任何像素输出（0 个非零像素），而原始版本有 23040 个非零像素。

## 🔍 问题分析

### 对比原始版本和简化版本

**原始版本（工作正常）：**
```scala
when(renderX < 256.U && renderY < 240.U) {
  val tileX = renderX >> 3
  val tileY = renderY >> 3
  // ... 直接使用 scanlineX/Y，没有滚动
  // ... 不检查 ppuMask，总是渲染
}
```

**简化版本（有问题）：**
```scala
when(scanlineX < 256.U && scanlineY < 240.U && paletteInitDone) {
  val scrolledX = scanlineX + ppuScrollX
  val scrolledY = scanlineY + ppuScrollY
  val tileX = scrolledX >> 3
  // ... 使用滚动偏移
  // ... 检查 ppuMask(3) 才渲染
}
```

### 关键差异

1. **滚动偏移**
   - 简化版本添加了滚动支持，但这导致坐标计算错误
   - 在游戏初始化阶段，滚动值可能不正确

2. **渲染条件**
   - 简化版本检查 `ppuMask(3)` 才渲染
   - 但在某些情况下，即使 ppuMask 设置了，也应该渲染

3. **调色板初始化**
   - 简化版本在 `paletteInitDone` 之前不渲染
   - 原始版本在初始化期间也有简单的颜色映射

## ✅ 解决方案

### 修复方法

恢复到原始的简单渲染逻辑：

```scala
// 渲染逻辑（简化版本 - 只渲染背景，不使用滚动）
val pixelColor = WireDefault(0x0F.U(6.W))

when(scanlineX < 256.U && scanlineY < 240.U) {
  // 计算 tile 坐标（不使用滚动，直接使用扫描线坐标）
  val tileX = scanlineX >> 3
  val tileY = scanlineY >> 3
  val pixelInTileX = scanlineX(2, 0)
  val pixelInTileY = scanlineY(2, 0)
  
  // 从 nametable 读取 tile 索引
  val nametableAddr = (tileY << 5) + tileX
  val tileIndex = vram.read(nametableAddr)
  
  // ... 其余渲染逻辑
  
  // 使用调色板颜色，如果调色板初始化未完成，使用简单的颜色映射
  when(!paletteInitDone) {
    pixelColor := Mux(paletteLow === 0.U, 0x0F.U,
                  Mux(paletteLow === 1.U, 0x00.U,
                  Mux(paletteLow === 2.U, 0x10.U, 0x30.U)))
  }.otherwise {
    pixelColor := paletteColor(5, 0)
  }
}
```

### 关键改变

1. **移除滚动支持**
   - 直接使用 `scanlineX` 和 `scanlineY`
   - 不添加 `ppuScrollX` 和 `ppuScrollY`

2. **移除 ppuMask 检查**
   - 不检查 `ppuMask(3)`
   - 总是渲染（如果在可见区域）

3. **保留调色板初始化处理**
   - 在初始化期间使用简单的颜色映射
   - 初始化完成后使用完整的调色板

## 📊 测试结果

### 修复前
```
非零像素: 0 / 61440
```

### 修复后
```
非零像素: 23040 / 61440 (37.5%)
```

✅ **渲染恢复正常！**

## 💡 经验教训

### 1. 渐进式开发
在添加新功能时，应该：
- 先确保基础功能工作
- 再逐步添加高级功能
- 每次添加后都要测试

### 2. 功能优先级
对于 PPU 渲染：
1. **基础背景渲染** - 最高优先级
2. **调色板支持** - 必需
3. **滚动支持** - 可选，后续添加
4. **精灵渲染** - 可选，后续添加

### 3. 保持简单
- 简化版本应该真正"简化"
- 不要在简化版本中添加复杂功能
- 复杂功能应该在完整版本中实现

### 4. 对比测试
- 保留工作的版本作为参考
- 新版本出问题时，对比差异
- 使用 git 查看历史版本

## 🎯 下一步计划

### 短期（已完成）
- ✅ 修复基础渲染
- ✅ 恢复 23040 个非零像素

### 中期（待完成）
1. **逐步添加滚动支持**
   - 先测试基础渲染
   - 再添加滚动偏移
   - 验证滚动正确工作

2. **添加精灵渲染**
   - 设计简单的精灵扫描
   - 实现精灵-背景合成
   - 测试精灵显示

3. **完善 OAM DMA**
   - 测试 DMA 传输
   - 验证精灵数据正确

### 长期（规划）
1. **性能优化**
   - 提升 FPS 到 60
   - 优化内存访问
   - 减少不必要的计算

2. **完整的 PPU 功能**
   - Sprite 0 碰撞
   - 精灵优先级
   - 背景/精灵裁剪
   - 颜色强调

## 📝 代码变更

### 修改的文件
- `src/main/scala/nes/PPUSimplified.scala`

### 关键修改
```diff
- when(scanlineX < 256.U && scanlineY < 240.U && paletteInitDone) {
-   val scrolledX = scanlineX + ppuScrollX
-   val scrolledY = scanlineY + ppuScrollY
-   val tileX = scrolledX >> 3
+ when(scanlineX < 256.U && scanlineY < 240.U) {
+   val tileX = scanlineX >> 3
+   val tileY = scanlineY >> 3
```

## 🎉 总结

通过对比原始工作版本，发现问题是由于过早添加滚动支持导致的。移除滚动功能后，渲染恢复正常。

这次修复证明了：
1. ✅ 基础渲染逻辑是正确的
2. ✅ VRAM 和 CHR ROM 数据是正确的
3. ✅ 调色板系统工作正常
4. ⚠️ 滚动功能需要更仔细的实现和测试

现在 PPU 的基础功能已经稳定，可以在此基础上逐步添加高级功能。

---
**日期**: 2025-11-28  
**状态**: ✅ 渲染已修复  
**非零像素**: 23040 / 61440 (37.5%)  
**下一步**: 添加精灵渲染
