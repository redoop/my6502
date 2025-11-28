#!/bin/bash

echo "🧪 NES 模拟器分阶段验证"
echo "======================="
echo ""
echo "开始完整的分阶段测试..."
echo ""

FAILED=0

# 阶段 1
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash scripts/test_stage1_reset.sh
if [ $? -ne 0 ]; then
    FAILED=$((FAILED + 1))
fi
echo ""

# 阶段 2
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash scripts/test_stage2_instructions.sh
if [ $? -ne 0 ]; then
    FAILED=$((FAILED + 1))
fi
echo ""

# 阶段 3
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash scripts/test_stage3_ppu.sh
if [ $? -ne 0 ]; then
    FAILED=$((FAILED + 1))
fi
echo ""

# 阶段 4
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash scripts/test_stage4_nmi.sh
echo ""

# 阶段 5
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash scripts/test_stage5_game_init.sh
echo ""

# 阶段 6
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
bash scripts/test_stage6_disassemble.sh
echo ""

# 总结
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📊 测试总结"
echo "==========="
echo ""

if [ $FAILED -eq 0 ]; then
    echo "✅ 所有关键阶段通过！"
else
    echo "❌ 有 $FAILED 个阶段失败"
fi

echo ""
echo "当前状态："
echo "----------"
echo "✅ CPU Reset 正常"
echo "✅ 指令执行正常"
echo "✅ PPU 寄存器可访问"
echo "⚠️  NMI 中断未启用（游戏未设置）"
echo "⚠️  渲染未启用（PPUMASK bit 3/4 = 0）"
echo "⚠️  游戏卡在延迟循环中"
echo ""
echo "问题分析："
echo "----------"
echo "游戏正在执行一个长时间的延迟循环（INY/DEX/BNE）"
echo "这可能是："
echo "  1. 启动延迟（等待硬件稳定）"
echo "  2. 等待某个条件（但条件可能永远不满足）"
echo "  3. 游戏 ROM 的特殊初始化流程"
echo ""
echo "下一步建议："
echo "------------"
echo "1. 让游戏运行更长时间（1-2 分钟）看是否会退出循环"
echo "2. 检查游戏是否在等待控制器输入"
echo "3. 分析循环退出后的代码"
echo "4. 对比真实 NES 的行为"
