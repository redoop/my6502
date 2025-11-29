#!/bin/bash

# 快速性能测试脚本
# 运行 30 秒并报告 FPS

set -e

echo "⚡ 快速性能测试"
echo "================"
echo ""
echo "测试时长: 30 秒"
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
echo ""

# 运行 30 秒
timeout 30 ./build/verilator_opt/obj_dir/VNESSystem games/Donkey-Kong.nes || true

echo ""
echo ""
echo "✅ 测试完成"
