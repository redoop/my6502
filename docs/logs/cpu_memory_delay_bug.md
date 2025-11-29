# CPU Memory Delay Bug Analysis

**Date**: 2025-11-30  
**Status**: Critical - CPU reads wrong opcodes

## Bug Summary

The CPU is reading incorrect opcodes from memory, causing execution to fail with illegal instructions.

## Evidence

```
[Cycle 120000] PC=0xE7E8 Opcode=0x07 (illegal)
```

ROM at 0xE7E8 actually contains: `0xC8` (INY - valid instruction)

## Root Cause

**Memory read has 1-cycle delay**, but Fetch state doesn't account for it properly.

### Current Fetch State (BROKEN)
```scala
is(sFetch) {
  when(cycle === 0.U) {
    io.memAddr := regs.pc      // Set address
    io.memRead := true.B
    cycle := 1.U
  }.otherwise {  // cycle === 1
    opcode := io.memDataIn     // Read data SAME cycle as address change
    regs.pc := regs.pc + 1.U
    cycle := 0.U
    state := sExecute
  }
}
```

### Reset State (WORKING)
```scala
is(sReset) {
  when(cycle === 0.U) {
    io.memAddr := 0xFFFC.U
    io.memRead := true.B
    cycle := 1.U
  }.elsewhen(cycle === 1.U) {
    io.memAddr := 0xFFFC.U     // Keep address stable
    io.memRead := true.B
    cycle := 2.U
  }.elsewhen(cycle === 2.U) {
    operand := io.memDataIn    // Read data NEXT cycle
    cycle := 3.U
  }
  // ... continues
}
```

## Why Reset Works But Fetch Doesn't

Reset uses **3 cycles per byte**:
- Cycle 0: Set address
- Cycle 1: Wait (address stable)
- Cycle 2: Read data

Fetch uses **2 cycles**:
- Cycle 0: Set address
- Cycle 1: Read data (TOO EARLY!)

## Fix Required

Change Fetch to use 3-cycle pattern like Reset:

```scala
is(sFetch) {
  when(nmiPending) {
    cycle := 0.U
    state := sNMI
  }.otherwise {
    when(cycle === 0.U) {
      io.memAddr := regs.pc
      io.memRead := true.B
      cycle := 1.U
    }.elsewhen(cycle === 1.U) {
      // Wait cycle - keep address stable
      io.memAddr := regs.pc
      io.memRead := true.B
      cycle := 2.U
    }.otherwise {  // cycle === 2
      // Now read data
      opcode := io.memDataIn
      regs.pc := regs.pc + 1.U
      cycle := 0.U
      state := sExecute
    }
  }
}
```

## Related Fixes

### 1. Cycle Width (DONE ✅)
Changed from `UInt(3.W)` to `UInt(4.W)` to support NMI's 9 cycles.

**File**: `src/main/scala/cpu/core/CPU6502Core.scala` line 29

### 2. NMI Vector Read (PENDING)
NMI vector read will work once Fetch is fixed, since it uses the same 2-cycle pattern.

### 3. Testbench Cleanup (DONE ✅)
Removed `io_mapperNum` references from testbench.

## Impact

**Critical**: Without this fix, CPU cannot execute correctly. All games will fail.

## Test Plan

1. Fix Fetch state to 3-cycle pattern
2. Rebuild: `./scripts/build.sh fast`
3. Test: CPU should progress past 0xE7E8
4. Verify: NMI should trigger when PPUCTRL enables it

## Files to Modify

- `src/main/scala/cpu/core/CPU6502Core.scala` - Fetch state (lines ~125-145)
