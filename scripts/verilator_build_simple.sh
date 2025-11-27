#!/bin/bash
# 编译简化版 Verilator 仿真器（不需要 SDL）

set -e

echo "🔨 编译简化版 Verilator 仿真器..."
echo ""

# 检查 Verilator 是否安装
if ! command -v verilator &> /dev/null; then
    echo "❌ 错误: Verilator 未安装"
    echo ""
    echo "安装方法:"
    echo "  Ubuntu/Debian: sudo apt-get install verilator"
    echo "  macOS: brew install verilator"
    exit 1
fi

# 检查 Verilog 文件是否存在
if [ ! -f "generated/nes/NESSystem.v" ]; then
    echo "❌ 错误: Verilog 文件不存在"
    echo "请先运行: ./scripts/generate_verilog.sh"
    exit 1
fi

# 创建构建目录
mkdir -p build/verilator_simple

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
    -Wno-WIDTH \
    -Wno-UNUSED \
    -Wno-UNDRIVEN \
    -Wno-CASEINCOMPLETE \
    --top-module NESSystem \
    -Mdir "$PROJECT_DIR/build/verilator_simple" \
    "$PROJECT_DIR/generated/nes/NESSystem.v" \
    "$PROJECT_DIR/verilator/nes_testbench_simple.cpp"

echo ""
echo "✅ 编译完成！"
echo ""
echo "可执行文件: build/verilator_simple/VNESSystem"
echo ""
echo "运行仿真:"
echo "  ./build/verilator_simple/VNESSystem <rom文件> [周期数]"
echo ""
echo "示例:"
echo "  ./build/verilator_simple/VNESSystem games/Super-Contra-X-\\(China\\)-\\(Pirate\\).nes 1000000"
