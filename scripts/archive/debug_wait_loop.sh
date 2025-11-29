#!/bin/bash

echo "🔍 调试等待循环"
echo "================"
echo ""
echo "分析 0xc7bd 地址的指令..."
echo ""

# 运行并捕获详细信息
sbt "runMain nes.NESEmulator games/mario.nes" 2>&1 | grep -A 2 -B 2 "PC: 0xc7b" | head -50
