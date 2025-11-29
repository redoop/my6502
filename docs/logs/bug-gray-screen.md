# Bug: 灰色画面 - PPU pixelColor 未输出

**发现日期**: 2025-11-29  
**严重程度**: 🔴 Critical  
**影响**: 所有游戏无法正常显示

## 问题描述

运行任何游戏时，画面显示为灰色，没有标题画面或游戏内容。

## 根本原因

PPU 模块（`PPURefactored.scala`）没有输出 `pixelColor` 信号。

### 代码分析

**Scala 源码** (`src/main/scala/nes/PPURefactored.scala`):
```scala
val pixelColor = Output(UInt(6.W))  // Line 30
io.pixelColor := finalColor(5, 0)   // Line 199
```

**生成的 Verilog** (`generated/nes/NESSystemRefactored.v`):
```verilog
module PPURefactored(
  ...
  output [8:0]  io_pixelX,
  output [8:0]  io_pixelY,
  output        io_vblank,
  // ❌ 缺少 io_pixelColor 输出！
);
```

**NES 系统连接** (Line 3062):
```verilog
assign io_pixelColor = 6'h0;  // ❌ 硬编码为 0（黑色）
```

## 影响范围

- ✅ CPU 正常工作
- ✅ ROM 加载正常
- ✅ 系统初始化正常
- ❌ PPU 渲染输出为黑色
- ❌ 所有游戏无法显示

## 解决方案

需要修复 `PPURefactored.scala` 以正确输出 `pixelColor`：

1. 检查 PPU IO bundle 定义
2. 确保 `pixelColor` 在模块输出中
3. 重新生成 Verilog
4. 重新编译 Verilator

## 临时解决方案

使用旧版 PPU 实现（如果有）或修复当前 PPU。

## 相关文件

- `src/main/scala/nes/PPURefactored.scala`
- `src/main/scala/nes/NESSystemRefactored.scala`
- `generated/nes/NESSystemRefactored.v`
- `verilator/testbench_main.cpp`

## 测试验证

修复后需要验证：
1. Verilog 中 PPU 有 `io_pixelColor` 输出
2. NES 系统正确连接 `ppu.io.pixelColor`
3. 游戏画面正常显示

## 优先级

🔴 **最高优先级** - 阻塞所有游戏测试
