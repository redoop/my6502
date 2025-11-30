# Donkey Kong ROM 分析

## ROM 信息

- **文件名**: DonkeyKong.nes
- **大小**: 24KB
- **Mapper**: 0 (NROM)
- **PRG ROM**: 16KB (镜像到 $8000-$BFFF 和 $C000-$FFFF)
- **CHR ROM**: 8KB
- **Reset Vector**: $C79E ✓

## 测试结果

### ✅ 成功的部分

1. **ROM 加载**: 正确
2. **Reset Vector**: $C79E 正确读取
3. **CPU 执行**: 正常
4. **NMI 启用**: PPUCTRL=$80 (bit 7=1) ✓
5. **GUI 运行**: 720+ 帧流畅运行

### ⚠️ 观察到的行为

**IO 写入记录**:
```
Write #1: $2000 = $10 (NMI=0, BG=$1)
Write #2: $2000 = $10 (NMI=0, BG=$1)
Write #4122: $2000 = $80 (NMI=1, BG=$0)
Write #4123: $2000 = $80 (NMI=1, BG=$0)
```

**分析**:
- 游戏只写入了 PPUCTRL 寄存器
- 没有 PPUADDR ($2006) 写入
- 没有 PPUDATA ($2007) 写入
- 没有 VRAM 或 Palette 写入
- 4122 次写入之间的间隔很大

### 🤔 可能的原因

1. **等待 VBlank 计数**
   - 游戏可能在等待特定数量的 VBlank
   - 或者在等待某个时序条件

2. **等待控制器输入**
   - 可能需要按键才能继续
   - 或者在等待 START 按钮

3. **等待其他硬件状态**
   - 可能检查某些 PPU 状态
   - 或者等待特定的硬件响应

4. **ROM 版本问题**
   - 可能不是完整的 ROM
   - 或者是修改版

## 对比分析

### Donkey Kong vs Super Mario Bros

| 特性 | Donkey Kong | SMB (384KB) | SMB (40KB) |
|------|-------------|-------------|------------|
| Mapper | 0 (NROM) | 4 (MMC3) | 0 (NROM) |
| 大小 | 24KB | 384KB | 40KB |
| Reset Vector | $C79E ✓ | $FF40 ✓ | $8000 ✓ |
| NMI 启用 | ✓ ($80) | ✗ ($08) | ? |
| VRAM 写入 | ✗ | ✗ | ✗ |
| IO 写入数 | 4 | 很多 | ? |

## 结论

Donkey Kong 比 Super Mario Bros 进展更好：
- ✅ 正确启用了 NMI
- ✅ CPU 正常执行
- ⚠️ 但仍未开始图形初始化

可能需要：
1. 控制器输入模拟
2. 更精确的时序
3. 完整的 PPU 功能
4. 或者这个 ROM 版本有问题

## 建议

1. 尝试模拟按键输入（START 按钮）
2. 检查 PPU 状态寄存器 ($2002) 的返回值
3. 验证 VBlank 时序是否精确
4. 尝试其他已知可用的 Mapper 0 游戏
