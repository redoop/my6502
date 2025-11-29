#!/bin/bash

echo "🎮 长时间测试 Donkey Kong"
echo "运行 5 分钟，观察游戏是否启用渲染..."
echo ""

timeout 300 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep -E "(渲染已启用|PPUMASK.*ON|帧:.*FPS)" | \
    head -100

echo ""
echo "测试完成"
