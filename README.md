# My6502 - NES Emulator in SystemVerilog

A cycle-accurate NES (Nintendo Entertainment System) emulator implemented in SystemVerilog with Verilator.

## Features

### Hardware Components
- ✅ **CPU 6502**: Complete instruction set (151 opcodes)
- ✅ **PPU**: Picture Processing Unit with video output
- ✅ **APU**: Audio Processing Unit (basic registers)
- ✅ **DMA**: Direct Memory Access for sprite data
- ✅ **Mappers**: Support for Mapper 0 (NROM) and Mapper 4 (MMC3)

### Video Output
- 256x240 resolution at 60 FPS
- RGB output with HSYNC/VSYNC/DE signals
- Real-time rendering via SDL2

### Emulation Accuracy
- Cycle-accurate CPU execution
- Proper PPU timing (262 scanlines × 341 dots)
- VBlank synchronization
- PPUADDR auto-increment
- Controller input support

## Quick Start

### Prerequisites
```bash
brew install verilator sdl2
```

### Run Super Mario Bros with GUI
```bash
./run_smb.sh
```

Or manually:
```bash
cd src/test/rtl
make gui_smb
```

### Controls
- **Arrow Keys**: D-Pad
- **Z**: B Button
- **X**: A Button  
- **Enter**: START
- **Right Shift**: SELECT
- **ESC**: Quit

## Building

### Compile All Runners
```bash
cd src/test/rtl
make all
```

### Individual Targets
```bash
make runner_nrom    # Mapper 0 (NROM)
make runner_mmc3    # Mapper 4 (MMC3)
make smb_gui        # GUI version
```

### Run Tests
```bash
cd src/test/unit
make all
```

## Project Structure

```
my6502/
├── src/
│   ├── main/rtl/          # RTL source files
│   │   ├── cpu_6502.sv    # CPU implementation
│   │   ├── nes_ppu.sv     # PPU implementation
│   │   ├── nes_apu.sv     # APU implementation
│   │   ├── nes_dma.sv     # DMA controller
│   │   ├── nes_system.sv  # Top-level integration
│   │   ├── mapper_mmc3.sv # MMC3 mapper
│   │   └── ...
│   └── test/
│       ├── unit/          # Unit tests
│       └── rtl/           # Integration tests & runners
├── games/                 # ROM files (not included)
├── docs/                  # Documentation
└── run_smb.sh            # Quick launcher
```

## Documentation

- [Project Status](docs/PROJECT_STATUS.md) - Overall progress
- [Changelog](docs/CHANGELOG.md) - Version history
- [Quick Start](docs/QUICKSTART.md) - Setup guide
- [SMB Status](docs/SMB_STATUS.md) - Super Mario Bros support
- [GUI README](src/test/rtl/README_GUI.md) - GUI usage

## Testing

### Unit Tests (6/6 passing)
```bash
cd src/test/unit
make all
```

Tests include:
- CPU instruction execution
- PPU rendering
- APU functionality
- DMA transfers
- NMI handling

### Game Tests
- ✅ nestest.nes (Mapper 0)
- ⚠️ Super Mario Bros (needs Mapper 1 or standard ROM)

## Current Status

### Completed (70%)
- Full 6502 CPU instruction set
- PPU video timing and output
- VBlank generation and synchronization
- Mapper 0 (NROM) and Mapper 4 (MMC3)
- SDL2 GUI with real-time rendering
- Controller input
- Unit test suite

### In Progress
- Mapper 1 (MMC1) for standard Super Mario Bros
- MMC3 IRQ support
- Complete sprite rendering
- Background scrolling

## Performance

- Real-time emulation at ~60 FPS
- Cycle-accurate timing
- ~30,000 clock cycles per frame

## Known Issues

- Super Mario Bros (384KB version) requires Mapper 1
- Some games may need additional mapper features
- Audio output not yet implemented

## License

Educational project - see source files for details.

## Credits

- NES hardware documentation from nesdev.org
- Test ROMs from the NES community
- Built with Verilator and SDL2
