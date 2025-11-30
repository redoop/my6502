#!/bin/bash
# Compile all test files

echo "=== Compiling 6502 Test Suite ==="

# Check if xa assembler is available
if ! command -v xa &> /dev/null; then
    echo "Error: xa assembler not found"
    echo "Install with: brew install xa"
    exit 1
fi

# Compile function
compile_test() {
    local asm_file=$1
    local bin_file="${asm_file%.asm}.bin"
    
    echo -n "Compiling $(basename $asm_file)... "
    if xa -o "$bin_file" "$asm_file" 2>/dev/null; then
        echo "✓"
        return 0
    else
        echo "✗"
        return 1
    fi
}

# Counters
total=0
passed=0

# Compile all .asm files
for asm in $(find . -name "*.asm" | sort); do
    total=$((total + 1))
    if compile_test "$asm"; then
        passed=$((passed + 1))
    fi
done

echo ""
echo "=== Results ==="
echo "Compiled: $passed/$total"

if [ $passed -eq $total ]; then
    echo "✓ All tests compiled successfully"
    exit 0
else
    echo "✗ Some tests failed to compile"
    exit 1
fi
