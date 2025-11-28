#!/bin/bash

echo "⏱️  长时间运行测试"
echo "=================="
echo ""
echo "让游戏运行 2 分钟，观察是否会退出初始化循环..."
echo ""

timeout 120 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 > /tmp/nes_long_run.log

echo "运行完成，分析日志..."

echo ""
echo "分析结果："
echo "----------"

# 检查 PPUMASK 是否有变化
PPUMASK_VALUES=$(grep "PPUMASK:" /tmp/nes_long_run.log | sort -u | wc -l)
echo "PPUMASK 不同值的数量: $PPUMASK_VALUES"

if [ $PPUMASK_VALUES -gt 1 ]; then
    echo "✅ PPUMASK 有变化！"
    grep "PPUMASK:" /tmp/nes_long_run.log | sort -u
else
    echo "⚠️  PPUMASK 没有变化"
fi

# 检查 PC 的范围
echo ""
echo "PC 地址范围："
grep -oE "PC: 0x[0-9a-f]+" /tmp/nes_long_run.log | sort -u | head -20

# 检查是否有渲染
if grep -q "BG: ON" /tmp/nes_long_run.log; then
    echo ""
    echo "🎉 检测到渲染启用！"
else
    echo ""
    echo "⚠️  渲染仍未启用"
fi
