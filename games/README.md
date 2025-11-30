# NES ROM Files

## Available ROMs

| File | Game | Mapper | PRG | CHR | Size | Notes |
|------|------|--------|-----|-----|------|-------|
| `SuperMarioBros_mapper0.nes` | Super Mario Bros | 0 (NROM) | 32KB | 8KB | 40KB | 原版超级马里奥 |
| `DonkeyKong_mapper0.nes` | Donkey Kong | 0 (NROM) | 16KB | 8KB | 24KB | 大金刚 |
| `nestest_mapper0.nes` | NES Test | 0 (NROM) | 16KB | 8KB | 24KB | CPU测试ROM |
| `Zelda_mapper1.nes` | The Legend of Zelda | 1 (MMC1) | 128KB | 0KB | 128KB | 塞尔达传说 ⭐ |
| `SuperMarioBros3_mapper4.nes` | Super Mario Bros 3 | 4 (MMC3) | 256KB | 128KB | 384KB | 超级马里奥3 |

## Mapper说明

### Mapper 0 (NROM)
- 最简单的mapper，无bank切换
- 使用: `make runner_nrom`

### Mapper 1 (MMC1) ⭐ 新增
- 支持PRG/CHR bank切换
- 使用: `make runner_mmc1`

### Mapper 4 (MMC3)
- 支持PRG/CHR bank切换和IRQ
- 使用: `make runner_mmc3`

## 运行游戏

### The Legend of Zelda (Mapper 1) ⭐
```bash
cd src/test/rtl
./obj_dir_gui_mmc1/Vnes_system ../../games/Zelda_mapper1.nes
```

### Super Mario Bros (原版)
```bash
cd src/test/rtl
./obj_dir_nrom/Vnes_system ../../games/SuperMarioBros_mapper0.nes
```

### Donkey Kong
```bash
cd src/test/rtl
./obj_dir_nrom/Vnes_system ../../games/DonkeyKong_mapper0.nes
```

## 添加新ROM

如果要添加新的ROM文件，建议命名格式：
```
GameName_mapperN.nes
```

例如：
- `Zelda_mapper1.nes` (MMC1) ✅
- `Metroid_mapper1.nes` (MMC1)
- `MegaMan2_mapper1.nes` (MMC1)
