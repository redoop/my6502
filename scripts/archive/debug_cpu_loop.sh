#!/bin/bash

# 阶段 2: 调试 CPU 循环问题
# 目标：验证 DEX 指令和 BNE 分支是否正确工作

echo "🔍 阶段 2: CPU 循环调试"
echo "======================="
echo ""
echo "目标：验证内存清零循环 (0xf19f-0xf1a8)"
echo ""
echo "循环代码："
echo "  0xf19f: STA (\$04),Y  ; 存储 A 到间接地址"
echo "  0xf1a1: INY          ; Y++"
echo "  0xf1a2: INY          ; Y++"
echo "  0xf1a3: INY          ; Y++"
echo "  0xf1a4: INY          ; Y++"
echo "  0xf1a5: DEX          ; X--"
echo "  0xf1a6: BNE \$f19f    ; 如果 X != 0，跳回开始"
echo ""
echo "预期：X 从初始值递减到 0，然后退出循环"
echo ""

# 运行仿真并捕获 X 寄存器变化
echo "📊 监控 X 寄存器变化（运行 30 秒）..."
echo ""

timeout 30 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep -E "PC: 0xf1a[0-8]" | \
    awk '{
        # 提取 X 寄存器值
        for(i=1; i<=NF; i++) {
            if($i == "X:") {
                x = $(i+1)
                gsub(/,/, "", x)
                print "X = " x
            }
        }
    }' | \
    head -100 | \
    awk '
        BEGIN { 
            prev = -1
            count = 0
        }
        {
            x_val = $3
            # 转换十六进制到十进制
            cmd = "printf \"%d\" " x_val
            cmd | getline dec_val
            close(cmd)
            
            if (prev != -1 && dec_val < prev) {
                count++
                if (count <= 10) {
                    print "✓ X 递减: " prev " -> " dec_val " (0x" x_val ")"
                }
            }
            prev = dec_val
            
            if (dec_val == 0) {
                print ""
                print "✅ X 到达 0！循环应该退出"
                exit
            }
        }
        END {
            if (prev > 0) {
                print ""
                print "⚠️  X 还没到 0，当前值: " prev
                print "   循环需要更多时间完成"
            }
        }
    '

echo ""
echo "💡 分析："
echo "   - 如果 X 正常递减，说明 DEX 指令工作正常"
echo "   - 如果 X 到达 0 但循环不退出，说明 BNE 或零标志有问题"
echo "   - 如果 X 一直不变，说明 DEX 指令有问题"
