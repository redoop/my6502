#!/bin/bash
# 快速调试 Donkey Kong

echo "🔍 快速调试 Donkey Kong"
echo "======================="
echo ""

# 运行 10 秒并保存日志
echo "📝 运行 10 秒并捕获日志..."
timeout 10 ./scripts/verilator_run.sh games/Donkey-Kong.nes 2>&1 | tee dk_debug.log

echo ""
echo "📊 分析日志..."
echo "======================="

# 统计向量表访问
echo ""
echo "🔍 向量表访问 (PC >= 0xFFF0):"
grep -E "PC: 0xfff[0-9a-f]" dk_debug.log | head -20

# 统计 SP 变化
echo ""
echo "🔍 SP 变化:"
grep -E "SP: 0x" dk_debug.log | tail -20

# 查找错误
echo ""
echo "🔍 错误信息:"
grep -i "error\|warning\|fail" dk_debug.log

echo ""
echo "✅ 日志已保存到 dk_debug.log"
echo ""
echo "📝 下一步:"
echo "   1. 查看完整日志: less dk_debug.log"
echo "   2. 分析日志: python3 scripts/analyze_execution.py dk_debug.log"
echo "   3. 查看调试指南: cat docs/DEBUG_GUIDE.md"
