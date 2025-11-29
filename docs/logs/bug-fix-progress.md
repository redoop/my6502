# PPU 渲染 Bug 修复进度

**日期**: 2025-11-29  
**问题**: 灰色画面 → 绿色画面 → 有图形了！

## 修复历程

### 1️⃣ 灰色画面 (16:04)
**问题**: `io_pixelColor` 被硬编码为 0  
**原因**: PPU 模块没有输出 `pixelColor` 信号  
**修复**: 
- 添加 `dontTouch(finalColor)` 防止优化
- 将 `WireDefault` 改为 `Wire` + 显式赋值

### 2️⃣ 绿色画面 (16:10)
**问题**: 只显示背景色（绿色 0x09）  
**原因**: 
- `paletteRam` 初始化为全 0
- 没有调色板写入逻辑
**修复**:
- 初始化默认 NES 调色板
- 添加 PPUDATA ($2007) 写入逻辑

### 3️⃣ 还是绿色 (16:12)
**问题**: 渲染逻辑不工作  
**原因**: 没有 nametable 写入逻辑  
**修复**: 添加 nametable 写入到 PPUDATA

### 4️⃣ 棋盘测试成功 (16:16)
**验证**: 渲染管道工作正常  
**方法**: 显示测试图案 `((pixel(3) ^ scanline(3)) === 0.U)`

### 5️⃣ 有图形了！(16:19) ✅
**问题**: `SyncReadMem` 读取延迟  
**修复**: 
- 使用 `RegNext` 缓存读取数据
- 建立正确的渲染管道
- 强制显示非零像素验证

**当前状态**: 
- ✅ 能看到图形
- ✅ 有绿色底色
- ⏳ 调色板需要优化

## 关键代码修改

### PPURefactored.scala

```scala
// 1. 调色板初始化
val paletteRam = RegInit(VecInit(Seq(
  0x09.U, 0x01.U, 0x00.U, 0x01.U, ...
)))

// 2. Nametable 和调色板写入
when(io.cpuWrite && io.cpuAddr === 7.U) {
  when(ppuAddr >= 0x3F00.U) {
    paletteRam(paletteAddr) := io.cpuDataIn
  }.elsewhen(ppuAddr >= 0x2000.U) {
    nametableRam.write(ntAddr, io.cpuDataIn)
  }
}

// 3. 渲染管道
val patternLowReg = RegNext(patternLow)
val patternHighReg = RegNext(patternHigh)
val pixelBitReg = ((patternHighReg >> bitPosReg)(0) << 1) | 
                  ((patternLowReg >> bitPosReg)(0))

// 4. 最终颜色
when(isRendering) {
  finalColor := paletteRam(0)
  when(pixelBitReg =/= 0.U) {
    finalColor := bgColorReg
  }
}
```

## 下一步

1. ✅ 验证图形显示正确
2. ⏳ 优化调色板映射
3. ⏳ 添加精灵渲染
4. ⏳ 测试游戏可玩性

## 性能

- **FPS**: 35-37 (目标 ≥ 3) ✅
- **CPU**: 正常执行
- **渲染**: 基本工作

---

**最后更新**: 2025-11-29 16:20
