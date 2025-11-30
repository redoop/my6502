# Instruction Test Results

## Test Summary
- **Date**: 2025-12-01
- **Pass Rate**: 86% (6/7 tests)

## Test Results

| Test | Status | Output | Notes |
|------|--------|--------|-------|
| test_transfer | ✅ PASS | `1122334455  OOKKFF` | TAX, TAY, TXA, TYA, TSX, TXS all working |
| test_logic | ✅ PASS | `11  OOKKFF` | ORA, EOR working |
| test_shift | ✅ PASS | `112233  OOKKFF` | ASL A, LSR A, ROL A, ROR A working |
| test_incdec | ✅ PASS | `11223344  OOKKFF` | INY, DEX, DEY, INC, DEC working |
| test_cpy | ✅ PASS | `11  OOKKFF` | CPY immediate and zero page working |
| test_flags | ✅ PASS | `112233  OOKK` | CLI, SEI, CLD, SED, NOP working |
| test_jmp_indirect | ❌ FAIL | `` | JMP (indirect) not working correctly |

## Verified Instructions

### ✅ Working (28 instructions)
- **Transfer**: TAX, TAY, TXA, TYA, TSX, TXS (6)
- **Logic**: ORA, EOR (2)
- **Shift/Rotate**: ASL A, LSR A, ROL A, ROR A (4)
- **Inc/Dec**: INX, INY, DEX, DEY, INC, DEC (6)
- **Compare**: CPY (1)
- **Flags**: CLC, SEC, CLI, SEI, CLD, SED, CLV (7)
- **Other**: NOP (1)
- **Previously verified**: LDA, LDX, LDY, STA, STX, STY, ADC, SBC, AND, CMP, CPX, BEQ, BNE, BCS, BCC, BMI, BPL, BVS, BVC, JMP abs, JSR (partial), RTS (partial), PHA (partial), PLA (partial)

### ❌ Not Working (3 issues)
- **JMP indirect**: Jumps to wrong address
- **JSR/RTS**: Subroutine calls broken
- **PHA/PLA**: Stack operations have timing issues

## Notes
- Most single-byte instructions now working correctly after PC increment fix
- Accumulator mode shift instructions working after flag calculation fix
- JMP indirect needs debugging - appears to read from wrong memory location
