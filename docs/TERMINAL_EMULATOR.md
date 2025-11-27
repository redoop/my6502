# 🖥️ 终端 NES 模拟器

**版本**: v0.4.0
**日期**: 2025-11-27

---

## 📋 概述

终端 NES 模拟器是一个可以在命令行/终端中运行的 NES 模拟器，无需 GUI 环境。

### 特性

- ✅ **纯文本显示**: 使用 ASCII 字符显示画面
- ✅ **ANSI 彩色**: 支持 256 色终端
- ✅ **ROM 分析**: 详细的 ROM 信息
- ✅ **CHR 可视化**: 显示 CHR ROM 图案
- ✅ **无头环境**: 适合服务器和 SSH

---

## 🚀 快速开始

### 方法 1: 文本显示 (推荐)

```bash
# 显示 ROM 信息和测试图案
sbt 'runMain nes.TextDisplay "games/Super-Contra-X-(China)-(Pirate).nes"'
```

**输出示例**:
```
🎮 NES 文本显示模拟器
================================================================================

📁 ROM: games/Super-Contra-X-(China)-(Pirate).nes
📊 Mapper: 4
📦 PRG: 256KB, CHR: 256KB

🎨 测试画面 (64x32):
--------------------------------------------------------------------------------
  ..''``^^"",,::;;IIllii>><<~~++__--??]][[}}11))((||\\//ttffjjrr
..''``^^"",,::;;IIllii>><<~~++__--??]][[}}11))((||\\//ttffjjrrnn
...
--------------------------------------------------------------------------------

🎨 CHR ROM 图案预览:
--------------------------------------------------------------------------------
            ░██░░░            ░░░░░██▒  
    ░░░░    ░██░░░  ░░░░░░░░  ███████▒  
...
--------------------------------------------------------------------------------
```

### 方法 2: ROM 分析

```bash
# 详细分析 ROM 文件
sbt 'runMain nes.ROMAnalyzer "games/Super-Contra-X-(China)-(Pirate).nes"'
```

### 方法 3: 动画显示

```bash
# 显示动画测试图案
sbt "runMain nes.AnimatedTextDisplay"
```

---

## 📊 功能对比

| 功能 | TextDisplay | ROMAnalyzer | TerminalEmulator |
|------|------------|-------------|------------------|
| ROM 加载 | ✅ | ✅ | ✅ |
| ROM 分析 | ✅ | ✅ | ✅ |
| 文本显示 | ✅ | ❌ | ✅ |
| CHR 可视化 | ✅ | ✅ | ❌ |
| ANSI 彩色 | ❌ | ❌ | ✅ |
| 键盘输入 | ❌ | ❌ | ✅ |
| 实时模拟 | ❌ | ❌ | 🚧 |

---

## 🎨 显示模式

### ASCII 字符集

使用 70 个字符表示不同的亮度：
```
 .'`^",:;Il!i><~+_-?][}{1)(|\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$
```

- 空格 ` ` = 最暗
- `@` 或 `$` = 最亮

### Unicode 方块字符

用于 CHR ROM 显示：
- ` ` = 透明 (颜色 0)
- `░` = 浅色 (颜色 1)
- `▒` = 中色 (颜色 2)
- `█` = 深色 (颜色 3)

### ANSI 256 色

支持的终端：
- xterm-256color
- screen-256color
- tmux-256color

检查终端支持：
```bash
echo $TERM
tput colors
```

---

## 🔧 使用示例

### 示例 1: 查看 ROM 信息

```bash
sbt 'runMain nes.ROMAnalyzer "games/contra.nes"'
```

输出：
- ROM 头信息
- Mapper 类型
- PRG/CHR 大小
- 中断向量
- 兼容性检查
- 推荐游戏

### 示例 2: 可视化 CHR ROM

```bash
sbt 'runMain nes.TextDisplay "games/smb.nes"'
```

显示：
- 测试图案
- CHR ROM 前 8 个 tile
- 使用 Unicode 方块字符

### 示例 3: 批量分析

```bash
# 分析所有 ROM
for rom in games/*.nes; do
    echo "分析: $rom"
    sbt "runMain nes.ROMAnalyzer \"$rom\"" 2>&1 | grep -A 20 "ROM 信息"
    echo ""
done
```

---

## 📝 输出格式

### TextDisplay 输出

```
🎮 NES 文本显示模拟器
================================================================================

📁 ROM: <文件路径>
📊 Mapper: <mapper 编号>
📦 PRG: <大小>KB, CHR: <大小>KB

🎨 测试画面 (64x32):
[ASCII 艺术图案]

🎨 CHR ROM 图案预览:
[Unicode 方块图案]

🎮 模拟器功能:
[功能列表]

💡 提示:
[使用建议]
```

### ROMAnalyzer 输出

```
============================================================
🎮 NES ROM 分析器
============================================================

📁 文件: <路径>
📊 大小: <字节数>

✅ 有效的 NES ROM 文件

📋 ROM 信息:
------------------------------------------------------------
  Mapper:        <编号> (<名称>)
  PRG ROM:       <大小> bytes
  CHR ROM:       <大小> bytes
  ...

🎯 兼容性:
------------------------------------------------------------
  状态: <状态>
  说明: <说明>

🔧 中断向量:
------------------------------------------------------------
  NMI Vector:    0x<地址>
  Reset Vector:  0x<地址>
  IRQ Vector:    0x<地址>

📝 PRG ROM 预览:
[十六进制转储]

🎨 CHR ROM 预览:
[十六进制转储]

🎮 推荐游戏:
[游戏列表]
```

---

## 🎯 支持的 ROM

### 完全支持

| ROM | Mapper | 显示 | 分析 |
|-----|--------|------|------|
| 魂斗罗 | MMC3 (4) | ✅ | ✅ |
| Super Mario Bros | NROM (0) | ✅ | ✅ |
| Mega Man | MMC1 (1) | ✅ | ✅ |

### 所有 iNES 格式

只要是有效的 iNES 格式 ROM，都可以：
- ✅ 加载和解析
- ✅ 显示信息
- ✅ 可视化 CHR

---

## 🐛 故障排除

### 问题 1: 字符显示乱码

**原因**: 终端不支持 Unicode
**解决**: 使用支持 UTF-8 的终端

```bash
# 检查编码
echo $LANG

# 设置 UTF-8
export LANG=en_US.UTF-8
```

### 问题 2: 颜色不显示

**原因**: 终端不支持 256 色
**解决**: 使用支持 256 色的终端

```bash
# 检查颜色支持
tput colors

# 设置终端类型
export TERM=xterm-256color
```

### 问题 3: 文件路径错误

**原因**: 特殊字符需要转义
**解决**: 使用引号

```bash
# 错误
sbt runMain nes.TextDisplay games/Super-Contra-X-(China)-(Pirate).nes

# 正确
sbt 'runMain nes.TextDisplay "games/Super-Contra-X-(China)-(Pirate).nes"'
```

---

## 🔮 未来功能

### 短期
- ⏳ 实时 ANSI 彩色显示
- ⏳ 键盘输入支持
- ⏳ 帧缓冲优化

### 中期
- ⏳ 完整的终端模拟
- ⏳ 音频文本可视化
- ⏳ 保存截图

### 长期
- ⏳ 网络串流
- ⏳ 录像回放
- ⏳ TUI 界面

---

## 📚 相关文档

- [EMULATOR_GUIDE.md](EMULATOR_GUIDE.md) - 完整模拟器指南
- [HOW_TO_PLAY.md](HOW_TO_PLAY.md) - 游戏运行指南
- [ROM_ANALYSIS_RESULT.md](ROM_ANALYSIS_RESULT.md) - ROM 分析结果

---

## 💡 技术细节

### ASCII 艺术算法

```scala
// 亮度映射
val brightness = (r * 299 + g * 587 + b * 114) / 1000
val charIndex = brightness * ASCII_CHARS.length / 256
val char = ASCII_CHARS.charAt(charIndex)
```

### CHR Tile 解码

```scala
// 读取 2 个 bitplane
val plane0 = chrData(offset + row)
val plane1 = chrData(offset + row + 8)

// 组合像素
for (col <- 0 until 8) {
  val bit = 7 - col
  val pixel = ((plane1 >> bit) & 1) << 1 | ((plane0 >> bit) & 1)
  // pixel: 0-3
}
```

### ANSI 颜色转换

```scala
// NES 调色板 (64 色) -> ANSI 256 色
val nesColor = palette(index)
val ansiColor = NES_TO_ANSI(nesColor)
print(s"\u001b[48;5;${ansiColor}m█")
```

---

## 🎉 总结

终端 NES 模拟器提供了一种在无 GUI 环境中查看和分析 NES ROM 的方法。

**优点**:
- ✅ 无需 X11/GUI
- ✅ 适合 SSH 远程
- ✅ 轻量级
- ✅ 快速启动

**限制**:
- ⚠️ 显示质量有限
- ⚠️ 无法实时模拟
- ⚠️ 需要 Verilator 才能完整运行

**推荐用途**:
- ROM 分析和调试
- CHR 数据可视化
- 快速查看 ROM 信息
- 教学和演示

---

**版本**: v0.4.0
**状态**: ✅ 可用
**性能**: 即时显示

祝您使用愉快！🎮
