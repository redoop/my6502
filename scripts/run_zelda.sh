#!/bin/bash

cd ../src/test/rtl

echo "========================================="
echo "  The Legend of Zelda (Mapper 1 - MMC1)"
echo "========================================="
echo ""
echo "Controls:"
echo "  Arrow Keys - D-Pad"
echo "  Z          - B Button (Sword)"
echo "  X          - A Button"
echo "  Enter      - START"
echo "  Right Shift- SELECT"
echo "  ESC        - Quit"
echo ""
echo "⭐ First Mapper 1 (MMC1) game!"
echo "========================================="
echo ""

# Build if needed
if [ ! -f obj_dir_gui_mmc1/Vnes_system ]; then
    make smb_gui_mmc1
fi

./obj_dir_gui_mmc1/Vnes_system ../games/Zelda_mapper1.nes
