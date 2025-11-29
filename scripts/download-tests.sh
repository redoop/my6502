#!/bin/bash

# 下载 NES 测试 ROM

BASE_URL="https://github.com/christopherpow/nes-test-roms/raw/master"
TEST_DIR="test-roms"

echo "📦 下载 NES 测试 ROM"
echo "===================="
echo ""

# 创建目录
mkdir -p "$TEST_DIR"

# P0 - 必测 ROM
echo "🔴 P0 - 必测 ROM"
echo "----------------"

echo "1. nestest (CPU 完整测试)"
wget -q -O "$TEST_DIR/nestest.nes" "$BASE_URL/other/nestest.nes" && echo "   ✅ nestest.nes" || echo "   ❌ 下载失败"

echo "2. ppu_vbl_nmi (VBlank/NMI 测试)"
wget -q -O "$TEST_DIR/ppu_vbl_nmi.nes" "$BASE_URL/ppu_vbl_nmi/ppu_vbl_nmi.nes" && echo "   ✅ ppu_vbl_nmi.nes" || echo "   ❌ 下载失败"

echo "3. cpu_interrupts (中断测试)"
wget -q -O "$TEST_DIR/cpu_interrupts.nes" "$BASE_URL/cpu_interrupts_v2/cpu_interrupts.nes" && echo "   ✅ cpu_interrupts.nes" || echo "   ❌ 下载失败"

echo ""

# P1 - 推荐 ROM
echo "🟡 P1 - 推荐 ROM"
echo "----------------"

echo "4. vbl_nmi_timing (精确时序)"
wget -q -O "$TEST_DIR/vbl_nmi_timing.nes" "$BASE_URL/vbl_nmi_timing/vbl_nmi_timing.nes" && echo "   ✅ vbl_nmi_timing.nes" || echo "   ❌ 下载失败"

echo "5. ppu_read_buffer (PPU 读取)"
wget -q -O "$TEST_DIR/ppu_read_buffer.nes" "$BASE_URL/ppu_read_buffer/test_ppu_read_buffer.nes" && echo "   ✅ ppu_read_buffer.nes" || echo "   ❌ 下载失败"

echo "6. instr_timing (指令时序)"
wget -q -O "$TEST_DIR/instr_timing.nes" "$BASE_URL/instr_timing/instr_timing.nes" && echo "   ✅ instr_timing.nes" || echo "   ❌ 下载失败"

echo ""

# 下载 nestest 日志
echo "📄 下载参考日志"
echo "----------------"
wget -q -O "$TEST_DIR/nestest.log" "$BASE_URL/other/nestest.log" && echo "   ✅ nestest.log" || echo "   ❌ 下载失败"

echo ""
echo "✅ 下载完成！"
echo ""
echo "📊 测试 ROM 列表:"
ls -lh "$TEST_DIR"/*.nes 2>/dev/null | awk '{print "   " $9 " (" $5 ")"}'
echo ""
echo "🎮 运行测试:"
echo "   ./scripts/run.sh test-roms/nestest.nes"
echo "   ./scripts/run.sh test-roms/ppu_vbl_nmi.nes"
echo ""
echo "📖 查看文档:"
echo "   cat docs/research/TEST_ROM_GUIDE.md"
