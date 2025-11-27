#!/bin/bash
# 运行 Verilator NES 仿真

set -e

if [ $# -lt 1 ]; then
    echo "用法: $0 <rom文件>"
    exit 1
fi

ROM_FILE="$1"

if [ ! -f "$ROM_FILE" ]; then
    echo "❌ 错误: ROM 文件不存在: $ROM_FILE"
    exit 1
fi

if [ ! -f "build/verilator/VNESSystem" ]; then
    echo "❌ 错误: 仿真器未编译"
    echo "请先运行: ./scripts/verilator_build.sh"
    exit 1
fi

echo "🎮 启动 NES Verilator 仿真..."
echo "   ROM: $ROM_FILE"
echo ""

./build/verilator/VNESSystem "$ROM_FILE"
