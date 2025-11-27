#!/bin/bash

# 终端 NES 模拟器启动脚本

echo "🎮 NES 终端模拟器"
echo "================================"
echo ""

# 检查参数
if [ $# -lt 1 ]; then
    echo "用法: ./run_terminal.sh <rom文件> [模式]"
    echo ""
    echo "模式:"
    echo "  demo    - 演示模式 (显示测试图案)"
    echo "  full    - 完整模式 (边缘+填充显示 CHR 数据)"
    echo "  outline - 轮廓模式 (只显示边缘线条)"
    echo ""
    echo "示例:"
    echo "  ./run_terminal.sh games/contra.nes demo"
    echo "  ./run_terminal.sh games/contra.nes full"
    echo "  ./run_terminal.sh games/contra.nes outline"
    echo ""
    exit 1
fi

ROM_FILE="$1"
MODE="${2:-demo}"

# 检查 ROM 文件是否存在
if [ ! -f "$ROM_FILE" ]; then
    echo "❌ ROM 文件不存在: $ROM_FILE"
    exit 1
fi

echo "📁 ROM 文件: $ROM_FILE"
echo "🎯 模式: $MODE"
echo ""

# 检查终端支持
if [ -z "$TERM" ]; then
    echo "⚠️  警告: 未检测到 TERM 环境变量"
fi

# 检查终端颜色支持
COLORS=$(tput colors 2>/dev/null || echo "0")
if [ "$COLORS" -lt 256 ]; then
    echo "⚠️  警告: 终端仅支持 $COLORS 色，建议使用 256 色终端"
    echo "   推荐终端: xterm-256color, screen-256color"
fi

echo ""
echo "控制说明:"
echo "  W/A/S/D - 方向键"
echo "  J       - A 按钮"
echo "  K       - B 按钮"
echo "  U       - SELECT"
echo "  I       - START"
echo "  P       - 暂停/继续"
echo "  Q       - 退出"
echo ""

# 根据模式运行
if [ "$MODE" = "demo" ]; then
    echo "🚀 启动演示模式..."
    echo ""
    sbt "runMain nes.SimpleTerminalEmulator $ROM_FILE"
elif [ "$MODE" = "full" ]; then
    echo "🚀 启动完整模式 (边缘+填充)..."
    echo "   (这需要较长时间编译和运行)"
    echo ""
    sbt "runMain nes.TerminalEmulator $ROM_FILE"
elif [ "$MODE" = "outline" ]; then
    echo "🚀 启动轮廓线条模式..."
    echo "   (只显示图形边缘，不填充内部)"
    echo ""
    sbt "runMain nes.TerminalEmulatorOutline $ROM_FILE"
else
    echo "❌ 未知模式: $MODE"
    echo "   支持的模式: demo, full, outline"
    exit 1
fi
