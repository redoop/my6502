#!/bin/bash

# 分析初始化循环代码
# 查看 0xf1a0-0xf1a7 的指令序列

set -e

echo "🔍 初始化循环代码分析"
echo "====================="
echo ""

if [ ! -f "build/verilator_opt/obj_dir/VNESSystem" ]; then
    echo "❌ 找不到可执行文件"
    exit 1
fi

if [ ! -f "games/Donkey-Kong.nes" ]; then
    echo "❌ 找不到 ROM 文件"
    exit 1
fi

echo "监控地址范围: 0xf1a0 - 0xf1a7"
echo "运行 30 秒，记录指令序列..."
echo ""

# 运行并捕获详细的指令信息
timeout 30 ./build/verilator_opt/obj_dir/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep -E "PC: 0xf1a[0-7]" | head -100 > /tmp/loop_trace.txt || true

echo "指令序列分析:"
echo "============="
echo ""

# 显示前 50 行
head -50 /tmp/loop_trace.txt

echo ""
echo "..."
echo ""
echo "统计信息:"
echo "----------"

# 统计每个 PC 值出现的次数
echo "PC 地址分布:"
grep -oE "PC: 0x[0-9a-f]+" /tmp/loop_trace.txt | sort | uniq -c | sort -rn

echo ""
echo "寄存器变化模式:"
echo "---------------"

# 查看 X 和 Y 寄存器的变化
echo "X 寄存器:"
grep -oE "X: 0x[0-9a-f]+" /tmp/loop_trace.txt | head -20

echo ""
echo "Y 寄存器:"
grep -oE "Y: 0x[0-9a-f]+" /tmp/loop_trace.txt | head -20

echo ""
echo "✅ 分析完成"
echo ""
echo "完整日志保存在: /tmp/loop_trace.txt"
echo ""
echo "推测的循环结构:"
echo "  0xf1a0-0xf1a7: 嵌套延迟循环"
echo "  - 内层循环: Y 寄存器递增"
echo "  - 外层循环: X 寄存器递减"
echo "  - 可能需要数千次迭代才能完成"
