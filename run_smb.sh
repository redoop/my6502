#!/bin/bash
# Quick launcher for Super Mario Bros GUI

cd src/test/rtl

# Check if GUI is built
if [ ! -f obj_dir_gui/Vnes_system ]; then
    echo "Building GUI..."
    make smb_gui
fi

# Check if ROM exists
if [ ! -f ../../../games/Super-Mario-Bros.nes ]; then
    echo "Error: Super-Mario-Bros.nes not found in games/ directory"
    exit 1
fi

echo "Starting Super Mario Bros..."
echo ""
echo "Controls:"
echo "  Arrow Keys - D-Pad"
echo "  Z - B Button"
echo "  X - A Button"
echo "  Enter - START"
echo "  Right Shift - SELECT"
echo "  ESC - Quit"
echo ""

./obj_dir_gui/Vnes_system ../../../games/Super-Mario-Bros.nes
