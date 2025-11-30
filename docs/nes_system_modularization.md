# NES System Modularization Plan

## Current Status
- Single file: `nes_system.sv` (1384 lines)
- Contains: CPU interface, memory map, PPU, APU, DMA

## Proposed Module Structure

### 1. Core Modules (Independent)
- **cpu_6502.sv** - Already exists, CPU core
- **nes_ppu_render.sv** - PPU rendering pipeline
- **nes_apu.sv** - APU audio generation  
- **nes_dma.sv** - DMA controller

### 2. Integration Module
- **nes_system.sv** - Top-level integration
  - Clock generation
  - Memory arrays (RAM, VRAM, OAM, Palette)
  - CPU memory map
  - Register management
  - Module instantiation

## Benefits
- Easier to understand and maintain
- Better testability
- Clearer module boundaries
- Reusable components

## Implementation Steps
1. Extract PPU rendering logic → nes_ppu_render.sv
2. Extract APU logic → nes_apu.sv  
3. Extract DMA logic → nes_dma.sv
4. Refactor nes_system.sv as integration layer

## Dependencies
- PPU needs: vram, palette, ppuctrl, ppumask, ppuscroll
- APU needs: apu_pulse*, apu_triangle, apu_noise, apu_dmc registers
- DMA needs: ram, oam, cpu_clk
