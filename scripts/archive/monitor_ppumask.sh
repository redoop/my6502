#!/bin/bash

echo "📊 监控 PPUMASK 变化"
echo "==================="
echo ""
echo "运行 Donkey Kong 60 秒，记录 PPUMASK 变化..."
echo ""

timeout 60 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep -E "PPUMASK:" | \
    head -50

echo ""
echo "✅ 监控完成"
