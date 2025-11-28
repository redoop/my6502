#!/bin/bash

# 长时间性能测试脚本
# 运行 5 分钟，确保能看到渲染启用

set -e

echo "⚡ 长时间性能测试"
echo "================="
echo ""
echo "测试时长: 5 分钟"
echo "目标: 等待游戏完成初始化并启用渲染"
echo ""

# 检查可执行文件
if [ ! -f "build/verilator_opt/obj_dir/VNESSystem" ]; then
    echo "❌ 找不到优化版可执行文件"
    echo "   请先运行: bash scripts/verilator_build_optimized.sh"
    exit 1
fi

# 检查 ROM
if [ ! -f "games/Donkey-Kong.nes" ]; then
    echo "❌ 找不到 ROM 文件: games/Donkey-Kong.nes"
    exit 1
fi

echo "🎮 启动模拟器..."
echo "   提示: 观察 PPUMASK 值的变化"
echo "   当 PPUMASK = 0x18 时，渲染将启用"
echo ""

# 运行 5 分钟
timeout 300 ./build/verilator_opt/obj_dir/VNESSystem games/Donkey-Kong.nes || true

echo ""
echo ""
echo "✅ 测试完成"
