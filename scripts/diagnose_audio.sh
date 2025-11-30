#!/bin/bash

echo "=== NES Audio Diagnostics ==="
echo ""

echo "1. Checking SDL2 installation..."
if command -v sdl2-config &> /dev/null; then
    echo "   ✓ SDL2 found: $(sdl2-config --version)"
else
    echo "   ✗ SDL2 not found"
fi

echo ""
echo "2. Checking audio devices..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    system_profiler SPAudioDataType | grep -A 5 "Output"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    aplay -l 2>/dev/null || echo "   Install alsa-utils to check devices"
fi

echo ""
echo "3. Running emulator with audio test..."
echo "   You should hear a 440Hz tone (musical note A)"
echo "   Press ESC to quit"
echo ""

cd ../src/test/rtl
timeout 30 ./obj_dir_gui_mmc1/Vnes_system ../games/SuperMarioBros_mapper0.nes 2>&1 | grep -E "(Audio|Frame 60)"
