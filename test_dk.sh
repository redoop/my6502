#!/bin/bash
# Test Donkey Kong ROM execution

cd /Users/tongxiaojun/github/my6502/verilator

echo "=== Testing Donkey Kong ROM ==="
echo "Running for 3 seconds..."

timeout 3 ./obj_dir/Vnes_gui ../games/Donkey-Kong.nes 2>&1 | tee /tmp/dk_test.log

echo ""
echo "=== Test Results ==="
echo "Total writes: $(grep -c 'Total writes' /tmp/dk_test.log)"
echo "Frames rendered: $(grep 'Frame' /tmp/dk_test.log | tail -1)"
echo ""
echo "Last 20 lines:"
tail -20 /tmp/dk_test.log
