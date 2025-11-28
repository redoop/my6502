# PPU 功能增强 - 2025-11-28

## 🎯 目标

完善 PPU 功能，实现精灵渲染、滚动支持和其他高级特性。

## ✅ 已实现的功能

### 1. 滚动支持
- 实现了 PPUSCROLL 寄存器的读写
- 背景渲染支持 X 和 Y 方向的滚动
- 支持 nametable 选择（通过 PPUCTRL 的 bit 0-1）

### 2. OAM DMA 支持
- 在 MemoryController 中实现了 OAM DMA 状态机
- 支持通过写入 0x4014 寄存器快速传输 256 字节精灵数据
- DMA 期间 CPU 暂停（通过 oamDmaActive 信号）

### 3. PPU 状态标志
- **VBlank 标志** (bit 7) - 已实现并修复
- **Sprite 0 Hit** (bit 6) - 已添加基础支持
- **Sprite Overflow** (bit 5) - 已添加寄存器（待完善）

### 4. 精灵渲染架构
- 设计了完整的精灵渲染逻辑
- 支持 8x8 和 8x16 精灵模式
- 支持水平和垂直翻转
- 支持精灵优先级（前景/背景）
- 支持 4 个精灵调色板

## 🚧 当前状态

### 简化版本 (PPUSimplified.scala)
为了避免 Chisel 编译错误，创建了一个简化版本：
- ✅ 基础背景渲染
- ✅ 滚动支持
- ✅ OAM DMA 接口
- ✅ VBlank 和状态标志
- ❌ 精灵渲染（暂时移除）

### 完整版本 (PPU.scala)
包含所有功能但有编译问题：
- ✅ 完整的背景渲染
- ✅ 完整的精灵渲染
- ✅ Sprite 0 碰撞检测
- ❌ Chisel 作用域问题（需要重构）

## 🐛 遇到的问题

### 1. Chisel 作用域问题
**问题描述：**
```scala
def renderBackground(x: UInt, y: UInt): (UInt, Bool) = {
  when(...) {
    val color = ...
    (color, transparent)  // ❌ 错误：变量逃逸了 when 作用域
  }
}
```

**原因：**
- Chisel 的 `when` 语句创建了一个新的作用域
- 在 `when` 内部创建的信号不能作为函数返回值
- 这是 Chisel 的硬件语义限制

**解决方案：**
- 不使用函数，直接在模块中内联渲染逻辑
- 使用 `Wire` 在外部作用域创建信号
- 在 `when` 内部只进行赋值操作

### 2. 精灵渲染的复杂性
**挑战：**
- 需要扫描 64 个精灵
- 每个精灵需要多次内存读取
- 需要处理优先级和透明度
- 需要与背景合成

**当前方案：**
- 简化版本暂时移除精灵渲染
- 专注于背景渲染和基础功能
- 后续逐步添加精灵支持

## 📋 代码结构

### 新增文件
1. **src/main/scala/nes/PPUSimplified.scala**
   - 简化的 PPU 实现
   - 只包含背景渲染
   - 避免复杂的作用域问题

2. **src/main/scala/nes/PPU.scala** (已更新)
   - 完整的 PPU 实现
   - 包含精灵渲染逻辑
   - 有编译问题，需要重构

### 修改的文件
1. **src/main/scala/nes/MemoryController.scala**
   - 添加 OAM DMA 支持
   - 添加 DMA 状态机
   - 添加 0x4014 寄存器处理

2. **src/main/scala/nes/NESSystem.scala**
   - 连接 OAM DMA 信号
   - 切换到 PPUSimplified

## 🎨 PPU 功能详解

### 背景渲染流程
```
1. 应用滚动偏移 (scrollX, scrollY)
   ↓
2. 计算 tile 坐标 (tileX, tileY)
   ↓
3. 选择 nametable (PPUCTRL bit 0-1)
   ↓
4. 读取 tile 索引 from nametable
   ↓
5. 读取 attribute byte
   ↓
6. 选择 pattern table (PPUCTRL bit 4)
   ↓
7. 读取 pattern 数据 (2 字节)
   ↓
8. 提取像素颜色 (2 bits)
   ↓
9. 组合调色板索引 (4 bits)
   ↓
10. 读取最终颜色 from palette
```

### 精灵渲染流程（设计）
```
1. 扫描 64 个精灵 (OAM)
   ↓
2. 检查精灵是否在当前扫描线
   ↓
3. 检查精灵是否在当前像素
   ↓
4. 读取精灵 tile 数据
   ↓
5. 应用翻转 (水平/垂直)
   ↓
6. 提取像素颜色
   ↓
7. 读取精灵调色板
   ↓
8. 根据优先级与背景合成
```

### OAM DMA 流程
```
1. CPU 写入 0x4014 = 0xXX
   ↓
2. DMA 开始，CPU 暂停
   ↓
3. 从 0xXX00-0xXXFF 读取 256 字节
   ↓
4. 写入 OAM (0x00-0xFF)
   ↓
5. DMA 完成，CPU 恢复
```

## 🔧 下一步工作

### 短期（修复当前问题）
1. **修复简化版本的渲染**
   - 检查为什么没有非零像素
   - 验证 nametable 和 pattern 读取
   - 确保调色板正确工作

2. **重构精灵渲染**
   - 避免使用函数返回 Wire
   - 直接在模块中内联逻辑
   - 使用寄存器存储中间结果

### 中期（完善功能）
1. **实现精灵渲染**
   - 逐步添加精灵扫描
   - 实现精灵-背景合成
   - 测试精灵显示

2. **完善 Sprite 0 碰撞**
   - 精确的碰撞检测
   - 正确的时序

3. **优化性能**
   - 减少内存读取
   - 优化渲染管道
   - 提高 FPS

### 长期（高级功能）
1. **精确的 PPU 时序**
   - 实现正确的扫描线时序
   - 支持 mid-frame 寄存器更新
   - 实现 sprite evaluation

2. **更多 PPU 功能**
   - 背景裁剪（左侧 8 像素）
   - 精灵裁剪（左侧 8 像素）
   - 灰度模式
   - 颜色强调

## 💡 技术要点

### Chisel 硬件设计原则
1. **避免在 when 中创建返回值**
   ```scala
   // ❌ 错误
   def func(): UInt = {
     when(cond) {
       val x = Wire(UInt())
       x := 1.U
       x  // 错误：逃逸作用域
     }
   }
   
   // ✅ 正确
   val x = Wire(UInt())
   when(cond) {
     x := 1.U
   }
   ```

2. **使用 Wire 在外部作用域**
   ```scala
   val result = WireDefault(0.U)
   when(cond1) {
     result := 1.U
   }.elsewhen(cond2) {
     result := 2.U
   }
   ```

3. **避免复杂的嵌套函数**
   - 硬件设计不同于软件
   - 尽量内联逻辑
   - 使用模块化的 Module 而不是函数

### NES PPU 特性
1. **内存映射**
   - Pattern Table: 0x0000-0x1FFF (8KB CHR ROM)
   - Nametable: 0x2000-0x2FFF (2KB VRAM, 镜像)
   - Palette: 0x3F00-0x3F1F (32 bytes)

2. **调色板组织**
   - 0x00-0x0F: 背景调色板 (4 组，每组 4 色)
   - 0x10-0x1F: 精灵调色板 (4 组，每组 4 色)
   - 索引 0 是透明色（背景色）

3. **精灵属性**
   - Byte 0: Y 坐标 (减 1)
   - Byte 1: Tile 索引
   - Byte 2: 属性 (调色板、翻转、优先级)
   - Byte 3: X 坐标

## 📊 测试结果

### 当前状态
- ✅ CPU 正常运行
- ✅ VBlank 正常工作
- ✅ 渲染已启用 (PPUMASK = 0x06)
- ❌ 没有像素输出（需要调试）

### 之前的状态（使用原始 PPU）
- ✅ 23040 个非零像素 (37.5%)
- ✅ 背景渲染正常
- ❌ 没有精灵

## 🎯 总结

本次更新为 PPU 添加了重要的功能框架：
1. ✅ 滚动支持
2. ✅ OAM DMA
3. ✅ 状态标志
4. 🚧 精灵渲染（设计完成，实现中）

虽然遇到了 Chisel 作用域的技术挑战，但通过创建简化版本，我们保持了项目的可编译性。下一步需要修复简化版本的渲染问题，然后逐步添加精灵功能。

---
**日期**: 2025-11-28  
**状态**: 🚧 功能框架完成，需要调试和完善  
**下一步**: 修复渲染问题，实现精灵显示
