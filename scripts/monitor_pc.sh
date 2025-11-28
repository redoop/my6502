#!/bin/bash

echo "🔍 监控 PC 变化"
echo "==============="
echo ""
echo "运行 Donkey Kong 10 秒，记录 PC 值..."
echo ""

timeout 10 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep "帧:" | \
    head -30

echo ""
echo "✅ 监控完成"
