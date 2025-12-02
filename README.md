# My6502 - 6502 CPU in SystemVerilog

A cycle-accurate 6502 CPU implementation in SystemVerilog with Verilator, capable of running Tiny BASIC and NES games.

## Features

### Core Components
- ✅ **CPU 6502**: Complete instruction set (151 opcodes)
- ✅ **Tiny BASIC**: Interactive BASIC interpreter running on 6502
- ✅ **NES Support**: Full NES emulation with PPU, APU, and mappers
- ✅ **Memory-mapped I/O**: Character input/output at $F000/$F001

### 6502 CPU Features
- Cycle-accurate execution
- All addressing modes (Immediate, Zero Page, Absolute, Indexed, Indirect)
- Full instruction set including unofficial opcodes
- Hardware stack at $0100-$01FF
- IRQ/NMI interrupt support

### Tiny BASIC Support
- Interactive command-line interface
- Memory-mapped character I/O
- Real-time keyboard input
- Program execution and debugging

## Quick Start

### Prerequisites
```bash
brew install verilator
```

### Run Tiny BASIC ⭐
```bash
./run_tinybasic_interactive.sh
```

Interactive BASIC interpreter with commands:
- `PRINT`, `LET`, `IF`, `GOTO`, `GOSUB`, `RETURN`
- `LIST`, `RUN`, `NEW`
- Type commands and press Enter
- Ctrl+C to exit

### Run NES Games

#### The Legend of Zelda (Mapper 1 - MMC1)
```bash
./scripts/run_zelda.sh
```

#### Super Mario Bros 3 (Mapper 4)
```bash
./scripts/run_smb.sh
```

### NES Controls
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
make interactive   # Tiny BASIC runner
make runner_nrom   # Mapper 0 (NROM)
make runner_mmc1   # Mapper 1 (MMC1)
make runner_mmc3   # Mapper 4 (MMC3)
make smb_gui       # GUI version
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
├── basic/                 # Tiny BASIC programs
├── games/                 # ROM files (not included)
├── docs/                  # Documentation
└── run_tinybasic_interactive.sh  # Quick launcher
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
- Tiny BASIC interpreter with interactive I/O
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
