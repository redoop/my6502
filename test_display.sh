#!/bin/bash
cd "$(dirname "$0")"
echo "Testing NES display..."
timeout 3 ./verilator/obj_dir/Vnes_gui games/Donkey-Kong.nes &
sleep 2
echo "Window should be visible. Press Ctrl+C to stop."
wait
