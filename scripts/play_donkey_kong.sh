#!/bin/bash

# 运行 Donkey Kong 游戏
# 注意：Verilator 仿真速度较慢（约 2-5 FPS），这是正常的硬件仿真性能

echo "🎮 启动 Donkey Kong"
echo "===================="
echo ""
echo "⚠️  注意："
echo "   - Verilator 是硬件级仿真，速度较慢（约 2-5 FPS）"
echo "   - 这是正常的，因为它在模拟每个时钟周期"
echo "   - 游戏逻辑是正确的，只是运行速度慢"
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


#./scripts/verilator_build.sh 2>&1
./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1