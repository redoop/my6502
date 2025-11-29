#!/bin/bash

# 快速检查游戏当前状态

echo "⚡ 快速状态检查"
echo "==============="
echo ""

./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | head -100 &
PID=$!
sleep 10
kill -INT $PID 2>/dev/null
wait $PID 2>/dev/null

echo ""
echo "📊 状态分析："
echo ""

# 检查最近的输出
if [ -f /tmp/nes_flags.log ]; then
    echo "1. 当前 PC 位置:"
    tail -50 /tmp/nes_flags.log | grep "PC:" | tail -3
    
    echo ""
    echo "2. 当前 PPUMASK:"
    tail -50 /tmp/nes_flags.log | grep "PPUMASK:" | tail -1
    
    echo ""
    echo "3. 非零像素:"
    tail -50 /tmp/nes_flags.log | grep "非零像素:" | tail -1
fi
