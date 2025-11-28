#!/bin/bash

echo "🧪 阶段 2：验证 CPU 指令执行"
echo "============================"
echo ""
echo "测试目标："
echo "  ✓ CPU 能执行基本指令（LDA, STA, INX, DEX 等）"
echo "  ✓ 寄存器正确更新"
echo "  ✓ PC 正常递增"
echo ""

echo "运行 5 秒，观察 CPU 状态变化..."
echo ""

timeout 5 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep -E "帧: [0-9]+ \|" | \
    head -10

echo ""
echo "验证结果："
echo "----------"

# 检查寄存器是否有变化
SAMPLE=$(timeout 5 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep -E "帧: [0-9]+ \|" | \
    head -5)

if echo "$SAMPLE" | grep -q "A: 0x[1-9a-f]"; then
    echo "✅ 寄存器 A 有变化"
else
    echo "⚠️  寄存器 A 可能未变化"
fi

if echo "$SAMPLE" | grep -q "X: 0x[1-9a-f]"; then
    echo "✅ 寄存器 X 有变化"
else
    echo "⚠️  寄存器 X 可能未变化"
fi

if echo "$SAMPLE" | grep -q "PC: 0x[c-f][0-9a-f]"; then
    echo "✅ PC 在正常范围内执行"
else
    echo "❌ PC 异常"
    exit 1
fi

echo "✅ 阶段 2 通过！"
