#!/bin/bash

echo "监控 PC 变化，看游戏是否卡住..."

timeout 60 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep "帧:" | \
    awk '{print $6}' | \
    uniq -c | \
    tail -20

echo ""
echo "如果看到某个 PC 值重复很多次，说明游戏卡在那里"
