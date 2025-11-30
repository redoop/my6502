# 6502 CPU Instruction Implementation Checklist

## Current Status: 94/151 (62.3%)

## Priority 1: Critical for Games (15 instructions)

### BIT - Bit Test
- [ ] $24 BIT zp
- [ ] $2C BIT abs

### INC/DEC - Memory Increment/Decrement  
- [ ] $E6 INC zp
- [ ] $F6 INC zp,X
- [ ] $EE INC abs
- [ ] $FE INC abs,X
- [ ] $C6 DEC zp
- [ ] $D6 DEC zp,X
- [ ] $CE DEC abs
- [ ] $DE DEC abs,X

### ROL/ROR - Rotate (most critical)
- [ ] $26 ROL zp
- [ ] $36 ROL zp,X
- [ ] $2E ROL abs
- [ ] $3E ROL abs,X
- [ ] $66 ROR zp

## Priority 2: Common Operations (20 instructions)

### AND - Logical AND
- [ ] $25 AND zp
- [ ] $35 AND zp,X
- [ ] $2D AND abs
- [ ] $3D AND abs,X
- [ ] $39 AND abs,Y

### ORA - Logical OR
- [ ] $05 ORA zp
- [ ] $15 ORA zp,X
- [ ] $0D ORA abs
- [ ] $1D ORA abs,X
- [ ] $19 ORA abs,Y

### EOR - Exclusive OR
- [ ] $45 EOR zp
- [ ] $55 EOR zp,X
- [ ] $4D EOR abs
- [ ] $5D EOR abs,X
- [ ] $59 EOR abs,Y

### LSR - Logical Shift Right
- [ ] $46 LSR zp
- [ ] $56 LSR zp,X
- [ ] $4E LSR abs
- [ ] $5E LSR abs,X

## Priority 3: Addressing Modes (22 instructions)

### Indirect Addressing
- [ ] $61 ADC (ind,X)
- [ ] $71 ADC (ind),Y
- [ ] $21 AND (ind,X)
- [ ] $31 AND (ind),Y
- [ ] $C1 CMP (ind,X)
- [ ] $D1 CMP (ind),Y
- [ ] $41 EOR (ind,X)
- [ ] $51 EOR (ind),Y
- [ ] $11 ORA (ind,X)
- [ ] $19 ORA (ind),Y
- [ ] $E1 SBC (ind,X)
- [ ] $F1 SBC (ind),Y

### Load/Store Variants
- [ ] $AC LDY abs
- [ ] $BC LDY abs,X
- [ ] $BE LDX abs,Y
- [ ] $99 STA abs,Y

### Compare Variants
- [ ] $C1 CMP (ind,X)
- [ ] $D1 CMP (ind),Y
- [ ] $D5 CMP zp,X
- [ ] $CD CMP abs
- [ ] $DD CMP abs,X
- [ ] $D9 CMP abs,Y
- [ ] $E4 CPX zp
- [ ] $EC CPX abs
- [ ] $CC CPY abs

## Implementation Template

```systemverilog
// In EXECUTE state
8'hXX: begin  // INSTRUCTION_NAME addressing_mode
    // Set address for memory access
    addr <= address_calculation;
    rw <= 1;  // or 0 for write
    PC <= PC + bytes;
    cycle_count <= cycles_needed;
end

// In MEMORY state (if needed)
if (opcode == 8'hXX) begin
    // Perform operation
    result <= operation;
    // Set flags
    Z <= (result == 0);
    N <= result[7];
    rw <= 1;
end
```

## Test Template

```systemverilog
// Test INSTRUCTION
mem[16'h8000] = 8'hXX;  // Opcode
mem[16'h8001] = 8'hYY;  // Operand
// Setup
A = initial_value;
// Execute
#cycles;
// Verify
assert(A == expected);
assert(Z == expected_z);
assert(N == expected_n);
```

## Progress Tracking

- [ ] Priority 1: 0/15 (0%)
- [ ] Priority 2: 0/20 (0%)
- [ ] Priority 3: 0/22 (0%)
- [ ] Total: 94/151 → 151/151 (100%)
