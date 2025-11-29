#!/bin/bash
# 编译带波形追踪的 Verilator 仿真器

set -e

echo "🔨 编译波形追踪版 Verilator 仿真器..."
echo ""

# 检查 Verilator
if ! command -v verilator &> /dev/null; then
    echo "❌ 错误: Verilator 未安装"
    exit 1
fi

# 检查 Verilog 文件
if [ ! -f "generated/nes/NESSystem.v" ]; then
    echo "❌ 错误: Verilog 文件不存在"
    echo "请先运行: ./scripts/generate_verilog.sh"
    exit 1
fi

# 创建构建目录
mkdir -p build/verilator_trace

echo "📦 运行 Verilator (启用波形追踪)..."

# 获取绝对路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

verilator \
    --cc \
    --exe \
    --build \
    --trace \
    -O3 \
    --x-assign fast \
    --x-initial fast \
    --noassert \
    -Wno-WIDTH \
    -Wno-UNUSED \
    -Wno-UNDRIVEN \
    -Wno-CASEINCOMPLETE \
    --top-module NESSystem \
    -Mdir "$PROJECT_DIR/build/verilator_trace" \
    "$PROJECT_DIR/generated/nes/NESSystem.v" \
    "$PROJECT_DIR/verilator/nes_testbench_trace.cpp"

echo ""
echo "✅ 编译完成！"
echo ""
echo "可执行文件: build/verilator_trace/VNESSystem"
echo ""
echo "运行仿真:"
echo "  ./build/verilator_trace/VNESSystem <rom文件> [周期数]"
echo ""
echo "注意:"
echo "  - 波形文件会很大，建议周期数不超过 100000"
echo "  - 生成的波形文件: nes_trace.vcd"
echo "  - 使用 GTKWave 查看: gtkwave nes_trace.vcd"
