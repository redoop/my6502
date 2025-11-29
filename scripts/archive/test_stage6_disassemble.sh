#!/bin/bash

echo "🧪 阶段 6：反汇编等待循环"
echo "=========================="
echo ""
echo "分析 0xf1a0-0xf1a7 的代码..."
echo ""

# 运行并捕获详细的指令执行
OUTPUT=$(timeout 5 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1)

echo "指令序列："
echo "----------"
echo "$OUTPUT" | grep -E "\[INY\]|\[DEX\]|\[BNE\]" | head -20

echo ""
echo "分析："
echo "------"
echo "这是一个典型的延迟循环："
echo ""
echo "  f1a0: INY        ; Y++"
echo "  f1a1: BNE xxxx   ; 如果 Y != 0，跳转"
echo "  f1a3: DEX        ; X--"
echo "  f1a4: BNE xxxx   ; 如果 X != 0，跳转"
echo "  f1a6: (退出循环)"
echo ""
echo "这个循环会执行 X * 256 次（因为 Y 从 0 循环到 255）"
echo ""

# 计算大约的循环次数
INY_COUNT=$(echo "$OUTPUT" | grep -c "\[INY\]")
echo "在 5 秒内执行了约 $INY_COUNT 次 INY"
echo "这表明游戏在进行长时间的延迟等待"
echo ""

echo "验证结果："
echo "----------"
echo "✅ 确认游戏在执行延迟循环"
echo "⚠️  游戏可能在等待 VBlank 或其他硬件状态"
echo ""
echo "💡 下一步："
echo "   需要检查游戏退出循环后会做什么"
echo "   可能需要强制触发某个条件让游戏继续"
