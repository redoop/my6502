#!/bin/bash
# 使用 Verilator 编译 NES 系统仿真器

set -e

echo "🔨 编译 Verilator 仿真器..."
echo ""

# 检查 Verilator 是否安装
if ! command -v verilator &> /dev/null; then
    echo "❌ 错误: Verilator 未安装"
    echo ""
    echo "安装方法:"
    echo "  Ubuntu/Debian: sudo apt-get install verilator"
    echo "  macOS: brew install verilator"
    echo "  或从源码编译: https://verilator.org/guide/latest/install.html"
    exit 1
fi

# 检查 SDL2 是否安装
if ! pkg-config --exists sdl2; then
    echo "❌ 错误: SDL2 未安装"
    echo ""
    echo "安装方法:"
    echo "  Ubuntu/Debian: sudo apt-get install libsdl2-dev"
    echo "  macOS: brew install sdl2"
    exit 1
fi

# 检查 Verilog 文件是否存在
if [ ! -f "generated/nes/NESSystem.v" ]; then
    echo "❌ 错误: Verilog 文件不存在"
    echo "请先运行: ./scripts/generate_verilog.sh"
    exit 1
fi

# 创建构建目录
mkdir -p build/verilator

echo "📦 运行 Verilator..."

# 获取绝对路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

verilator \
    --cc \
    --exe \
    --build \
    -O3 \
    --x-assign fast \
    --x-initial fast \
    --noassert \
    --trace \
    -Wno-WIDTH \
    -Wno-UNUSED \
    -Wno-UNDRIVEN \
    -Wno-CASEINCOMPLETE \
    --top-module NESSystem \
    -CFLAGS "$(pkg-config --cflags sdl2)" \
    -LDFLAGS "$(pkg-config --libs sdl2)" \
    -Mdir "$PROJECT_DIR/build/verilator" \
    "$PROJECT_DIR/generated/nes/NESSystem.v" \
    "$PROJECT_DIR/verilator/nes_testbench.cpp"

echo ""
echo "✅ 编译完成！"
echo ""
echo "可执行文件: build/verilator/VNESSystem"
echo ""
echo "运行仿真:"
echo "  ./scripts/verilator_run.sh <rom文件>"
