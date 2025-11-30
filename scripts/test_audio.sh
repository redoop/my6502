#!/bin/bash
# Test NES APU audio output



# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
echo ""
echo "Testing audio with Super Mario Bros..."
echo "Listen for:"
echo "  - Background music"
echo "  - Jump sound effects"
echo "  - Coin collection sounds"
echo ""
echo "Press ESC to quit"
echo ""

cd "$PROJECT_ROOT/src/test/rtl"
./obj_dir_gui_mmc1/Vnes_system $PROJECT_ROOT/games/SuperMarioBros_mapper0.nes
