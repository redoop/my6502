#!/bin/bash
# Verify all scripts have correct paths

echo "=== Verifying Scripts ==="
echo ""

cd "$(dirname "$0")"
PROJECT_ROOT="$(cd .. && pwd)"

errors=0

# Check each script
for script in *.sh; do
    if [ "$script" = "verify_scripts.sh" ]; then
        continue
    fi
    
    echo -n "Checking $script... "
    
    # Extract ROM paths (relative to src/test/rtl/)
    roms=$(grep -o '\.\./\.\./\.\./games/[^"]*\.nes' "$script" 2>/dev/null)
    
    if [ -n "$roms" ]; then
        all_exist=true
        while IFS= read -r rom; do
            # Convert to absolute path: ../../../games/ from src/test/rtl/ = PROJECT_ROOT/games/
            rom_file=$(basename "$rom")
            rom_path="$PROJECT_ROOT/games/$rom_file"
            if [ ! -f "$rom_path" ]; then
                echo "FAIL - ROM not found: $rom_path"
                errors=$((errors + 1))
                all_exist=false
                break
            fi
        done <<< "$roms"
        
        if [ "$all_exist" = true ]; then
            echo "OK"
        fi
    else
        echo "SKIP (no ROM paths)"
    fi
done

echo ""
if [ $errors -eq 0 ]; then
    echo "✓ All scripts verified successfully"
else
    echo "✗ Found $errors error(s)"
    exit 1
fi
