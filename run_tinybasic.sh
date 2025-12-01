#!/bin/bash
# Run Tiny BASIC Interactive

echo "Compiling Tiny BASIC..."
cd basic/tinybasic
xa -o tinybasic_adapted.bin tinybasic_adapted.asm

if [ $? -eq 0 ]; then
    echo "Starting Tiny BASIC..."
    echo "Commands: LIST, RUN, NEW"
    echo "Press Ctrl+C to exit"
    echo ""
    cd ../../src/test/rtl
    ./obj_dir/Vcpu_6502 ../../../basic/tinybasic/tinybasic_adapted.bin
else
    echo "Compilation failed"
    exit 1
fi
