#!/bin/bash

echo "========================================="
echo "  ROM Files Verification"
echo "========================================="
echo ""

cd games

echo "Checking ROM files..."
echo ""

for rom in *_mapper*.nes; do
    if [ -f "$rom" ]; then
        python3 << EOF
import os
with open('$rom', 'rb') as f:
    header = f.read(16)
    if header[:4] == b'NES\x1a':
        mapper = ((header[6] >> 4) & 0x0F) | (header[7] & 0xF0)
        prg = header[4] * 16
        chr = header[5] * 8
        size = os.path.getsize('$rom') // 1024
        expected_mapper = '$rom'.split('_mapper')[1].split('.')[0]
        status = '✅' if str(mapper) == expected_mapper else '❌'
        print(f"{status} $rom")
        print(f"   Mapper: {mapper} (expected: {expected_mapper})")
        print(f"   PRG: {prg}KB, CHR: {chr}KB, Size: {size}KB")
        print()
EOF
    fi
done

echo "========================================="
echo "  Launch Scripts"
echo "========================================="
echo ""
cd ..
ls -1 run_*.sh | while read script; do
    echo "✅ $script"
done

echo ""
echo "========================================="
echo "  Quick Start"
echo "========================================="
echo ""
echo "Run games:"
echo "  ./run_zelda.sh         - The Legend of Zelda (Mapper 1) ⭐"
echo "  ./run_smb.sh           - Super Mario Bros 3 (Mapper 4)"
echo "  ./run_smb_mmc1.sh      - Super Mario Bros (Mapper 0)"
echo "  ./run_donkeykong.sh    - Donkey Kong (Mapper 0)"
echo ""
