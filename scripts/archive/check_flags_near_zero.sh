#!/bin/bash

# 检查 X 接近 0 时的标志位

echo "🔍 检查 X 接近 0 时的标志位"
echo "============================"
echo ""

./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    awk '
        /PC: 0xf1a5/ {
            # 提取 X 值
            for(i=1; i<=NF; i++) {
                if($i == "X:") {
                    x = $(i+1)
                    gsub(/,/, "", x)
                    line = $0
                }
            }
        }
        /Flags:/ {
            if (x != "") {
                # 转换 X 为十进制
                cmd = "printf \"%d\" " x " 2>/dev/null || echo -1"
                cmd | getline dec
                close(cmd)
                
                if (dec >= 0 && dec <= 10) {
                    print "X = " x " (" dec ")"
                    print "  " $0
                    
                    if (dec == 0) {
                        print "  ⚠️  X = 0，Z 标志应该是 1"
                    }
                }
                x = ""
            }
        }
    ' | head -50

echo ""
echo "观察 X = 0 时 Z 标志是否为 1"
