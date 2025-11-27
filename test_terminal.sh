#!/bin/bash

# 测试终端模拟器 (输出到文件)

echo "🎮 测试终端模拟器"
echo ""

ROM_FILE="${1:-games/Super-Contra-X-(China)-(Pirate).nes}"

if [ ! -f "$ROM_FILE" ]; then
    echo "❌ ROM 文件不存在: $ROM_FILE"
    exit 1
fi

echo "📁 ROM 文件: $ROM_FILE"
echo "📝 输出文件: terminal_output.txt"
echo ""

# 运行并捕获输出
timeout 5 sbt "runMain nes.SimpleTerminalEmulator $ROM_FILE" 2>&1 | head -100 > terminal_output.txt

echo "✅ 测试完成"
echo ""
echo "输出预览:"
head -50 terminal_output.txt
