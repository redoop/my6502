#!/bin/bash
# 测试 PPU 渲染

echo "🎨 测试 PPU 渲染"
echo "================="

# 生成 Verilog
echo "📝 生成 Verilog..."
./scripts/generate_verilog.sh > /dev/null 2>&1

# 编译
echo "🔨 编译..."
./scripts/verilator_build.sh > /dev/null 2>&1

# 运行短时间测试
echo "🎮 运行测试..."
timeout 5 ./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | grep -E "非零像素|PPUCTRL|PPUMASK|调试信息" | tail -20

echo ""
echo "✅ 测试完成"
