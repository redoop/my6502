#!/bin/bash
# 编译最小化调试版本

echo "🔨 编译最小化调试版本"
echo "======================="

# 生成 Verilog
echo "📝 生成 Verilog..."
./scripts/generate_verilog.sh > /dev/null 2>&1

if [ ! -f "generated/nes/NESSystem.v" ]; then
    echo "❌ Verilog 生成失败"
    exit 1
fi

echo "✅ Verilog 生成完成"

# 创建构建目录
mkdir -p build/minimal

# 编译
echo "🔨 编译 Verilator..."
verilator --cc generated/nes/NESSystem.v \
    --exe verilator/nes_testbench_minimal.cpp \
    --top-module NESSystem \
    -Wno-WIDTH -Wno-UNUSED -Wno-UNDRIVEN -Wno-CASEINCOMPLETE \
    --Mdir build/minimal \
    -CFLAGS "-std=c++11 -O2" \
    --build

if [ $? -eq 0 ]; then
    echo "✅ 编译成功"
    echo ""
    echo "运行: ./build/minimal/VNESSystem games/Donkey-Kong.nes [max_cycles]"
else
    echo "❌ 编译失败"
    exit 1
fi
