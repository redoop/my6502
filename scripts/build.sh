#!/bin/bash
# 统一构建脚本 - 编译 Verilog 和 Verilator 仿真器

set -e

MODE="${1:-normal}"  # normal, fast, trace, optimized

echo "🔨 构建 NES 系统"
echo "模式: $MODE"
echo ""

# 检查依赖
check_deps() {
    local missing=0
    
    if ! command -v verilator &> /dev/null; then
        echo "❌ Verilator 未安装"
        missing=1
    fi
    
    if ! command -v sbt &> /dev/null; then
        echo "❌ sbt 未安装"
        missing=1
    fi
    
    if ! pkg-config --exists sdl2; then
        echo "❌ SDL2 未安装"
        missing=1
    fi
    
    if [ $missing -eq 1 ]; then
        echo ""
        echo "安装方法 (macOS): brew install verilator sbt sdl2"
        exit 1
    fi
}

check_deps

# 生成 Verilog
echo "📝 生成 Verilog..."
sbt "runMain nes.GenerateNESVerilog" 2>&1 | grep -E "(Generating|generated|success|Total time)" || true

if [ ! -f "generated/nes/NESSystem.v" ]; then
    echo "❌ Verilog 生成失败"
    exit 1
fi

# 设置编译选项
VERILATOR_FLAGS="--cc --exe --build -Wno-WIDTH -Wno-UNUSED -Wno-UNDRIVEN -Wno-CASEINCOMPLETE"
VERILATOR_FLAGS="$VERILATOR_FLAGS -Wno-UNOPTFLAT"  # Ignore combinational loop warnings
VERILATOR_FLAGS="$VERILATOR_FLAGS --converge-limit 10000"  # Increase convergence limit for MMC3
VERILATOR_FLAGS="$VERILATOR_FLAGS --top-module NESSystemRefactored"

case "$MODE" in
    fast)
        VERILATOR_FLAGS="$VERILATOR_FLAGS -O3 --x-assign fast --x-initial fast --noassert"
        ;;
    trace)
        VERILATOR_FLAGS="$VERILATOR_FLAGS --trace -O2"
        ;;
    optimized)
        VERILATOR_FLAGS="$VERILATOR_FLAGS -O3 --x-assign fast --x-initial fast --noassert --trace"
        ;;
    *)
        VERILATOR_FLAGS="$VERILATOR_FLAGS -O2"
        ;;
esac

# 编译
echo "📦 编译 Verilator..."
mkdir -p build/verilator

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

verilator $VERILATOR_FLAGS \
    -CFLAGS "$(pkg-config --cflags sdl2)" \
    -LDFLAGS "$(pkg-config --libs sdl2)" \
    -Mdir "$PROJECT_DIR/build/verilator" \
    "$PROJECT_DIR/generated/nes/NESSystem.v" \
    "$PROJECT_DIR/verilator/testbench_main.cpp"

echo ""
echo "✅ 构建完成！"
echo "可执行文件: build/verilator/VNESSystemRefactored"
