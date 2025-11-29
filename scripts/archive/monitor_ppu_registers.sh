#!/bin/bash

# 阶段 3: 监控 PPU 寄存器写入
# 目标：观察游戏何时启用渲染

echo "🔍 阶段 3: PPU 寄存器监控"
echo "========================"
echo ""
echo "监控 PPUMASK 寄存器变化，等待渲染启用..."
echo "（渲染启用时 bit 3 或 4 会被设置）"
echo ""

# 运行 2 分钟
timeout 120 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep "PPUMASK:" | \
    awk '
        BEGIN {
            prev_mask = ""
            count = 0
        }
        {
            # 提取 PPUMASK 值
            for(i=1; i<=NF; i++) {
                if($i == "PPUMASK:") {
                    mask = $(i+1)
                    
                    # 移除括号内容
                    gsub(/\(.*\)/, "", mask)
                    
                    if (mask != prev_mask) {
                        count++
                        print "变化 " count ": PPUMASK = " mask
                        
                        # 检查是否启用渲染
                        # 提取十六进制值（移除 0x 前缀）
                        hex_val = mask
                        gsub(/0x/, "", hex_val)
                        cmd = "echo \"ibase=16; " toupper(hex_val) "\" | bc 2>/dev/null || echo 0"
                        cmd | getline dec_val
                        close(cmd)
                        
                        bg_enabled = (dec_val % 16 >= 8) ? 1 : 0  # bit 3
                        spr_enabled = (dec_val >= 16) ? 1 : 0      # bit 4
                        
                        if (bg_enabled || spr_enabled) {
                            print ""
                            print "✅ 渲染已启用！"
                            if (bg_enabled) print "   - 背景渲染: ON"
                            if (spr_enabled) print "   - 精灵渲染: ON"
                            print ""
                            print "🎉 阶段 3 完成！进入阶段 4..."
                            exit 0
                        }
                        
                        prev_mask = mask
                    }
                }
            }
        }
        END {
            if (count == 0) {
                print "⚠️  未检测到 PPUMASK 变化"
                print "   游戏可能还在初始化"
            } else if (prev_mask != "") {
                print ""
                print "⏸️  渲染仍未启用"
                print "   最后的 PPUMASK = " prev_mask
                print "   游戏还在初始化阶段"
            }
        }
    '

echo ""
echo "💡 提示："
echo "   - 如果长时间没有变化，游戏可能卡住了"
echo "   - 可以尝试手动按 Start 键（在 SDL 窗口中按 Enter）"
echo "   - 或者检查 CPU 是否在正常执行"
