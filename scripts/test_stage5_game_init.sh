#!/bin/bash

echo "🧪 阶段 5：分析游戏初始化流程"
echo "=============================="
echo ""
echo "测试目标："
echo "  ✓ 找出游戏卡在哪里"
echo "  ✓ 分析等待循环的条件"
echo "  ✓ 确定游戏期望的状态"
echo ""

echo "运行 15 秒，详细记录 CPU 行为..."
echo ""

OUTPUT=$(timeout 15 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1)

# 分析 PC 的分布
echo "PC 地址分布："
echo "-------------"
echo "$OUTPUT" | grep -oE "PC: 0x[0-9a-f]+" | sort | uniq -c | sort -rn | head -10

echo ""
echo "指令执行统计："
echo "-------------"
echo "$OUTPUT" | grep -oE "\[([A-Z]{3})\]" | sort | uniq -c | sort -rn | head -10

echo ""
echo "寄存器变化范围："
echo "---------------"
echo -n "A: "
echo "$OUTPUT" | grep -oE "A: 0x[0-9a-f]+" | sort -u | head -5
echo -n "X: "
echo "$OUTPUT" | grep -oE "X: 0x[0-9a-f]+" | sort -u | head -5
echo -n "Y: "
echo "$OUTPUT" | grep -oE "Y: 0x[0-9a-f]+" | sort -u | head -5

echo ""
echo "分析结果："
echo "----------"

# 检查是否在循环
PC_COUNT=$(echo "$OUTPUT" | grep -oE "PC: 0x[0-9a-f]+" | wc -l)
UNIQUE_PC=$(echo "$OUTPUT" | grep -oE "PC: 0x[0-9a-f]+" | sort -u | wc -l)

if [ $UNIQUE_PC -lt 10 ]; then
    echo "⚠️  CPU 在小范围内循环（只有 $UNIQUE_PC 个不同的 PC 值）"
    echo "   这表明游戏卡在等待循环中"
else
    echo "✅ CPU 在正常执行（有 $UNIQUE_PC 个不同的 PC 值）"
fi

# 检查是否有内存写入
if echo "$OUTPUT" | grep -q "\[STA\]"; then
    echo "✅ 检测到内存写入操作"
else
    echo "⚠️  未检测到内存写入（可能只在读取）"
fi

echo ""
echo "💡 建议："
echo "   游戏可能在等待："
echo "   1. VBlank 标志被设置"
echo "   2. 特定的 PPU 状态"
echo "   3. 控制器输入"
echo "   4. 内部计时器超时"
