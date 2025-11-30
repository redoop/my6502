# My6502 - NES Emulator in SystemVerilog

A cycle-accurate NES (Nintendo Entertainment System) emulator implemented in SystemVerilog with Verilator.

## Features

### Hardware Components
- ✅ **CPU 6502**: Complete instruction set (151 opcodes)
- ✅ **PPU**: Picture Processing Unit with video output
- ✅ **APU**: Audio Processing Unit with 5 channels (Pulse×2, Triangle, Noise, DMC)
- ✅ **DMA**: Direct Memory Access for sprite data
- ✅ **Mappers**: Support for Mapper 0 (NROM), Mapper 1 (MMC1), and Mapper 4 (MMC3)

### Video Output
- 256x240 resolution at 60 FPS
- RGB output with HSYNC/VSYNC/DE signals
- Real-time rendering via SDL2

### Audio Output
- 5-channel sound (2× Pulse, Triangle, Noise, DMC)
- 44.1kHz stereo output via SDL2
- Real-time audio mixing
- Envelope, length counter, and frame counter support

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

### Run Games

#### The Legend of Zelda (Mapper 1 - MMC1) ⭐
```bash
./scripts/run_zelda.sh
```

#### Super Mario Bros (Original - Mapper 0)
```bash
./scripts/run_smb_mmc1.sh
```

#### Super Mario Bros 3 (Mapper 4)
```bash
./scripts/run_smb.sh
```

#### Donkey Kong (Mapper 0)
```bash
./scripts/run_donkeykong.sh
```

### Verify ROMs
```bash
./scripts/verify_roms.sh
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
make runner_mmc1    # Mapper 1 (MMC1)
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
- ✅ The Legend of Zelda (Mapper 1 - MMC1) ⭐
- ⚠️ Super Mario Bros (original uses Mapper 0/NROM-256, needs debugging)
- ✅ Mapper 4 (MMC3) implemented

## Current Status

### Completed (80%)
- Full 6502 CPU instruction set
- PPU video timing and output
- APU audio processing and SDL2 output
- VBlank generation and synchronization
- Mapper 0 (NROM), Mapper 1 (MMC1), and Mapper 4 (MMC3)
- SDL2 GUI with real-time rendering and audio
- Controller input
- Unit test suite

### In Progress
- Game ROM compatibility debugging
- Complete sprite rendering
- Background scrolling
- DMC channel implementation

## Performance

- Real-time emulation at ~60 FPS
- Cycle-accurate timing
- ~30,000 clock cycles per frame

## Known Issues

- Super Mario Bros uses Mapper 0 (NROM-256) but needs debugging for proper graphics
- Some games may need additional mapper features
- DMC channel (sample playback) not yet implemented

## License

Educational project - see source files for details.

## Credits

- NES hardware documentation from nesdev.org
- Test ROMs from the NES community
- Built with Verilator and SDL2
