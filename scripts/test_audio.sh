#!/bin/bash
# Test NES APU audio output

echo "=== NES APU Audio Test ==="
echo ""
echo "Testing audio with Super Mario Bros..."
echo "Listen for:"
echo "  - Background music"
echo "  - Jump sound effects"
echo "  - Coin collection sounds"
echo ""
echo "Press ESC to quit"
echo ""

cd ../src/test/rtl
./obj_dir_gui_mmc1/Vnes_system ../games/SuperMarioBros_mapper0.nes
