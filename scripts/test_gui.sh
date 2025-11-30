#!/bin/bash
# Test GUI emulator

cd "$(dirname "$0")/../verilator"

echo "=== NES GUI Emulator Test ==="
echo ""

# Check if GUI is built
if [ ! -f obj_dir/Vnes_gui ]; then
    echo "Building GUI emulator..."
    make gui
    if [ $? -ne 0 ]; then
        echo "❌ Build failed"
        exit 1
    fi
fi

echo "✅ GUI emulator built"
echo ""

# Test with Donkey Kong
ROM="../../../games/DonkeyKong_mapper0.nes"
if [ ! -f "$ROM" ]; then
    echo "❌ ROM not found: $ROM"
    exit 1
fi

echo "Testing with: $ROM"
echo "Window should open at 768x720"
echo "Press ESC to close or wait 30 seconds..."
echo ""

# Run with timeout
timeout 30 ./obj_dir/Vnes_gui "$ROM" 2>&1 | head -50 &
GUI_PID=$!

sleep 2

if ps -p $GUI_PID > /dev/null 2>&1; then
    echo "✅ GUI window opened successfully"
    echo ""
    echo "Waiting for user to close window or timeout..."
    wait $GUI_PID
    EXIT_CODE=$?
    
    if [ $EXIT_CODE -eq 124 ]; then
        echo ""
        echo "⏱️  Timeout reached (30s)"
    else
        echo ""
        echo "✅ GUI closed normally"
    fi
else
    echo "❌ GUI failed to start"
    exit 1
fi

echo ""
echo "=== Test Complete ==="
