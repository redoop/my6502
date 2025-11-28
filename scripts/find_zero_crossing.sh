#!/bin/bash

# 专门查找 X 从 1 递减到 0 的时刻

echo "🔍 查找 X = 1 -> 0 的关键时刻"
echo "=============================="
echo ""
echo "这将运行较长时间，请耐心等待..."
echo ""

./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    awk '
        /\[DEX\]/ {
            if ($0 ~ /X:   1 ->   0/) {
                print "🎯 找到了！X 从 1 递减到 0："
                print $0
                found_zero = 1
                context_count = 0
            } else if (found_zero && context_count < 10) {
                print $0
                context_count++
                if (context_count >= 10) {
                    print ""
                    print "✅ 已捕获 X = 0 后的 10 行上下文"
                    exit 0
                }
            }
        }
        /\[BNE\]/ && found_zero && context_count < 10 {
            print $0
            context_count++
        }
        /\[INY\]/ && found_zero && context_count < 10 {
            print $0
            context_count++
        }
    '

echo ""
echo "如果没有输出，说明 X 一直没有到达 0"
echo "这可能意味着循环条件有问题"
