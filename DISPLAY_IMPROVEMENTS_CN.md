# 终端显示效果改进说明

## 📊 改进对比

### 改进前 vs 改进后

| 特性 | 改进前 | 改进后 | 提升 |
|------|--------|--------|------|
| **水平分辨率** | 128 字符 | 256 字符 | **2倍** ⬆️ |
| **垂直分辨率** | 240 字符 | 120 字符 (240 像素) | **2倍像素密度** ⬆️ |
| **总显示像素** | 30,720 | 61,440 | **2倍** ⬆️ |
| **颜色精度** | 简单索引映射 | RGB 精确映射 | **显著提升** ⬆️ |
| **字符使用** | 仅 `█` | `█` + `▄` + `▀` | **更灵活** ⬆️ |

## 🎨 核心改进技术

### 1. 半字符技术 (Half-Block Characters)

**原理：** 使用 Unicode 半字符 `▄` (U+2584) 和 `▀` (U+2580)，每个字符可以显示上下两个不同颜色的像素。

```
改进前:  █ █ █ █    (4个字符 = 4个像素)
改进后:  ▄ ▄ ▄ ▄    (4个字符 = 8个像素)
         ▀ ▀ ▀ ▀
```

**实现：**
```scala
// 上半部分用背景色，下半部分用前景色
print(s"\u001b[38;5;${lowerColor}m\u001b[48;5;${upperColor}m▄")
```

### 2. 精确的 RGB 到 ANSI-256 颜色映射

**ANSI 256 色结构：**
- **0-15**: 标准 16 色
- **16-231**: 6×6×6 RGB 颜色立方体 (216 色)
- **232-255**: 24 级灰度

**映射算法：**
```scala
def rgbToAnsi256(r: Int, g: Int, b: Int): Int = {
  // 1. 检测灰度
  if (Math.abs(r - g) < 10 && Math.abs(g - b) < 10) {
    val gray = (r + g + b) / 3
    return 232 + ((gray - 8) * 24 / 240)  // 使用灰度范围
  }
  
  // 2. 映射到 6x6x6 颜色立方体
  val r6 = if (r < 48) 0 else if (r < 115) 1 else ((r - 35) / 40).min(5)
  val g6 = if (g < 48) 0 else if (g < 115) 1 else ((g - 35) / 40).min(5)
  val b6 = if (b < 48) 0 else if (b < 115) 1 else ((b - 35) / 40).min(5)
  
  return 16 + 36 * r6 + 6 * g6 + b6
}
```

### 3. 真实的 NES 调色板

使用 NES 实际的 RGB 值，而不是简单的索引映射：

```scala
val NES_PALETTE_RGB = Array(
  (84, 84, 84),    // $00 - 深灰
  (0, 30, 116),    // $01 - 深蓝
  (8, 16, 144),    // $02 - 蓝色
  (48, 0, 136),    // $03 - 紫蓝
  (68, 0, 100),    // $04 - 紫色
  (92, 0, 48),     // $05 - 紫红
  (84, 4, 0),      // $06 - 深红
  (60, 24, 0),     // $07 - 棕色
  (32, 42, 0),     // $08 - 橄榄绿
  (8, 58, 0),      // $09 - 绿色
  (0, 64, 0),      // $0A - 深绿
  (0, 60, 0),      // $0B - 青绿
  (0, 50, 60),     // $0C - 青色
  (0, 0, 0),       // $0D - 黑色
  // ... 共 64 色
)
```

## 🚀 性能优化

1. **预计算颜色映射表**
   ```scala
   val NES_TO_ANSI_IMPROVED = NES_PALETTE_RGB.map { 
     case (r, g, b) => rgbToAnsi256(r, g, b)
   }
   ```

2. **批量字符串构建**
   ```scala
   val sb = new StringBuilder()
   // 构建整帧
   sb.append(...)
   // 一次性输出
   print(sb.toString())
   ```

3. **智能字符选择**
   ```scala
   if (upperColor == lowerColor) {
     // 相同颜色用全字符 (更快)
     sb.append(s"\u001b[48;5;${upperColor}m█")
   } else {
     // 不同颜色用半字符
     sb.append(s"\u001b[38;5;${lowerColor}m\u001b[48;5;${upperColor}m▄")
   }
   ```

## 📈 视觉效果提升

### 细节表现
- ✅ 文字更清晰
- ✅ 图形边缘更锐利
- ✅ 颜色过渡更平滑
- ✅ 整体画面更细腻

### 颜色还原
- ✅ 灰度更准确 (使用专用灰度范围)
- ✅ 彩色更鲜艳 (6x6x6 立方体)
- ✅ 色调更真实 (基于 NES 实际 RGB)

## 🔧 使用方法

### 运行改进的模拟器

```bash
# 方法 1: 使用启动脚本
./run_terminal.sh games/contra.nes demo

# 方法 2: 直接运行
sbt "runMain nes.SimpleTerminalEmulator games/contra.nes"
```

### 查看改进演示

```bash
# 显示改进效果对比
./show_improvements.sh
```

### 终端要求

为获得最佳效果：

```bash
# 1. 检查颜色支持
tput colors  # 应该显示 256

# 2. 设置终端类型
export TERM=xterm-256color

# 3. 测试 Unicode 支持
echo "测试字符: █ ▄ ▀"

# 4. 调整终端大小
# 建议至少 256 列 × 120 行
```

### 推荐终端

- ✅ **xterm** (with 256 color support)
- ✅ **gnome-terminal**
- ✅ **konsole**
- ✅ **iTerm2** (macOS)
- ✅ **Windows Terminal**
- ⚠️ **tmux/screen** (需要配置 256 色)

## 📝 技术细节

### ANSI 转义序列

```scala
// 清屏
"\u001b[2J"

// 光标归位
"\u001b[H"

// 隐藏/显示光标
"\u001b[?25l"  // 隐藏
"\u001b[?25h"  // 显示

// 设置颜色
"\u001b[38;5;${n}m"  // 前景色 (0-255)
"\u001b[48;5;${n}m"  // 背景色 (0-255)

// 重置
"\u001b[0m"
```

### 渲染流程

```
1. 清屏并隐藏光标
   ↓
2. 遍历每一行 (120 行)
   ↓
3. 对于每个字符位置 (256 列):
   - 读取上下两个像素
   - 转换为 ANSI 颜色
   - 选择合适的字符 (█/▄/▀)
   - 添加到输出缓冲
   ↓
4. 一次性输出整帧
   ↓
5. 限制帧率 (~30 FPS)
```

## 🎯 未来改进方向

### 短期改进
1. **抖动算法** - Floyd-Steinberg 抖动改善颜色过渡
2. **自适应缩放** - 根据终端大小自动调整
3. **性能优化** - 减少字符串操作

### 长期改进
1. **真彩色支持** - 24-bit RGB (需要终端支持)
   ```scala
   "\u001b[38;2;${r};${g};${b}m"  // RGB 前景色
   "\u001b[48;2;${r};${g};${b}m"  // RGB 背景色
   ```

2. **ASCII 艺术模式** - 使用字符密度表现亮度
   ```
   " .:-=+*#%@"  // 从暗到亮
   ```

3. **四分字符** - 使用 Unicode 四分块字符
   ```
   ▘▝▀▖▌▞▛▗▚▐▜▄▙▟█
   ```

## 📚 参考资料

- [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
- [NES Color Palette](https://www.nesdev.org/wiki/PPU_palettes)
- [Unicode Block Elements](https://en.wikipedia.org/wiki/Block_Elements)
- [256 Colors in Terminal](https://www.ditig.com/256-colors-cheat-sheet)

## 🎮 效果展示

运行以下命令查看实际效果：

```bash
# 1. 查看改进说明
./show_improvements.sh

# 2. 运行模拟器
./run_terminal.sh games/contra.nes demo

# 3. 查看文档
cat docs/TERMINAL_DISPLAY_IMPROVEMENTS.md
```

---

**总结：** 通过使用半字符技术和精确的颜色映射，终端显示效果得到了显著提升，分辨率提高 2 倍，颜色还原更准确，整体画面更清晰细腻！ 🎉
