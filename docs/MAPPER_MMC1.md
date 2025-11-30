# MMC1 Mapper Implementation

## Overview

MMC1 (Mapper 1) is one of the most common NES mappers, used in games like:
- The Legend of Zelda
- Metroid
- Mega Man 2
- Kid Icarus
- Castlevania II

**Note**: The original Super Mario Bros uses Mapper 0 (NROM-256), NOT MMC1.

## Features

### PRG ROM Banking
- Supports up to 256KB PRG ROM (16 banks × 16KB)
- Three banking modes:
  - 32KB mode: Switch entire 32KB
  - Fix first bank at $8000, switch second at $C000
  - Switch first bank at $8000, fix last at $C000

### CHR ROM Banking
- Supports up to 128KB CHR ROM (32 banks × 4KB)
- Two banking modes:
  - 8KB mode: Switch entire 8KB
  - 4KB mode: Switch two 4KB banks independently

### Serial Write Interface
- Uses a 5-bit shift register
- Write bit 7 = 1 to reset
- Write 5 bits sequentially to update register
- Registers:
  - $8000-$9FFF: Control register
  - $A000-$BFFF: CHR bank 0
  - $C000-$DFFF: CHR bank 1
  - $E000-$FFFF: PRG bank

## Implementation Details

### File: `mapper_mmc1.sv`

```systemverilog
module mapper_mmc1 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [15:0] cpu_addr,
    input  logic [7:0]  cpu_data,
    input  logic        cpu_write,
    output logic [17:0] prg_rom_addr,
    input  logic [13:0] ppu_addr,
    output logic [17:0] chr_rom_addr
);
```

### Key Components

1. **Shift Register**: 5-bit register for serial writes
2. **Control Register**: Banking mode configuration
3. **Bank Registers**: CHR bank 0/1, PRG bank
4. **Address Mapping**: Combinational logic for ROM addressing

## Usage

### Compile
```bash
cd src/test/rtl
make runner_mmc1
```

### Run with MMC1 ROM
```bash
./obj_dir_mmc1/Vnes_system path/to/game.nes
```

### GUI Version
```bash
make gui_smb_mmc1
```

## Testing

To test MMC1 implementation, you need ROMs that use Mapper 1:
- Zelda (128KB PRG + 128KB CHR)
- Metroid (128KB PRG + 0KB CHR with CHR RAM)
- Mega Man 2 (128KB PRG + 0KB CHR with CHR RAM)

## Technical Notes

### Reset Behavior
- Shift register initializes to 0b10000
- Control register defaults to 0b01100 (16KB PRG mode, 4KB CHR mode)
- All bank registers initialize to 0

### Write Protocol
1. Write bit 7 = 1: Reset shift register
2. Write 5 bits (LSB first) to shift register
3. On 5th write: Update target register based on address
4. Shift register auto-resets after write

### Address Decoding
- $8000-$9FFF: Control register
- $A000-$BFFF: CHR bank 0 (4KB at $0000)
- $C000-$DFFF: CHR bank 1 (4KB at $1000)
- $E000-$FFFF: PRG bank select

## Differences from MMC3

| Feature | MMC1 | MMC3 |
|---------|------|------|
| Write Interface | Serial (5 bits) | Direct (8 bits) |
| PRG Banking | 16KB/32KB | 8KB switchable |
| CHR Banking | 4KB/8KB | 1KB/2KB switchable |
| IRQ Support | No | Yes (scanline counter) |
| Complexity | Simple | Complex |

## Future Enhancements

- [ ] PRG RAM banking support
- [ ] Mirroring control
- [ ] WRAM enable/disable
- [ ] MMC1A/B/C variant differences

## References

- [NESdev Wiki - MMC1](https://www.nesdev.org/wiki/MMC1)
- [MMC1 Pinout](https://www.nesdev.org/wiki/MMC1_pinout)
