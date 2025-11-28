#!/bin/bash

# 简化版 PPU 监控 - 直接显示调试信息

echo "🔍 监控 PPU 寄存器（2 分钟）"
echo "=============================="
echo ""
echo "等待 PPUMASK 启用渲染（bit 3 或 4 被设置）..."
echo ""

./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    while IFS= read -r line; do
        # 显示调试信息块
        if [[ "$line" == *"=== 调试信息 ==="* ]]; then
            echo ""
            echo "$line"
            in_debug=1
        elif [[ "$in_debug" == "1" ]]; then
            echo "$line"
            
            # 检查 PPUMASK
            if [[ "$line" == *"PPUMASK:"* ]]; then
                if [[ "$line" == *"BG: ON"* ]] || [[ "$line" == *"SPR: ON"* ]]; then
                    echo ""
                    echo "✅ 渲染已启用！"
                    echo ""
                    pkill -P $$ VNESSystem
                    exit 0
                fi
            fi
            
            # 调试块结束
            if [[ "$line" == *"==================="* ]]; then
                in_debug=0
            fi
        fi
        
        # 显示自动按键提示
        if [[ "$line" == *"自动按下 Start"* ]]; then
            echo ""
            echo "🎮 $line"
            echo ""
        fi
    done

echo ""
echo "⏸️  2 分钟内渲染未启用"
echo "   游戏可能需要更长时间初始化"
