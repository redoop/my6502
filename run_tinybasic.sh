#!/bin/bash
# Run Tiny BASIC

cd basic
echo "Compiling Tiny BASIC..."
xa -o tinybasic_final.bin tinybasic_final.asm

if [ $? -eq 0 ]; then
    echo "Running Tiny BASIC..."
    cd ../src/test/rtl
    timeout 1 obj_dir/Vcpu_6502 ../../../basic/tinybasic_final.bin 2>&1 | grep -E "(Output:|PASS|FAIL)"
else
    echo "Compilation failed"
    exit 1
fi
