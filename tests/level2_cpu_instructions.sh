#!/bin/bash

# Level 2: CPU指令测试

cd "$(dirname "$0")/.."

echo "========================================"
echo "Level 2: CPU Instructions"
echo "========================================"

# 编译
if [ ! -f "src/test/rtl/obj_dir_gui/Vnes_system" ]; then
    echo "Compiling..."
    cd src/test/rtl
    verilator --cc -Wall -Wno-fatal --exe --top-module nes_system \
        -GMAPPER=0 -CFLAGS "$(pkg-config --cflags sdl2)" \
        -LDFLAGS "$(pkg-config --libs sdl2)" --Mdir obj_dir_gui --build \
        smb_gui_screenshot.cpp ../../main/rtl/*.sv > /dev/null 2>&1
    cd ../../..
fi

# 运行nestest ROM
echo "Running nestest ROM..."
timeout 10 src/test/rtl/obj_dir_gui/Vnes_system \
    games/nestest_mapper0.nes \
    /tmp/test.bmp > /tmp/level2_output.log 2>&1

# 测试
PASS=0
FAIL=0

test_pattern() {
    local name="$1"
    local pattern="$2"
    
    if grep -q "$pattern" /tmp/level2_output.log; then
        echo "✅ $name"
        PASS=$((PASS + 1))
    else
        echo "❌ $name"
        FAIL=$((FAIL + 1))
    fi
}

# 基础测试
test_pattern "CPU Executing" "PC="
test_pattern "Instructions Running" "PPUCTRL_WRITE"

# 检查是否有CPU错误
if grep -q "ERROR\|FAIL\|ILLEGAL" /tmp/level2_output.log; then
    echo "❌ CPU Errors Detected"
    FAIL=$((FAIL + 1))
else
    echo "✅ No CPU Errors"
    PASS=$((PASS + 1))
fi

# 检查隐含寻址指令 (DEY, INX等)
echo ""
echo "Testing Implied Addressing Instructions:"

# 运行简单的测试程序检查DEY
timeout 5 src/test/rtl/obj_dir_gui/Vnes_system \
    games/DonkeyKong_mapper0.nes \
    /tmp/test.bmp 2>&1 | grep "PC_TRACK" | head -100 > /tmp/dey_test.log

# 检查PC是否正常递增（不卡在循环）
PC_COUNT=$(grep "PC_TRACK" /tmp/dey_test.log | wc -l)
UNIQUE_PC=$(grep "PC_TRACK" /tmp/dey_test.log | awk '{print $4}' | sort -u | wc -l)

if [ "$UNIQUE_PC" -gt 50 ]; then
    echo "✅ DEY/Implied Instructions (PC progressing: $UNIQUE_PC unique addresses)"
    PASS=$((PASS + 1))
else
    echo "❌ DEY/Implied Instructions (PC stuck: only $UNIQUE_PC unique addresses)"
    FAIL=$((FAIL + 1))
fi

echo ""
echo "========================================"
echo "Summary: $PASS passed, $FAIL failed"
echo "========================================"

if [ "$FAIL" -eq 0 ]; then
    echo "✅ All tests passed!"
    exit 0
else
    echo "❌ Some tests failed"
    exit 1
fi
