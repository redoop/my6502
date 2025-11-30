#!/bin/bash

cd ../src/test/rtl

echo "========================================="
echo "  Super Mario Bros (Mapper 0 - NROM)"
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
echo "Note: Using Mapper 0 (NROM) build"
echo "========================================="
echo ""

make gui_smb_mmc1
