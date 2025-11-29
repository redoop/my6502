#!/bin/bash
# 统一运行脚本 - 运行 NES 游戏

ROM="${1:-games/Donkey-Kong.nes}"

if [ ! -f "$ROM" ]; then
    echo "❌ ROM 文件不存在: $ROM"
    echo ""
    echo "用法: $0 <rom文件>"
    echo "示例: $0 games/Donkey-Kong.nes"
    exit 1
fi

if [ ! -f "build/verilator/VNESSystem" ]; then
    echo "⚠️  仿真器未编译，正在编译..."
    ./scripts/build.sh fast
fi

echo "🎮 启动 NES 模拟器"
echo "===================="
echo "ROM: $ROM"
echo ""
echo "⚠️  注意："
echo "   - Verilator 是硬件级仿真，速度较慢（约 2-5 FPS）"
echo "   - 这是正常的，因为它在模拟每个时钟周期"
echo ""
echo "🎮 控制："
echo "   方向键 - 移动"
echo "   Z - A 按钮"
echo "   X - B 按钮"
echo "   Enter - Start"
echo "   RShift - Select"
echo ""
echo "按 Ctrl+C 退出"
echo ""

./build/verilator/VNESSystem "$ROM"
