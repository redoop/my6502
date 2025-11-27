#!/bin/bash

echo ""
echo "🎮 快速测试改进的终端显示"
echo "=========================="
echo ""
echo "改进内容："
echo "  ✅ 分辨率提高 2 倍 (使用半字符)"
echo "  ✅ 精确的 RGB 颜色映射"
echo "  ✅ 基于真实 NES 调色板"
echo ""
echo "按 Ctrl+C 停止"
echo ""
sleep 2

# 运行 3 秒的演示
timeout 3 bash -c 'echo "" | sbt -Dsbt.log.noformat=true "runMain nes.SimpleTerminalEmulator games/Super-Contra-X-\(China\)-\(Pirate\).nes" 2>/dev/null' || true

echo ""
echo ""
echo "✅ 测试完成！"
echo ""
echo "完整运行请使用："
echo "  ./run_terminal.sh games/Super-Contra-X-\(China\)-\(Pirate\).nes demo"
echo ""
