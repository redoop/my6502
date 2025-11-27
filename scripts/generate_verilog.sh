#!/bin/bash
# 生成 NES 系统的 Verilog 代码

set -e

echo "🔧 生成 Verilog 代码..."
echo ""

# 清理旧的生成文件
rm -rf generated/nes_verilator
mkdir -p generated/nes_verilator

# 使用 sbt 生成 Verilog
sbt "runMain nes.GenerateNESVerilog"

echo ""
echo "✅ Verilog 生成完成！"
echo ""
echo "生成的文件位于: generated/nes/"
echo ""
echo "下一步："
echo "  1. 运行 ./scripts/verilator_build.sh 编译仿真器"
echo "  2. 运行 ./scripts/verilator_run.sh <rom文件> 运行仿真"
