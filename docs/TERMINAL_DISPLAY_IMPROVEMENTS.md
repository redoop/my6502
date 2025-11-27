# 终端显示改进说明

## 改进概述

针对终端 NES 模拟器的显示效果进行了重大改进，显著提升了画面质量和细节表现。

## 主要改进

### 1. 使用半字符提高分辨率 ✨

**改进前：**
- 使用单一的 `█` 字符
- 每个字符只能显示一个像素
- 有效分辨率：128x240 字符

**改进后：**
- 使用半字符 `▄` (下半部分) 和 `▀` (上半部分)
- 每个字符可以显示上下两个不同颜色的像素
- 有效分辨率：256x120 字符 (显示 256x240 像素)
- **垂直分辨率提高 2倍！**

### 2. 精确的颜色映射 🎨

**改进前：**
```scala
// 简单的颜色索引映射
val NES_TO_ANSI = Array(
  16, 17, 18, 19, 20, 21, 22, 23, ...
)
```

**改进后：**
```scala
// 基于实际 NES 调色板 RGB 值
val NES_PALETTE_RGB = Array(
  (84, 84, 84),   // 灰色
  (0, 30, 116),   // 深蓝
  (8, 16, 144),   // 蓝色
  ...
)

// 智能 RGB 到 ANSI-256 转换
def rgbToAnsi256(r: Int, g: Int, b: Int): Int = {
  // 灰度检测
  if (Math.abs(r - g) < 10 && ...) {
    // 使用 232-255 灰度色
  }
  // 6x6x6 颜色立方体映射
  val r6 = ...
  16 + 36 * r6 + 6 * g6 + b6
}
```

### 3. 智能颜色处理

- **灰度优化**：自动检测灰度颜色，使用 ANSI 232-255 灰度范围
- **颜色立方体**：使用 ANSI 256 色的 6x6x6 颜色立方体进行精确映射
- **半字符优化**：当上下像素颜色相同时使用全字符，不同时使用半字符

### 4. 显示效果对比

| 特性 | 改进前 | 改进后 |
|------|--------|--------|
| 水平分辨率 | 128 字符 | 256 字符 |
| 垂直分辨率 | 240 字符 | 120 字符 (240 像素) |
| 总像素数 | 30,720 | 61,440 |
| 颜色精度 | 低 (简单映射) | 高 (RGB 精确映射) |
| 细节表现 | 模糊 | 清晰 |

## 技术细节

### 半字符渲染算法

```scala
for (y <- 0 until displayHeight) {
  for (x <- 0 until displayWidth) {
    // 采样上下两个像素
    val upperColorIndex = framebuffer(x)(y * 2)
    val lowerColorIndex = framebuffer(x)(y * 2 + 1)
    
    val upperAnsi = NES_TO_ANSI_IMPROVED(upperColorIndex)
    val lowerAnsi = NES_TO_ANSI_IMPROVED(lowerColorIndex)
    
    if (upperAnsi == lowerAnsi) {
      // 颜色相同，使用全字符
      print(s"\u001b[48;5;${upperAnsi}m█")
    } else {
      // 颜色不同，使用半字符
      // 前景色=下半部分，背景色=上半部分
      print(s"\u001b[38;5;${lowerAnsi}m\u001b[48;5;${upperAnsi}m▄")
    }
  }
}
```

### RGB 到 ANSI-256 转换

ANSI 256 色包含：
- **0-15**: 标准 16 色
- **16-231**: 6x6x6 RGB 颜色立方体 (216 色)
- **232-255**: 24 级灰度

转换算法：
1. 检测是否为灰度 (R≈G≈B)
2. 灰度使用 232-255 范围
3. 彩色使用 6x6x6 立方体映射

## 使用方法

### 运行改进的模拟器

```bash
# 演示模式 (测试图案)
./run_terminal.sh games/contra.nes demo

# 或直接运行
sbt "runMain nes.SimpleTerminalEmulator games/contra.nes"
```

### 终端要求

为获得最佳效果，请确保：
- ✅ 终端支持 256 色 (TERM=xterm-256color)
- ✅ 终端支持 Unicode (UTF-8)
- ✅ 字体支持半字符 (▄▀)
- ✅ 终端窗口足够大 (至少 256x120)

### 检查终端支持

```bash
# 检查颜色支持
tput colors  # 应该显示 256

# 检查 Unicode 支持
echo "▄▀█"  # 应该正确显示

# 设置终端类型
export TERM=xterm-256color
```

## 性能优化

- 使用 `StringBuilder` 批量构建输出
- 预计算颜色映射表
- 智能字符选择 (相同颜色用全字符)
- 帧率限制 (~30 FPS)

## 未来改进方向

1. **抖动算法**：使用 Floyd-Steinberg 抖动改善颜色过渡
2. **自适应缩放**：根据终端大小自动调整分辨率
3. **真彩色支持**：对于支持 24-bit 真彩色的终端使用 RGB 直接输出
4. **ASCII 艺术模式**：使用不同密度的字符表现亮度

## 示例效果

改进后的显示效果：
- 更清晰的文字和图形
- 更准确的颜色还原
- 更流畅的动画效果
- 更好的细节表现

## 相关文件

- `src/main/scala/nes/TerminalEmulator.scala` - 主要实现
- `run_terminal.sh` - 启动脚本
- `test_display.sh` - 测试脚本

## 参考资料

- [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
- [NES Color Palette](https://www.nesdev.org/wiki/PPU_palettes)
- [Unicode Block Elements](https://en.wikipedia.org/wiki/Block_Elements)
