#!/bin/bash

# 快速构建 Verilator 仿真器
set -e

echo "🔨 构建 NES Verilator 仿真器 (快速版本)..."

# 创建构建目录
mkdir -p build/verilator

# 生成 Verilog
echo "📝 生成 Verilog..."
sbt "runMain nes.GenerateNESVerilog"

# 使用 Verilator 编译
echo "⚙️  Verilator 编译..."
cd build/verilator

verilator \
  --cc \
  --exe \
  --build \
  -O3 \
  --x-assign fast \
  --x-initial fast \
  --noassert \
  --threads 4 \
  -Wno-WIDTH \
  -Wno-CASEINCOMPLETE \
  -Wno-CASEX \
  -Wno-TIMESCALEMOD \
  -CFLAGS "-O3 -march=native -std=c++14 $(sdl2-config --cflags)" \
  -LDFLAGS "$(sdl2-config --libs)" \
  ../../generated/nes/NESSystem.v \
  ../../verilator/nes_testbench_fast.cpp

cd ../..

echo "✅ 构建完成！"
echo "运行: ./build/verilator/VNESSystem games/Donkey-Kong.nes"
