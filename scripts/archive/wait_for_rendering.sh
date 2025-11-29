#!/bin/bash

# 等待游戏启用渲染
# 最多等待 10 分钟

echo "⏳ 等待游戏启用渲染"
echo "===================="
echo ""
echo "这可能需要几分钟..."
echo "（按 Ctrl+C 可以随时停止）"
echo ""

START_TIME=$(date +%s)
MAX_WAIT=600  # 10 分钟

./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    while IFS= read -r line; do
        # 显示进度
        if [[ "$line" == *"帧:"* ]]; then
            CURRENT_TIME=$(date +%s)
            ELAPSED=$((CURRENT_TIME - START_TIME))
            echo -ne "\r⏱️  运行时间: ${ELAPSED}s | $line"
            
            # 超时检查
            if [ $ELAPSED -gt $MAX_WAIT ]; then
                echo ""
                echo ""
                echo "⏰ 超时（10 分钟）"
                echo "   游戏可能需要更长时间或存在问题"
                pkill -P $$ VNESSystem
                exit 1
            fi
        fi
        
        # 检查渲染启用
        if [[ "$line" == *"PPUMASK:"* ]] && [[ "$line" == *"ON"* ]]; then
            echo ""
            echo ""
            echo "🎉 检测到渲染启用！"
            echo "   $line"
            echo ""
            
            # 再运行 5 秒确认
            sleep 5
            
            echo "✅ 阶段 3 完成！"
            echo ""
            echo "验证结果："
            echo "  ✅ CPU 能写入 PPU 寄存器"
            echo "  ✅ 游戏启用了渲染"
            echo "  ✅ PPU 寄存器访问正常"
            echo ""
            
            pkill -P $$ VNESSystem
            exit 0
        fi
        
        # 显示重要事件
        if [[ "$line" == *"自动按下 Start"* ]]; then
            echo ""
            echo "🎮 $line"
        fi
        
        if [[ "$line" == *"调试信息"* ]]; then
            # 每 30 秒显示一次调试信息
            CURRENT_TIME=$(date +%s)
            if [ $((CURRENT_TIME % 30)) -eq 0 ]; then
                echo ""
                echo "📊 状态更新:"
            fi
        fi
    done

echo ""
echo "⏸️  游戏结束或被中断"
