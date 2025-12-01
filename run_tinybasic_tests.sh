#!/bin/bash
# Tiny BASIC TDD Migration Test Runner

PHASES=(1 2 3 4 5 6 7 8 9 10)
PASS=0
FAIL=0
TOTAL=0

echo "======================================"
echo "Tiny BASIC Migration Tests"
echo "======================================"
echo

for phase in "${PHASES[@]}"; do
    echo "=== Phase $phase ==="
    
    test_dir="basic/tinybasic/tests/phase$phase"
    if [ ! -d "$test_dir" ]; then
        echo "  ⚠️  No tests found"
        continue
    fi
    
    for test in "$test_dir"/*.asm; do
        [ -f "$test" ] || continue
        
        name=$(basename "$test" .asm)
        ((TOTAL++))
        
        # Compile
        xa -o "/tmp/$name.bin" "$test" 2>/dev/null
        if [ $? -ne 0 ]; then
            echo "  ❌ $name (compile failed)"
            ((FAIL++))
            continue
        fi
        
        # Run test
        result=$(timeout 2 src/test/rtl/obj_dir/Vcpu_6502 "/tmp/$name.bin" 2>&1 | grep "Output:")
        
        if echo "$result" | grep -q "OK"; then
            echo "  ✅ $name"
            ((PASS++))
        else
            echo "  ❌ $name"
            echo "     Output: $result"
            ((FAIL++))
        fi
    done
    echo
done

echo "======================================"
echo "Results: $PASS passed, $FAIL failed, $TOTAL total"
echo "======================================"

if [ $FAIL -eq 0 ]; then
    exit 0
else
    exit 1
fi
