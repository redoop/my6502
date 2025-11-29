#!/bin/bash

# 优化版 Verilator 编译脚本
# 目标：提升 3-5x 性能

set -e

echo "🚀 优化版 Verilator 编译"
echo "========================"
echo ""

# 清理旧的构建
echo "🧹 清理旧构建..."
rm -rf build/verilator_opt
mkdir -p build/verilator_opt

echo ""
echo "📝 编译并生成 Verilog 代码..."
sbt "compile; runMain nes.GenerateNESVerilog"

echo ""
echo "📦 运行 Verilator（优化模式）..."

cd build/verilator_opt

# 复制源文件
cp ../../generated/nes/*.v .
cp ../../verilator/nes_testbench.cpp .

# 获取 SDL2 编译选项
SDL_CFLAGS=$(pkg-config --cflags sdl2)
SDL_LIBS=$(pkg-config --libs sdl2)

# Verilator 超级优化编译
verilator --cc --exe --build \
  -O3 \
  --x-assign fast \
  --x-initial fast \
  --noassert \
  --trace \
  --inline-mult 10000 \
  -CFLAGS "-O3 -march=native -mtune=native -flto -DNDEBUG -ffast-math $SDL_CFLAGS" \
  -LDFLAGS "-O3 -flto $SDL_LIBS" \
  --top-module NESSystem \
  NESSystem.v \
  nes_testbench.cpp

cd ../..

echo ""
echo "✅ 优化编译完成！"
echo ""
echo "可执行文件: build/verilator_opt/obj_dir/VNESSystem"
echo ""
echo "运行仿真:"
echo "  ./build/verilator_opt/obj_dir/VNESSystem <rom文件>"
echo ""
echo "预期性能提升: 3-5x"
