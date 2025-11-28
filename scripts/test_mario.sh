#!/bin/bash

# Super Mario Bros 测试脚本
# 测试一个更简单的游戏，看是否有同样的问题

set -e

echo "🍄 Super Mario Bros 测试"
echo "========================"
echo ""

if [ ! -f "build/verilator_opt/obj_dir/VNESSystem" ]; then
    echo "❌ 找不到可执行文件"
    echo "   请先运行: bash scripts/verilator_build_optimized.sh"
    exit 1
fi

if [ ! -f "games/Super-Mario-Bros.nes" ]; then
    echo "❌ 找不到 ROM 文件: games/Super-Mario-Bros.nes"
    exit 1
fi

echo "测试目标:"
echo "  - 观察初始化时间是否更短"
echo "  - 检查 PPUMASK 变化"
echo "  - 看是否能更快启用渲染"
echo ""
echo "运行 2 分钟..."
echo ""

# 运行 2 分钟
timeout 120 ./build/verilator_opt/obj_dir/VNESSystem games/Super-Mario-Bros.nes || true

echo ""
echo ""
echo "✅ 测试完成"
echo ""
echo "对比 Donkey Kong:"
echo "  - Donkey Kong: 7000+ 帧仍在初始化"
echo "  - Super Mario Bros: (查看上面的结果)"
