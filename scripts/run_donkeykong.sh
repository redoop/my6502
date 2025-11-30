#!/bin/bash

cd "$PROJECT_ROOT/src/test/rtl"


# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
echo "========================================="
echo "  Donkey Kong (Mapper 0 - NROM)"
echo "========================================="
echo ""
echo "Controls:"
echo "  Arrow Keys - D-Pad"
echo "  Z          - B Button"
echo "  X          - A Button"
echo "  Enter      - START"
echo "  Right Shift- SELECT"
echo "  ESC        - Quit"
echo ""
echo "========================================="
echo ""

# Build if needed
if [ ! -f obj_dir_gui_mmc1/Vnes_system ]; then
    make smb_gui_mmc1
fi

./obj_dir_gui_mmc1/Vnes_system $PROJECT_ROOT/games/DonkeyKong_mapper0.nes
