#!/bin/bash

echo "🎮 测试 Donkey Kong 渲染"
echo "========================"
echo ""

# 运行游戏 30 秒
timeout 30 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | tee test_output.log

echo ""
echo "📊 分析输出..."
echo ""

# 检查是否启用了渲染
if grep -q "渲染已启用" test_output.log; then
    echo "✅ 渲染已启用"
else
    echo "❌ 渲染未启用"
    echo ""
    echo "PPUMASK 值:"
    grep "PPUMASK" test_output.log | tail -5
fi

echo ""
echo "最后的调试信息:"
grep -A 15 "调试信息" test_output.log | tail -20
