#!/bin/bash
# Convert PPM files to PNG format

if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    echo "Example: $0 ../verilator/dk_output"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Error: Directory not found: $DIR"
    exit 1
fi

cd "$DIR" || exit 1

PPM_COUNT=$(ls -1 *.ppm 2>/dev/null | wc -l)
if [ "$PPM_COUNT" -eq 0 ]; then
    echo "No PPM files found in $DIR"
    exit 1
fi

echo "Converting $PPM_COUNT PPM files to PNG..."

for f in *.ppm; do
    png="${f%.ppm}.png"
    sips -s format png "$f" --out "$png" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✓ $png"
        rm "$f"  # Remove original PPM
    else
        echo "✗ Failed: $f"
    fi
done

echo "Done! Converted files in: $DIR"
