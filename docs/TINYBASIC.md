# Tiny BASIC for my6502

## Overview

A minimal BASIC interpreter implementation for the my6502 emulator, demonstrating the capability to run high-level language programs on the 6502 CPU.

## Features

### Current Implementation (v1.0)
- ✅ Basic program execution
- ✅ Character output via memory-mapped I/O ($F000)
- ✅ Simple test programs
- ✅ Verified working on my6502 emulator

### Planned Features
- 🔄 Interactive command prompt
- 🔄 PRINT command with string and number support
- 🔄 LET command for variable assignment
- 🔄 IF/THEN conditional execution
- 🔄 GOTO for program flow control
- 🔄 INPUT for user input
- 🔄 LIST to display program
- 🔄 RUN to execute stored program
- 🔄 NEW to clear program

## Files

- `tinybasic_final.asm` - Working minimal BASIC (outputs "BASIC OK")
- `tinybasic_complete.asm` - Full interpreter (in development)
- `tinybasic_simple.asm` - Simple test version
- `tinybasic_test.asm` - Unit test version

## Quick Start

### Run Tiny BASIC
```bash
./run_tinybasic.sh
```

### Compile Manually
```bash
cd basic
xa -o tinybasic_final.bin tinybasic_final.asm
```

### Test
```bash
cd src/test/rtl
./obj_dir/Vcpu_6502 ../../../basic/tinybasic_final.bin
```

## Memory Map

| Address Range | Purpose |
|--------------|---------|
| $0200-$03FF | BASIC interpreter code |
| $0400-$07FF | Program storage |
| $0800-$08FF | Variables (A-Z) |
| $F000 | Output port (OUTCH) |
| $F001 | Input port (INCH) |

## Architecture

### I/O System
- Memory-mapped I/O at $F000 (output) and $F001 (input)
- Compatible with my6502 test harness
- Character-based output

### Program Structure
```
START:
    Initialize stack
    Print banner
    Execute program
    Halt
```

## Test Results

```
✓ PASS - Basic output test
✓ PASS - Character output
✓ PASS - Program execution
```

## Example Programs

### Hello World
```assembly
LDA #'H'
STA OUTCH
LDA #'I'
STA OUTCH
```

### Current Test Program
```
Output: "BASIC OK"
Status: ✓ PASS
```

## Development Status

- **Phase 1**: Basic output ✅ COMPLETE
- **Phase 2**: Command parser 🔄 IN PROGRESS
- **Phase 3**: Variable storage 📋 PLANNED
- **Phase 4**: Program execution 📋 PLANNED
- **Phase 5**: Interactive mode 📋 PLANNED

## Technical Details

### CPU Requirements
- 6502 processor
- Stack at $0100-$01FF
- Reset vector at $FFFC

### Code Size
- Minimal version: ~50 bytes
- Complete version: ~2KB (planned)

## Future Enhancements

1. **Expression Evaluator**: Support for arithmetic expressions
2. **FOR/NEXT Loops**: Iteration support
3. **Arrays**: Simple array support
4. **Functions**: Built-in functions (ABS, RND, etc.)
5. **File I/O**: Save/load programs

## References

- Based on Tom Pitman's Tiny BASIC design
- Adapted for my6502 architecture
- Compatible with 6502 instruction set

## License

Educational project - see main README for details.
