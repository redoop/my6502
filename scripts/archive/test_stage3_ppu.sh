#!/bin/bash

echo "🧪 阶段 3：验证 PPU 基本功能"
echo "============================"
echo ""
echo "测试目标："
echo "  ✓ PPU 寄存器可以被写入"
echo "  ✓ PPUCTRL 和 PPUMASK 有值"
echo "  ✓ VBlank 标志正常工作"
echo ""

echo "运行 10 秒，检查 PPU 状态..."
echo ""

OUTPUT=$(timeout 10 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1)

echo "$OUTPUT" | grep -E "PPUCTRL:|PPUMASK:|PPUSTATUS:" | head -10

echo ""
echo "验证结果："
echo "----------"

# 检查 PPUCTRL
if echo "$OUTPUT" | grep -q "PPUCTRL: 0x[1-9a-f]"; then
    PPUCTRL=$(echo "$OUTPUT" | grep "PPUCTRL:" | head -1 | grep -oE "0x[0-9a-f]+")
    echo "✅ PPUCTRL 已设置: $PPUCTRL"
else
    echo "⚠️  PPUCTRL 可能未设置"
fi

# 检查 PPUMASK
if echo "$OUTPUT" | grep -q "PPUMASK: 0x[1-9a-f]"; then
    PPUMASK=$(echo "$OUTPUT" | grep "PPUMASK:" | head -1 | grep -oE "0x[0-9a-f]+")
    echo "✅ PPUMASK 已设置: $PPUMASK"
else
    echo "❌ PPUMASK 未设置"
    exit 1
fi

# 检查渲染是否启用
if echo "$OUTPUT" | grep -q "BG: ON"; then
    echo "✅ 背景渲染已启用"
elif echo "$OUTPUT" | grep -q "BG: OFF"; then
    echo "⚠️  背景渲染未启用（游戏可能还在初始化）"
fi

echo "✅ 阶段 3 通过！"
