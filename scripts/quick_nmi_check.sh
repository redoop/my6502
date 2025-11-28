#!/bin/bash

echo "⚡ 快速 NMI 检查"
echo "================"
echo ""
echo "运行游戏 30 秒，检查 NMI 状态..."
echo ""

# 运行游戏并捕获输出
timeout 30 sbt "runMain nes.NESEmulator games/mario.nes" 2>&1 | \
  grep -E "PPUCTRL|PC: 0xc85|NMI" | \
  tee /tmp/quick_nmi.log

echo ""
echo "分析结果："
echo "----------"

# 检查 PPUCTRL
echo ""
echo "PPUCTRL 值："
grep "PPUCTRL" /tmp/quick_nmi.log | tail -5

# 检查 NMI 向量
echo ""
if grep -q "PC: 0xc85" /tmp/quick_nmi.log; then
    echo "✅ 检测到 NMI 触发！"
    grep "PC: 0xc85" /tmp/quick_nmi.log | head -3
else
    echo "⚠️  未检测到 NMI 触发"
    echo ""
    echo "可能原因："
    echo "1. 游戏还在初始化（需要更长时间）"
    echo "2. PPUCTRL bit 7 未设置"
    echo "3. 游戏在等待某个条件"
fi

echo ""
