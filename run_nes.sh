#!/bin/bash
# NES Emulator Quick Start Script

cd "$(dirname "$0")"

# Build if needed
if [ ! -f "verilator/obj_dir/Vnes_gui" ]; then
    echo "Building NES emulator..."
    cd verilator
    make -f Makefile.gui clean
    make -f Makefile.gui
    cd ..
fi

# Run with specified ROM or default
ROM="${1:-games/Donkey-Kong.nes}"

if [ ! -f "$ROM" ]; then
    echo "Error: ROM file not found: $ROM"
    echo "Usage: $0 [rom_file]"
    echo "Available ROMs:"
    ls -1 games/*.nes 2>/dev/null || echo "  No ROMs found in games/"
    exit 1
fi

echo "Running: $ROM"
./verilator/obj_dir/Vnes_gui "$ROM"
