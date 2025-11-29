#!/bin/bash
# 监控 PPU 状态变化

echo "🔍 监控 PPU 状态..."
echo "按 Ctrl+C 停止"
echo ""

timeout 60 ./scripts/verilator_run.sh "games/Donkey-Kong.nes" 2>&1 | \
    grep -E "(PPU 调试信息|PPUCTRL|PPUMASK|PPUSTATUS|调色板初始化|非零像素)" | \
    while read line; do
        echo "$line"
    done
