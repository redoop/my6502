#!/bin/bash

# 验证游戏是否在正常推进，还是真的卡住了

echo "🔍 验证游戏进度"
echo "================"
echo ""
echo "检查游戏是否在正常推进，还是真的卡住了..."
echo ""

# 运行 30 秒，记录 PC 的变化
echo "采集 30 秒数据..."

./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 > /tmp/progress_check.log 2>&1 &
PID=$!
sleep 30
kill -INT $PID 2>/dev/null
wait $PID 2>/dev/null

echo ""
echo "📊 分析结果："
echo ""

# 检查 PC 的唯一值数量
PC_COUNT=$(grep "PC:" /tmp/progress_check.log | grep -o "PC: 0x[0-9a-f]*" | sort -u | wc -l | tr -d ' ')

echo "1. PC 地址多样性："
echo "   唯一 PC 值: $PC_COUNT"

if [ "$PC_COUNT" -gt 20 ]; then
    echo "   ✅ 游戏在执行多个不同的代码段"
elif [ "$PC_COUNT" -gt 5 ]; then
    echo "   ⚠️  游戏主要在几个地址之间循环"
else
    echo "   ❌ 游戏可能真的卡住了"
fi

echo ""

# 检查是否离开了 0xf1a0 循环
LEFT_LOOP=$(grep "PC:" /tmp/progress_check.log | grep -v "PC: 0xf1a" | wc -l | tr -d ' ')
TOTAL_PC=$(grep "PC:" /tmp/progress_check.log | wc -l | tr -d ' ')

if [ "$TOTAL_PC" -gt 0 ]; then
    PERCENTAGE=$((LEFT_LOOP * 100 / TOTAL_PC))
    echo "2. 循环外执行比例："
    echo "   循环外: $LEFT_LOOP / $TOTAL_PC ($PERCENTAGE%)"
    
    if [ "$PERCENTAGE" -gt 50 ]; then
        echo "   ✅ 游戏大部分时间在循环外执行"
    elif [ "$PERCENTAGE" -gt 10 ]; then
        echo "   ⚠️  游戏在循环内外切换"
    else
        echo "   ⏸️  游戏主要在循环内执行（正常的初始化）"
    fi
fi

echo ""

# 检查 X 寄存器的变化范围
echo "3. X 寄存器变化范围："
X_VALUES=$(grep "X:" /tmp/progress_check.log | grep -o "X: 0x[0-9a-f]*" | sort -u | wc -l | tr -d ' ')
echo "   不同的 X 值: $X_VALUES"

if [ "$X_VALUES" -gt 100 ]; then
    echo "   ✅ X 在大范围变化（嵌套循环正常执行）"
elif [ "$X_VALUES" -gt 20 ]; then
    echo "   ✅ X 在中等范围变化（循环正常）"
elif [ "$X_VALUES" -gt 5 ]; then
    echo "   ⚠️  X 变化范围较小"
else
    echo "   ❌ X 几乎不变（可能有问题）"
fi

echo ""

# 检查 PPUMASK 是否有变化
echo "4. PPU 状态："
PPUMASK_CHANGES=$(grep "PPUMASK:" /tmp/progress_check.log | grep -o "0x[0-9a-f]*" | sort -u | wc -l | tr -d ' ')

if [ "$PPUMASK_CHANGES" -gt 1 ]; then
    echo "   ✅ PPUMASK 有变化（游戏在推进）"
    grep "PPUMASK:" /tmp/progress_check.log | tail -3
else
    PPUMASK_VAL=$(grep "PPUMASK:" /tmp/progress_check.log | head -1 | grep -o "0x[0-9a-f]*" | head -1)
    echo "   ⏸️  PPUMASK 保持不变: $PPUMASK_VAL"
    echo "   （游戏还在初始化阶段）"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━"
echo "📊 综合判断："
echo ""

# ���合判断
if [ "$PC_COUNT" -gt 20 ] && [ "$X_VALUES" -gt 50 ]; then
    echo "✅ 游戏正常运行"
    echo "   - CPU 在执行多样化的代码"
    echo "   - 嵌套循环正常工作"
    echo "   - 只是初始化需要时间"
    echo ""
    echo "🎯 建议：继续等待，游戏会完成初始化"
elif [ "$PC_COUNT" -gt 5 ] && [ "$X_VALUES" -gt 10 ]; then
    echo "⚠️  游戏在缓慢推进"
    echo "   - CPU 在执行循环"
    echo "   - 进度正常但很慢"
    echo ""
    echo "🎯 建议："
    echo "   1. 继续等待（可能需要 5-10 分钟）"
    echo "   2. 或考虑优化 Verilator 编译选项"
else
    echo "❌ 可能存在问题"
    echo "   - CPU 执行范围太窄"
    echo "   - 可能真的卡住了"
    echo ""
    echo "🎯 建议："
    echo "   1. 检查 CPU 指令实现"
    echo "   2. 查看详细日志"
    echo "   3. 运行单元测试"
fi

echo ""
echo "详细日志: /tmp/progress_check.log"
