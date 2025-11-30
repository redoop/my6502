# Unit Tests

## Overview

Each NES module has dedicated unit tests to verify functionality in isolation.

## Test Modules

### 1. DMA Controller (`test_dma.sv`)
Tests OAM DMA transfers:
- Transfer 256 bytes from RAM to OAM
- Multiple page transfers
- Timing verification

### 2. APU (`test_apu.sv`)
Tests audio generation:
- Pulse channel 1 and 2
- Volume and duty cycle control
- Channel enable/disable

### 3. PPU (`test_ppu.sv`)
Tests video rendering:
- VBlank timing
- Rendering enable/disable
- Video signal generation

### 4. CPU (`test_cpu.sv`)
Tests 6502 CPU:
- Basic instructions (LDA, STA, ADC)
- Memory read/write
- NMI interrupt handling

## Running Tests

```bash
cd src/test/rtl/unit

# Run all tests
make all

# Run individual tests
make test_dma
make test_apu
make test_ppu
make test_cpu

# Clean build files
make clean
```

## Test Output

Each test generates:
- Console output with test results
- VCD waveform file for debugging

## Requirements

- Verilator 5.0+
- Make

## Adding New Tests

1. Create `test_<module>.sv` in `src/test/rtl/unit/`
2. Add target to `Makefile`
3. Document in this file
