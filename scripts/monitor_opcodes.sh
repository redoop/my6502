#!/bin/bash
# 监控 NES 仿真器并记录遇到的 opcode

echo "🔍 监控 Donkey Kong 执行的 opcodes..."
echo "按 Ctrl+C 停止"
echo ""

timeout 30 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | \
    grep "Opcode:" | \
    awk '{print $NF}' | \
    sort -u | \
    while read opcode; do
        echo "遇到 opcode: $opcode"
    done

echo ""
echo "✅ 监控完成"
