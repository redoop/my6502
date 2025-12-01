#!/bin/bash
# Run Tiny BASIC in Interactive Mode

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Compiling Tiny BASIC..."
cd "$SCRIPT_DIR/basic/tinybasic"
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

cd "$SCRIPT_DIR/src/test/rtl"
./obj_dir_clean/Vclean "$SCRIPT_DIR/basic/tinybasic/tinybasic_adapted.bin"
