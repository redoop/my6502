#!/bin/bash
# 测试 Reset 序列

echo "🧪 测试 CPU Reset 序列"
echo "======================="
echo ""

# 生成 Verilog
echo "📝 生成 Verilog..."
./scripts/generate_verilog.sh > /dev/null 2>&1

# 编译 trace 版本
echo "🔨 编译 trace 版本..."
./scripts/verilator_build_trace.sh > /dev/null 2>&1

# 运行短时间仿真
echo "🎮 运行仿真 (1000 周期)..."
./build/verilator_trace/VNESSystem games/Donkey-Kong.nes 1000 2>&1 | grep -v "Warning:"

# 分析 VCD
echo ""
echo "📊 分析 VCD 波形..."
python3 scripts/analyze_vcd.py nes_trace.vcd 2>&1 | head -50

echo ""
echo "✅ 测试完成"
