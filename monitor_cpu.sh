#!/bin/bash
# Monitor CPU execution in detail

cd /Users/tongxiaojun/github/my6502

# Rebuild with more debug output
echo "=== Rebuilding with debug ==="
cd verilator
make -f Makefile.gui clean > /dev/null 2>&1

# Add debug flag
export VERILATOR_FLAGS="-DDEBUG_CPU"

echo "=== Running Donkey Kong for 5 seconds ==="
timeout 5 ./obj_dir/Vnes_gui ../games/Donkey-Kong.nes 2>&1 | tee /tmp/dk_detailed.log

echo ""
echo "=== Analysis ==="
echo "Total output lines: $(wc -l < /tmp/dk_detailed.log)"
echo "Write operations: $(grep -c 'writes:' /tmp/dk_detailed.log)"
echo "Frames: $(grep 'Frame' /tmp/dk_detailed.log | tail -1)"
echo ""
echo "Checking for PPU writes..."
grep -i "ppu\|2000\|2001" /tmp/dk_detailed.log | head -5
echo ""
echo "Last 10 lines:"
tail -10 /tmp/dk_detailed.log
