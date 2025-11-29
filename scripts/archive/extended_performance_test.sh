#!/bin/bash

# 扩展性能测试脚本
# 运行 2 分钟，看看能否突破初始化循环

set -e

echo "⚡ 扩展性能测试"
echo "================"
echo ""
echo "测试时长: 2 分钟"
echo "目标: 突破初始化循环，看到渲染启用"
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

# 运行 2 分钟
timeout 120 ./build/verilator_opt/obj_dir/VNESSystem games/Donkey-Kong.nes || true

echo ""
echo ""
echo "✅ 测试完成"
