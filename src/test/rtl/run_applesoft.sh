#!/bin/bash
echo "==================================="
echo "6502 Hardware CPU - AppleSoft BASIC"
echo "==================================="
echo ""
echo "Using Verilator to simulate cpu_6502.sv"
echo ""

if [ ! -f obj_dir/Vapplesoft ]; then
    echo "Building..."
    make -f Makefile.applesoft
fi

echo "Running AppleSoft BASIC..."
echo ""
./obj_dir/Vapplesoft
