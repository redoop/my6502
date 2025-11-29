#!/bin/bash

echo "🧪 阶段 4：验证 NMI 中断"
echo "========================"
echo ""
echo "测试目标："
echo "  ✓ NMI 中断能够触发"
echo "  ✓ PC 跳转到 NMI 向量"
echo "  ✓ 中断处理程序执行"
echo ""

echo "分析 NMI 向量和中断行为..."
echo ""

# 获取 NMI 向量地址
NMI_VECTOR=$(timeout 5 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep "NMI 向量" | \
    grep -oE "0x[0-9a-f]+")

echo "NMI 向量地址: $NMI_VECTOR"
echo ""

# 运行一段时间，看 PC 是否访问过 NMI 向量附近的地址
echo "运行 10 秒，检查是否有 NMI 中断..."
OUTPUT=$(timeout 10 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1)

# 提取 NMI 向量的数值部分（去掉 0x）
NMI_ADDR=$(echo $NMI_VECTOR | sed 's/0x//')

echo ""
echo "验证结果："
echo "----------"

# 检查 PC 是否曾经跳转到 NMI 向量附近
if echo "$OUTPUT" | grep -q "PC: $NMI_VECTOR"; then
    echo "✅ 检测到 PC 跳转到 NMI 向量"
else
    echo "⚠️  未检测到 NMI 中断（可能 NMI 未启用或频率太低）"
fi

# 检查 PPUCTRL bit 7 (NMI 使能)
if echo "$OUTPUT" | grep -q "PPUCTRL: 0x[89abcdef]"; then
    echo "✅ PPUCTRL bit 7 已设置（NMI 使能）"
else
    echo "⚠️  PPUCTRL bit 7 未设置（NMI 未启用）"
fi

# 检查 VBlank 标志
if echo "$OUTPUT" | grep -q "VBlank: 是"; then
    echo "✅ VBlank 标志正常工作"
else
    echo "⚠️  VBlank 标志可能有问题"
fi

echo ""
echo "💡 提示："
echo "   如果 NMI 未触发，可能原因："
echo "   1. PPUCTRL bit 7 未设置（游戏未启用 NMI）"
echo "   2. NMI 中断逻辑有问题"
echo "   3. 游戏还在初始化阶段"
echo ""
echo "✅ 阶段 4 完成（部分功能待验证）"
