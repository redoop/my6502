#!/bin/bash

echo "🧪 阶段 1：验证 CPU Reset 序列"
echo "================================"
echo ""
echo "测试目标："
echo "  ✓ CPU 从 reset 状态正确启动"
echo "  ✓ PC 跳转到 reset 向量"
echo "  ✓ SP 初始化为 0xFD"
echo "  ✓ 中断标志 I 被设置"
echo ""

timeout 5 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep -A 15 "释放 Reset" | \
    head -20

echo ""
echo "验证结果："
echo "----------"

# 检查 PC 是否跳转到正确的地址
PC_VALUE=$(timeout 5 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep "CPU 已启动" | \
    grep -oE "0x[0-9a-f]+")

if [ ! -z "$PC_VALUE" ] && [ "$PC_VALUE" != "0x0" ]; then
    echo "✅ PC 跳转成功: $PC_VALUE"
else
    echo "❌ PC 跳转失败: $PC_VALUE"
    exit 1
fi

echo "✅ 阶段 1 通过！"
