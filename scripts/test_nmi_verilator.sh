#!/bin/bash

echo "🔧 使用 Verilator 测试 NMI"
echo "==========================="
echo ""

ROM_FILE="./games/Donkey-Kong.nes"

if [ ! -f "$ROM_FILE" ]; then
    echo "❌ ROM 文件不存在: $ROM_FILE"
    exit 1
fi

echo "ROM: $ROM_FILE"
echo ""

# 检查是否已编译
if [ ! -f "build/verilator_simple/VNESSystem" ]; then
    echo "编译 Verilator 仿真..."
    sbt "runMain nes.GenerateVerilog" 2>&1 | tail -5
    
    if [ ! -d "build/verilator_simple" ]; then
        echo "❌ Verilator 构建目录不存在"
        exit 1
    fi
fi

echo "运行 Verilator 仿真..."
echo ""

# 运行 Verilator testbench
if [ -f "build/verilator_simple/VNESSystem" ]; then
    timeout 30 ./build/verilator_simple/VNESSystem "$ROM_FILE" 2>&1 | \
      grep -E "PPUCTRL|NMI|PC.*c85" | \
      head -50
else
    echo "⚠️  Verilator 可执行文件不存在"
    echo "请先编译 Verilator 仿真"
fi

echo ""
echo "测试完成"
