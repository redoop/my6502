#!/bin/bash
# 调试 Donkey Kong - 详细追踪版本

set -e

echo "🔧 编译调试版本..."
echo "===================="

# 生成 Verilog
echo "📝 生成 Verilog..."
sbt "runMain nes.NESSystem" > /dev/null 2>&1

# 编译 Verilator
echo "📦 编译 Verilator 调试版本..."
cd verilator

# 清理旧文件
rm -rf obj_dir_debug
mkdir -p obj_dir_debug

# 运行 Verilator
verilator --cc --exe \
    --build \
    -O3 \
    --x-assign fast \
    --x-initial fast \
    --noassert \
    --trace \
    -Wno-WIDTH \
    -Wno-UNUSED \
    -Wno-UNDRIVEN \
    -Wno-BLKSEQ \
    --top-module NESSystem \
    -Mdir obj_dir_debug \
    ../generated/nes/NESSystem.v \
    nes_testbench_debug.cpp

if [ $? -ne 0 ]; then
    echo "❌ Verilator 编译失败"
    exit 1
fi

echo "✅ 编译完成"
echo ""

# 运行调试
echo "🚀 运行 Donkey Kong 调试..."
echo "===================="

# 运行前 100 万周期
./obj_dir_debug/VNESSystem ../games/Donkey-Kong.nes 1000000

echo ""
echo "✅ 调试完成"
