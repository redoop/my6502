# Donkey Kong Debug Session - 2025-11-30

## Summary

Attempted to run Donkey Kong ROM. Found and fixed 2 critical CPU bugs. Game now runs but is stuck waiting for VBlank due to PPU register read issue.

## Bugs Found & Fixed

### 1. ✅ CPU Cycle Width Bug (FIXED)
**Symptom**: NMI vector read would fail  
**Root Cause**: `cycle` register was 3 bits (max 7), but NMI handler needs 9 cycles (0-8)  
**Fix**: Changed from `UInt(3.W)` to `UInt(4.W)`  
**File**: `src/main/scala/cpu/core/CPU6502Core.scala` line 29

### 2. ✅ Execute State Cycle Update Bug (FIXED)
**Symptom**: CPU stuck in Execute state, never completing instructions  
**Root Cause**: `cycle := execResult.nextCycle` executed BEFORE checking `execResult.done`, causing cycle to advance to invalid value  
**Fix**: Only update cycle when NOT done:
```scala
when(execResult.done) {
  cycle := 0.U
  state := sFetch
}.otherwise {
  cycle := execResult.nextCycle
}
```
**File**: `src/main/scala/cpu/core/CPU6502Core.scala` lines 147-154

### 3. ❌ PPU PPUSTATUS VBlank Flag (NOT FIXED)
**Symptom**: Game stuck in infinite loop waiting for VBlank  
**Root Cause**: PPU register $2002 (PPUSTATUS) not returning VBlank flag  
**Status**: This is known issue #4 from README  
**Impact**: Game cannot progress past initialization

## Test Results

### Reset Vector ✅
- Correctly reads 0xC79E from $FFFC-$FFFD
- CPU starts at correct address

### Mapper 0 ROM Mirroring ✅  
- 16KB ROM correctly mirrors at 0x8000-0xBFFF and 0xC000-0xFFFF
- Address mapping: 0xC79E → ROM offset 0x079E ✅

### CPU Execution ✅
- Instructions execute correctly
- PC advances properly
- Registers update correctly

### Game Loop ❌
```
C7AB: AD 02 20    LDA $2002   ; Read PPUSTATUS
C7AE: 29 80       AND #$80    ; Check VBlank bit
C7B0: F0 F9       BEQ $C7AB   ; Loop if not in VBlank
```

Game is stuck in this loop because PPUSTATUS never returns VBlank=1.

## Current Status

**CPU**: ✅ Working correctly  
**Memory**: ✅ ROM loading and mirroring correct  
**PPU**: ❌ Register reads not working  
**Game**: ❌ Stuck in VBlank wait loop

## Next Steps

1. Fix PPU PPUSTATUS register read to return VBlank flag
2. Test NMI triggering once game enables it (PPUCTRL bit 7)
3. Verify NMI vector read works with 4-bit cycle register

## Files Modified

1. `src/main/scala/cpu/core/CPU6502Core.scala`
   - Line 29: cycle width 3→4 bits
   - Lines 147-154: Execute state cycle update logic

2. `verilator/testbench_main.cpp`
   - Removed `io_mapperNum` references (lines 542, 550)

## Logs

Game runs for 20M+ cycles stuck in VBlank wait loop at PC=0xC7A4-0xC7AB.

VBlank flag is set in PPU (log shows `VBlank=1`) but not returned when CPU reads $2002.

## References

- Issue #4: PPU register write not working
- Commit 0cc9e7e: Previous Fetch delay fix
- NES Test ROM: nestest shows CPU works for basic instructions
