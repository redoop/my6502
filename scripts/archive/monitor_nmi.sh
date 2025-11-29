#!/bin/bash

# NMI 中断监控脚本
# 检查 NMI 是否正确触发

set -e

echo "🔍 NMI 中断监控"
echo "==============="
echo ""

if [ ! -f "build/verilator_opt/obj_dir/VNESSystem" ]; then
    echo "❌ 找不到可执行文件"
    exit 1
fi

if [ ! -f "games/Donkey-Kong.nes" ]; then
    echo "❌ 找不到 ROM 文件"
    exit 1
fi

echo "监控内容:"
echo "  - NMI 输出信号"
echo "  - PPUCTRL bit 7 (NMI 使能)"
echo "  - VBlank 标志"
echo "  - CPU PC 变化（检测中断向量跳转）"
echo ""
echo "运行 30 秒..."
echo ""

# 运行并过滤 NMI 相关信息
timeout 30 ./build/verilator_opt/obj_dir/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep -E "NMI|nmi|中断|PPUCTRL|VBlank|PC: 0xc85f" || true

echo ""
echo "✅ 监控完成"
echo ""
echo "说明:"
echo "  - NMI 向量地址: 0xc85f"
echo "  - 如果看到 PC = 0xc85f，说明 NMI 被触发"
echo "  - PPUCTRL bit 7 = 1 时，NMI 使能"
