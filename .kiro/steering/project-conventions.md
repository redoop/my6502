---
inclusion: always
---

# Project Conventions

## File Organization
- **Script files**: All scripts (.sh) must be in `scripts/` directory
- **Test files**: Test code in `tests/` directory
- **Documentation files**: All documentation (.md) must be in `docs/` directory
  - **Official docs**: Main project docs in `docs/` root
  - **Debug logs**: Intermediate docs from conversations in `docs/logs/` directory
- **Temporary files**: Avoid creating temporary files in root directory

## Code Style
- Scala: Use Chisel3 hardware description language
- C++: For Verilator testbench
- Shell: Use bash, add shebang `#!/bin/bash`

## NES Emulator Project
- CPU: 6502 processor implementation in `src/main/scala/cpu/`
- PPU: Picture Processing Unit in `src/main/scala/nes/PPUSimplified.scala`
- Memory: Memory controller in `src/main/scala/nes/MemoryController.scala`
- Verilator: C++ testbench in `verilator/` directory

## Debugging
- Use Verilator for hardware-level simulation
- ROM files in `games/` directory
