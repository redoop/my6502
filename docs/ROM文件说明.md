# ROM文件管理说明

## 文件重命名完成 ✅

所有ROM文件已重命名并标记mapper类型。

## 当前ROM列表

| 原文件名 | 新文件名 | Mapper | 大小 | 说明 |
|---------|---------|--------|------|------|
| `smb.nes` | `SuperMarioBros_mapper0.nes` | 0 (NROM) | 40KB | 超级马里奥兄弟（原版） |
| `DonkeyKong.nes` | `DonkeyKong_mapper0.nes` | 0 (NROM) | 24KB | 大金刚 |
| `nestest.nes` | `nestest_mapper0.nes` | 0 (NROM) | 24KB | CPU测试ROM |
| `SuperMarioBros.nes` | `SuperMarioBros3_mapper4.nes` | 4 (MMC3) | 384KB | 超级马里奥3（非标准版） |

## 启动脚本

### 1. Super Mario Bros（原版，Mapper 0）
```bash
./run_smb_mmc1.sh
```

### 2. Super Mario Bros 3（Mapper 4）
```bash
./run_smb.sh
```

### 3. Donkey Kong（Mapper 0）
```bash
./run_donkeykong.sh
```

## 命名规范

所有ROM文件使用统一命名格式：
```
GameName_mapperN.nes
```

例如：
- `SuperMarioBros_mapper0.nes` - 超级马里奥（Mapper 0）
- `Zelda_mapper1.nes` - 塞尔达传说（Mapper 1）
- `SuperMarioBros3_mapper4.nes` - 超级马里奥3（Mapper 4）

## 更新的文件

### 1. Makefile
- ✅ 更新所有ROM路径
- ✅ `run_mario` → 使用 `SuperMarioBros3_mapper4.nes`
- ✅ `run_nestest` → 使用 `nestest_mapper0.nes`
- ✅ `gui_smb` → 使用 `SuperMarioBros3_mapper4.nes`
- ✅ `gui_smb_mmc1` → 使用 `SuperMarioBros_mapper0.nes`

### 2. 启动脚本
- ✅ `run_smb.sh` → Super Mario Bros 3 (Mapper 4)
- ✅ `run_smb_mmc1.sh` → Super Mario Bros (Mapper 0)
- ✅ `run_donkeykong.sh` → Donkey Kong (Mapper 0) **新增**

### 3. 文档
- ✅ `games/README.md` - ROM说明文档
- ✅ 本文档

## 快速测试

### 验证ROM文件
```bash
cd games
ls -lh *_mapper*.nes
```

### 测试编译
```bash
cd src/test/rtl
make clean
make all
```

### 运行游戏
```bash
# Super Mario Bros 3
./run_smb.sh

# Super Mario Bros (原版)
./run_smb_mmc1.sh

# Donkey Kong
./run_donkeykong.sh
```

## Mapper对应关系

| Mapper | 名称 | ROM数量 | 文件 |
|--------|------|---------|------|
| 0 | NROM | 3 | SuperMarioBros_mapper0.nes<br>DonkeyKong_mapper0.nes<br>nestest_mapper0.nes |
| 1 | MMC1 | 0 | （需要添加Zelda, Metroid等） |
| 4 | MMC3 | 1 | SuperMarioBros3_mapper4.nes |

## 添加新ROM

如果要添加新的ROM文件：

1. 检查mapper类型：
```bash
cd games
python3 << 'EOF'
with open('newgame.nes', 'rb') as f:
    header = f.read(16)
    mapper = ((header[6] >> 4) & 0x0F) | (header[7] & 0xF0)
    print(f"Mapper: {mapper}")
EOF
```

2. 重命名文件：
```bash
mv newgame.nes GameName_mapperN.nes
```

3. 更新 `games/README.md`

## 注意事项

⚠️ **重要发现**：
- Super Mario Bros **原版**使用 Mapper 0 (NROM)，不是MMC1
- `SuperMarioBros_mapper0.nes` 是正确的原版ROM
- `SuperMarioBros3_mapper4.nes` 是非标准版本（可能是hack或multicart）

## 下一步

建议添加以下Mapper 1游戏：
- [ ] The Legend of Zelda (塞尔达传说)
- [ ] Metroid (银河战士)
- [ ] Mega Man 2 (洛克人2)
- [ ] Kid Icarus (光神话)
- [ ] Castlevania II (恶魔城2)
