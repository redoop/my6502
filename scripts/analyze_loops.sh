#!/bin/bash

echo "🔍 分析游戏循环"
echo "================"
echo ""

# 编译并运行，捕获详细的内存访问
sbt "runMain nes.NESEmulator games/mario.nes" 2>&1 | head -500 | grep -E "\[LDA\]|\[BIT\]|\[BNE\]|PC: 0xc7bd|PC: 0xf1a" | head -100

echo ""
echo "分析完成"
