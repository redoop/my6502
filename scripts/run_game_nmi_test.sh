#!/bin/bash

echo "🎮 游戏 NMI 测试（快速版）"
echo "=========================="
echo ""

echo "运行 Donkey Kong NMI 测试..."
echo "（限时 60 秒）"
echo ""

# 运行测试，限时 60 秒
timeout 60 sbt "testOnly nes.GameNMITest -- -z Donkey" 2>&1 | \
  tee /tmp/game_nmi_test.log | \
  grep -E "周期|PPUCTRL|NMI|✅|⚠️|测试结果" | \
  head -50

echo ""
echo "检查完整日志..."
if grep -q "NMI 触发成功" /tmp/game_nmi_test.log; then
    echo "✅ NMI 已触发！"
else
    echo "⚠️  NMI 未触发或测试超时"
fi

echo ""
