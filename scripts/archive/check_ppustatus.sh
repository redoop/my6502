#!/bin/bash

echo "🔍 检查 PPUSTATUS 读取"
echo "======================"
echo ""

# 运行并捕获 PPU 状态读取
timeout 5 sbt "runMain nes.NESEmulator games/mario.nes" 2>&1 | grep -E "LDA.*2002|BIT.*2002|PPUSTATUS" | head -30

echo ""
echo "检查完成"
