#!/bin/bash
cd "$(dirname "$0")"
RUNNER="../../src/test/rtl/obj_dir/Vcpu_6502"

echo "==================================="
echo "Foundation Test Suite (Dependency-Based)"
echo "==================================="
echo

for level in 1 2 3 4; do
    test_file="00_foundation/test_level${level}_*.bin"
    if ls $test_file 1> /dev/null 2>&1; then
        echo "Level $level: $(ls $test_file | xargs basename)"
        timeout 5 $RUNNER $test_file 2>&1 | grep -E "(Output:|PASS|FAIL)" | head -2
        echo
    fi
done

echo "==================================="
echo "Summary"
echo "==================================="
