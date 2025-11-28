#!/bin/bash

# 检查 DEX 指令的零标志设置

echo "🔍 检查 DEX 指令和零标志"
echo "========================"
echo ""
echo "观察 X 寄存器从高值递减到 0 附近的行为"
echo ""

./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep "PC: 0xf1a" | \
    head -500 | \
    awk '{
        for(i=1; i<=NF; i++) {
            if($i == "X:") {
                x = $(i+1)
                gsub(/,/, "", x)
                
                # 转换为十进制
                cmd = "printf \"%d\" " x " 2>/dev/null || echo -1"
                cmd | getline dec
                close(cmd)
                
                if (dec >= 0 && dec <= 5) {
                    print "X = " x " (" dec ")"
                    
                    if (dec == 0) {
                        print "  ⚠️  X 到达 0！下一次 DEX 应该设置零标志"
                        zero_reached = 1
                    } else if (zero_reached && dec == 255) {
                        print "  ❌ 问题：X 从 0 回绕到 255 (0xFF)"
                        print "     这说明 BNE 指令没有正确检查零标志"
                        print ""
                        print "  💡 可能的原因："
                        print "     1. DEX 没有正确设置零标志"
                        print "     2. BNE 没有正确读取零标志"
                        print "     3. 标志寄存器有问题"
                        exit 1
                    }
                }
            }
        }
    }'

echo ""
echo "如果看到 X 从 0 回绕到 255，说明零标志有问题"
