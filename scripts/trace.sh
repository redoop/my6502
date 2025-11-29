#!/bin/bash

# VCD 波形追踪脚本

ROM=${1:-games/Donkey-Kong.nes}
DURATION=${2:-1}  # 默认 1 秒

echo "📊 VCD 波形追踪"
echo "==============="
echo "ROM: $ROM"
echo "时长: ${DURATION}秒"
echo ""

# 构建 trace 版本
echo "🔨 构建 trace 版本..."
./scripts/build.sh trace > /dev/null 2>&1

# 运行并生成 VCD
echo "🎮 运行仿真..."
timeout $DURATION build/verilator/VNESSystemRefactored "$ROM" --trace --quiet

# 检查文件
if [ -f nes_trace.vcd ]; then
    SIZE=$(ls -lh nes_trace.vcd | awk '{print $5}')
    echo ""
    echo "✅ VCD 文件已生成: nes_trace.vcd ($SIZE)"
    echo ""
    echo "📈 使用 GTKWave 查看:"
    echo "   gtkwave nes_trace.vcd"
    echo ""
    echo "🔍 推荐查看的信号:"
    echo "   - TOP.io_debug_cpuPC (CPU 程序计数器)"
    echo "   - TOP.io_vblank (VBlank 标志)"
    echo "   - TOP.io_debug_nmi (NMI 信号)"
    echo "   - TOP.io_debug_ppuCtrl (PPU 控制寄存器)"
    echo "   - TOP.io_pixelX, TOP.io_pixelY (PPU 像素位置)"
else
    echo "❌ VCD 文件生成失败"
    exit 1
fi
