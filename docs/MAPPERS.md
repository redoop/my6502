# NES Mapper 快速参考

## 已实现的Mapper

### Mapper 0 (NROM)
**最简单的mapper，无bank切换**

- **PRG ROM**: 16KB或32KB（固定）
- **CHR ROM**: 8KB（固定）
- **代表游戏**:
  - Super Mario Bros（超级马里奥兄弟）
  - Donkey Kong（大金刚）
  - Pac-Man（吃豆人）
  - Balloon Fight（气球大战）

**编译**: `make runner_nrom`

---

### Mapper 1 (MMC1) ✨ 新增
**最常用的mapper之一，串行写入接口**

- **PRG ROM**: 最大256KB，16KB/32KB切换
- **CHR ROM**: 最大128KB，4KB/8KB切换
- **特殊功能**: 5位串行移位寄存器
- **代表游戏**:
  - The Legend of Zelda（塞尔达传说）
  - Metroid（银河战士）
  - Mega Man 2（洛克人2）
  - Kid Icarus（光神话）
  - Castlevania II（恶魔城2）
  - Bomberman II（炸弹人2）

**编译**: `make runner_mmc1`  
**GUI**: `make gui_smb_mmc1`

---

### Mapper 4 (MMC3)
**功能最强大的mapper，支持IRQ**

- **PRG ROM**: 最大512KB，8KB切换
- **CHR ROM**: 最大256KB，1KB/2KB切换
- **特殊功能**: 扫描线IRQ计数器
- **代表游戏**:
  - Super Mario Bros 3（超级马里奥3）
  - Mega Man 3-6（洛克人3-6）
  - Kirby's Adventure（星之卡比）
  - Ninja Gaiden（忍者龙剑传）

**编译**: `make runner_mmc3`  
**GUI**: `make gui_smb`

---

## 快速对比

| 特性 | NROM | MMC1 | MMC3 |
|------|------|------|------|
| PRG切换 | 无 | 16KB | 8KB |
| CHR切换 | 无 | 4KB | 1KB/2KB |
| 最大PRG | 32KB | 256KB | 512KB |
| 最大CHR | 8KB | 128KB | 256KB |
| IRQ支持 | 无 | 无 | 有 |
| 写入方式 | - | 串行 | 直接 |
| 复杂度 | 简单 | 中等 | 复杂 |

## 使用指南

### 1. 识别ROM的Mapper
```bash
python3 << 'EOF'
with open('game.nes', 'rb') as f:
    header = f.read(16)
    mapper = ((header[6] >> 4) & 0x0F) | (header[7] & 0xF0)
    print(f"Mapper: {mapper}")
EOF
```

### 2. 选择正确的编译目标
```bash
# Mapper 0
make runner_nrom

# Mapper 1
make runner_mmc1

# Mapper 4
make runner_mmc3
```

### 3. 运行游戏
```bash
# 命令行
./obj_dir_mmc1/Vnes_system game.nes

# GUI
make gui_smb_mmc1
```

## 常见游戏Mapper对照表

| 游戏 | Mapper | 编译目标 | 启动脚本 |
|------|--------|----------|----------|
| The Legend of Zelda ⭐ | 1 | runner_mmc1 | ./run_zelda.sh |
| Super Mario Bros | 0 | runner_nrom | ./run_smb_mmc1.sh |
| Donkey Kong | 0 | runner_nrom | ./run_donkeykong.sh |
| Super Mario Bros 3 | 4 | runner_mmc3 | ./run_smb.sh |

## 技术细节

### MMC1写入协议
```
1. 写入5次，每次1位（bit 0）
2. bit 7 = 1 复位
3. 第5次写入更新寄存器
```

### MMC3 IRQ
```
- 基于PPU A12信号
- 扫描线计数器
- 用于分屏滚动
```

## 文档链接

- [MMC1详细文档](docs/MAPPER_MMC1.md)
- [MMC1实现说明](docs/MMC1_IMPLEMENTATION.md)
- [项目README](README.md)

## 测试

```bash
# 测试所有mapper编译
cd src/test/rtl
make all

# 测试MMC1
./test_mmc1.sh
```

---

**覆盖率**: 这三个mapper覆盖了NES游戏库中约70%的游戏！
