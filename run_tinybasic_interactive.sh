#!/bin/bash
# Run Tiny BASIC in Interactive Mode

echo "Compiling Tiny BASIC..."
cd basic/tinybasic
xa -o tinybasic_adapted.bin tinybasic_adapted.asm

if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

echo ""
echo "======================================"
echo "  Tiny BASIC Interactive Mode"
echo "======================================"
echo ""
echo "Commands:"
echo "  LIST - List program"
echo "  RUN  - Run program"
echo "  NEW  - Clear program"
echo ""
echo "Press Ctrl+C to exit"
echo ""
echo "======================================"
echo ""

cd ../../src/test/rtl
./obj_dir_clean/Vclean ../../../basic/tinybasic/tinybasic_adapted.bin
