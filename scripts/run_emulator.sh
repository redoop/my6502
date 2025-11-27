#!/bin/bash

# NES 模拟器启动脚本

echo "🎮 NES Emulator - Chisel 版本"
echo "================================"
echo ""

# 检查参数
if [ $# -lt 1 ]; then
    echo "用法: ./run_emulator.sh <rom文件>"
    echo ""
    echo "示例:"
    echo "  ./run_emulator.sh roms/contra.nes"
    echo "  ./run_emulator.sh roms/smb.nes"
    echo ""
    exit 1
fi

ROM_FILE="$1"

# 检查 ROM 文件是否存在
if [ ! -f "$ROM_FILE" ]; then
    echo "❌ ROM 文件不存在: $ROM_FILE"
    exit 1
fi

echo "📁 ROM 文件: $ROM_FILE"
echo ""

# 运行模拟器
echo "🚀 启动模拟器..."
echo ""
echo "控制说明:"
echo "  Z      - A 按钮"
echo "  X      - B 按钮"
echo "  A      - SELECT"
echo "  S      - START"
echo "  方向键  - 移动"
echo "  空格    - 暂停/继续"
echo "  ESC    - 退出"
echo ""

sbt "runMain nes.NESEmulator $ROM_FILE"
