#!/bin/bash
# NES Verilator 仿真 - 一键运行脚本

set -e

echo "🚀 NES Verilator 仿真流程"
echo "=========================="
echo ""

# 检查参数
if [ $# -lt 1 ]; then
    echo "用法: $0 <rom文件> [模式]"
    echo ""
    echo "模式:"
    echo "  simple  - 简化版（无 GUI，快速测试）"
    echo "  full    - 完整版（带 SDL GUI）"
    echo ""
    echo "默认: simple"
    exit 1
fi

ROM_FILE="$1"
MODE="${2:-simple}"

if [ ! -f "$ROM_FILE" ]; then
    echo "❌ 错误: ROM 文件不存在: $ROM_FILE"
    exit 1
fi

# 步骤 1: 生成 Verilog
echo "步骤 1/3: 生成 Verilog"
echo "----------------------"
if [ ! -f "generated/nes/NESSystem.v" ]; then
    ./scripts/generate_verilog.sh
else
    echo "✅ Verilog 已存在，跳过生成"
fi
echo ""

# 步骤 2: 编译仿真器
echo "步骤 2/3: 编译 Verilator 仿真器"
echo "-------------------------------"
if [ "$MODE" = "full" ]; then
    if [ ! -f "build/verilator/VNESSystem" ]; then
        ./scripts/verilator_build.sh
    else
        echo "✅ 仿真器已编译，跳过"
    fi
else
    if [ ! -f "build/verilator_simple/VNESSystem" ]; then
        ./scripts/verilator_build_simple.sh
    else
        echo "✅ 仿真器已编译，跳过"
    fi
fi
echo ""

# 步骤 3: 运行仿真
echo "步骤 3/3: 运行仿真"
echo "------------------"
if [ "$MODE" = "full" ]; then
    ./scripts/verilator_run.sh "$ROM_FILE"
else
    ./build/verilator_simple/VNESSystem "$ROM_FILE" 1000000
fi
