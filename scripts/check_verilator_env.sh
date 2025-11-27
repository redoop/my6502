#!/bin/bash
# 检查 Verilator 仿真环境

echo "🔍 检查 Verilator 仿真环境"
echo "=========================="
echo ""

ALL_OK=true

# 检查 Verilator
echo -n "检查 Verilator... "
if command -v verilator &> /dev/null; then
    VERSION=$(verilator --version | head -n1)
    echo "✅ $VERSION"
else
    echo "❌ 未安装"
    echo "   安装: sudo apt-get install verilator (Linux)"
    echo "         brew install verilator (macOS)"
    ALL_OK=false
fi

# 检查 C++ 编译器
echo -n "检查 C++ 编译器... "
if command -v g++ &> /dev/null; then
    VERSION=$(g++ --version | head -n1)
    echo "✅ $VERSION"
elif command -v clang++ &> /dev/null; then
    VERSION=$(clang++ --version | head -n1)
    echo "✅ $VERSION"
else
    echo "❌ 未安装"
    echo "   安装: sudo apt-get install build-essential (Linux)"
    echo "         xcode-select --install (macOS)"
    ALL_OK=false
fi

# 检查 SBT
echo -n "检查 SBT... "
if command -v sbt &> /dev/null; then
    echo "✅ 已安装"
else
    echo "❌ 未安装"
    echo "   需要用于生成 Verilog"
    ALL_OK=false
fi

# 检查 SDL2 (可选)
echo -n "检查 SDL2 (可选)... "
if pkg-config --exists sdl2 2>/dev/null; then
    VERSION=$(pkg-config --modversion sdl2)
    echo "✅ $VERSION"
    echo "   可以使用完整版 GUI"
else
    echo "⚠️  未安装"
    echo "   只能使用简化版（无 GUI）"
    echo "   安装: sudo apt-get install libsdl2-dev (Linux)"
    echo "         brew install sdl2 (macOS)"
fi

echo ""
echo "文件检查"
echo "--------"

# 检查 Verilog 文件
echo -n "Verilog 文件... "
if [ -f "generated/nes/NESSystem.v" ]; then
    SIZE=$(wc -l < generated/nes/NESSystem.v)
    echo "✅ 已生成 ($SIZE 行)"
else
    echo "⚠️  未生成"
    echo "   运行: ./scripts/generate_verilog.sh"
fi

# 检查 testbench
echo -n "Testbench 文件... "
if [ -f "verilator/nes_testbench_simple.cpp" ]; then
    echo "✅ 存在"
else
    echo "❌ 缺失"
    ALL_OK=false
fi

# 检查编译产物
echo -n "编译的仿真器... "
if [ -f "build/verilator_simple/VNESSystem" ]; then
    echo "✅ 已编译（简化版）"
elif [ -f "build/verilator/VNESSystem" ]; then
    echo "✅ 已编译（完整版）"
else
    echo "⚠️  未编译"
    echo "   运行: ./scripts/verilator_build_simple.sh"
fi

echo ""
echo "ROM 文件"
echo "--------"
if [ -d "games" ]; then
    ROM_COUNT=$(find games -name "*.nes" | wc -l)
    echo "找到 $ROM_COUNT 个 ROM 文件:"
    find games -name "*.nes" -exec basename {} \; | head -5
    if [ $ROM_COUNT -gt 5 ]; then
        echo "..."
    fi
else
    echo "⚠️  games 目录不存在"
fi

echo ""
echo "总结"
echo "----"
if [ "$ALL_OK" = true ]; then
    echo "✅ 环境检查通过！"
    echo ""
    echo "下一步:"
    echo "  1. 生成 Verilog: ./scripts/generate_verilog.sh"
    echo "  2. 编译仿真器: ./scripts/verilator_build_simple.sh"
    echo "  3. 运行仿真: ./run_verilator.sh games/your-rom.nes"
else
    echo "❌ 环境不完整，请安装缺失的组件"
fi
