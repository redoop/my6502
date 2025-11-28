#!/bin/bash

# 长时间运行测试 - 观察游戏是否最终启用渲染

echo "🎮 长时间运行测试（5 分钟）"
echo "============================"
echo ""
echo "目标：观察游戏是否会自然启用渲染"
echo ""
echo "监控要点："
echo "  1. PC 是否离开 0xf1a0 循环"
echo "  2. PPUMASK 是否变化"
echo "  3. 非零像素是否出现"
echo ""
echo "开始运行..."
echo ""

# 保存输出到文件
LOG_FILE="/tmp/nes_long_run.log"
./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | tee "$LOG_FILE" &
PID=$!

# 每30秒检查一次状态
for i in {1..10}; do
    sleep 30
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "⏱️  检查点 $i ($(($i * 30)) 秒)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # 检查最新的 PC 值
    LATEST_PC=$(tail -20 "$LOG_FILE" | grep "PC:" | tail -1 | grep -o "PC: 0x[0-9a-f]*" | cut -d' ' -f2)
    echo "  最新 PC: $LATEST_PC"
    
    # 检查是否还在循环中
    if [[ "$LATEST_PC" == "0xf1a"* ]]; then
        echo "  状态: 仍在内存清零循环"
    else
        echo "  状态: 已离开循环！✅"
    fi
    
    # 检查 PPUMASK
    LATEST_MASK=$(tail -50 "$LOG_FILE" | grep "PPUMASK:" | tail -1)
    if [[ "$LATEST_MASK" == *"ON"* ]]; then
        echo "  PPUMASK: 渲染已启用！✅"
        echo ""
        echo "🎉 成功！游戏已启用渲染"
        kill -INT $PID 2>/dev/null
        exit 0
    else
        echo "  PPUMASK: 渲染未启用"
    fi
    
    # 检查非零像素
    NON_ZERO=$(tail -50 "$LOG_FILE" | grep "非零像素:" | tail -1 | grep -o "[0-9]* /" | grep -o "[0-9]*" | head -1)
    if [ -n "$NON_ZERO" ] && [ "$NON_ZERO" -gt 0 ]; then
        echo "  像素: $NON_ZERO 个非零像素 ✅"
    else
        echo "  像素: 全黑"
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⏱️  测试结束（5 分钟）"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "结论："

# 最终检查
FINAL_PC=$(tail -20 "$LOG_FILE" | grep "PC:" | tail -1 | grep -o "PC: 0x[0-9a-f]*" | cut -d' ' -f2)
FINAL_MASK=$(tail -50 "$LOG_FILE" | grep "PPUMASK:" | tail -1)

if [[ "$FINAL_MASK" == *"ON"* ]]; then
    echo "  ✅ 游戏成功启用渲染"
    echo "  📍 进入阶段 4: PPU 内存访问验证"
elif [[ "$FINAL_PC" != "0xf1a"* ]]; then
    echo "  ⚠️  游戏离开了初始循环，但渲染未启用"
    echo "  💡 可能在等待用户输入或其他条件"
    echo "  📍 建议：手动按 Start 键（在 SDL 窗口按 Enter）"
else
    echo "  ❌ 游戏仍卡在初始化循环"
    echo "  💡 可能的问题："
    echo "     1. 循环条件判断错误"
    echo "     2. 需要更长时间"
    echo "     3. CPU 指令实现有问题"
fi

kill -INT $PID 2>/dev/null
wait $PID 2>/dev/null

echo ""
echo "日志已保存到: $LOG_FILE"
