#!/bin/bash

echo "🔍 检查 PPU 状态"
echo "================"
echo ""
echo "运行 Donkey Kong 10 秒，每秒打印一次状态..."
echo ""

timeout 10 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep -E "(帧:|PPUMASK|PPUCTRL|非零像素|CPU:)" | \
    head -50

echo ""
echo "✅ 检查完成"
