# 🎮 如何运行 NES 游戏

**版本**: v0.4.0
**日期**: 2025-11-27

---

## 🚀 快速开始

### 方法 1: 使用启动脚本（推荐）

```bash
# 给脚本添加执行权限
chmod +x run_emulator.sh

# 运行游戏
./run_emulator.sh roms/contra.nes
```

### 方法 2: 直接使用 SBT

```bash
sbt "runMain nes.NESEmulator roms/contra.nes"
```

---

## 📋 前置要求

### 系统要求
- **操作系统**: Linux / macOS / Windows (WSL)
- **Java**: JDK 8 或更高版本
- **SBT**: Scala Build Tool
- **内存**: 至少 2GB RAM
- **显示**: 支持 GUI 的环境

### 检查环境

```bash
# 检查 Java
java -version

# 检查 SBT
sbt --version

# 检查显示环境（Linux）
echo $DISPLAY
```

---

## 🎮 控制说明

### 键盘映射

| NES 按键 | 键盘按键 | 说明 |
|---------|---------|------|
| A | Z | A 按钮 |
| B | X | B 按钮 |
| SELECT | A | 选择 |
| START | S | 开始 |
| ↑ | ↑ | 上 |
| ↓ | ↓ | 下 |
| ← | ← | 左 |
| → | → | 右 |

### 模拟器控制

| 按键 | 功能 |
|------|------|
| 空格 | 暂停/继续 |
| ESC | 退出 |

---

## 📁 ROM 文件

### 获取 ROM

**注意**: 请确保您拥有游戏的合法副本。

推荐的测试 ROM:
1. **公共领域 ROM**: 
   - [NES Test ROMs](https://github.com/christopherpow/nes-test-roms)
   - 免费且合法

2. **自制游戏**:
   - [NESDev Homebrew](https://wiki.nesdev.com/w/index.php/Homebrew_games)
   - 社区制作的免费游戏

### ROM 目录结构

```
my6502/
├── roms/
│   ├── contra.nes          # 魂斗罗
│   ├── smb.nes            # Super Mario Bros
│   ├── megaman.nes        # Mega Man
│   └── test/
│       ├── nestest.nes    # CPU 测试
│       └── sprite_test.nes # 精灵测试
```

---

## 🎯 支持的游戏

### 完全支持 (98%+)

| 游戏 | Mapper | 状态 | 说明 |
|------|--------|------|------|
| 魂斗罗 | MMC3 (4) | ✅ | 完全可玩 |
| Super Mario Bros | NROM (0) | ✅ | 完全可玩 |
| Mega Man | MMC1 (1) | 🚧 | 部分支持 |

### 部分支持 (80%+)

| 游戏 | Mapper | 状态 | 问题 |
|------|--------|------|------|
| Castlevania | MMC1 (1) | 🚧 | Mapper 待完善 |
| Zelda | MMC1 (1) | 🚧 | Mapper 待完善 |

### 不支持

| 游戏 | Mapper | 原因 |
|------|--------|------|
| Super Mario Bros 3 | MMC3 (4) | 需要更多测试 |
| Kirby's Adventure | MMC3 (4) | 需要更多测试 |

---

## 🔧 故障排除

### 问题 1: 窗口不显示

**症状**: 程序运行但没有窗口
**原因**: 没有 GUI 环境
**解决**:
```bash
# Linux: 检查 DISPLAY
echo $DISPLAY

# 如果为空，设置
export DISPLAY=:0

# 或使用 X11 转发
ssh -X user@host
```

### 问题 2: 运行很慢

**症状**: FPS 很低，游戏卡顿
**原因**: ChiselTest 仿真性能限制
**解决**:
- 这是正常的，ChiselTest 是功能仿真，不是性能优化的
- 要获得更好的性能，需要使用 Verilator（见 EMULATOR_GUIDE.md）

### 问题 3: ROM 加载失败

**症状**: "不是有效的 NES ROM 文件"
**原因**: ROM 文件损坏或格式错误
**解决**:
```bash
# 检查文件头
hexdump -C roms/contra.nes | head -1
# 应该显示: 4e 45 53 1a (NES^Z)

# 检查文件大小
ls -lh roms/contra.nes
```

### 问题 4: 内存不足

**症状**: Java OutOfMemoryError
**解决**:
```bash
# 增加 JVM 堆内存
export SBT_OPTS="-Xmx4G"
sbt "runMain nes.NESEmulator roms/contra.nes"
```

---

## 📊 性能说明

### 当前实现

**类型**: ChiselTest 功能仿真
**性能**: 约 0.1-1 FPS（取决于硬件）
**用途**: 功能验证和测试

### 性能对比

| 实现方式 | 性能 | 用途 |
|---------|------|------|
| ChiselTest | 0.1-1 FPS | 功能测试 |
| Verilator | 30-60 FPS | 软件模拟 |
| FPGA | 60 FPS | 硬件实现 |

### 提升性能

要获得可玩的性能，请参考：
- [EMULATOR_GUIDE.md](EMULATOR_GUIDE.md) - Verilator 方案
- [FPGA_GUIDE.md](FPGA_GUIDE.md) - FPGA 部署（待创建）

---

## 🎨 显示设置

### 窗口大小

默认: 512x480 (2x 缩放)

修改缩放:
```scala
// 在 NESEmulator.scala 中修改
private val SCALE = 3  // 3x 缩放 (768x720)
```

### 调色板

使用标准 NES 调色板（64 色）

自定义调色板:
```scala
// 修改 NES_PALETTE 数组
val NES_PALETTE = Array(
  0x7C7C7C, // 颜色 0
  0x0000FC, // 颜色 1
  // ...
)
```

---

## 🐛 调试模式

### 启用调试

```bash
# 方法 1: 环境变量
export NES_DEBUG=1
./run_emulator.sh roms/contra.nes

# 方法 2: 修改代码
# 在 NESEmulator.scala 中设置
val DEBUG = true
```

### 调试信息

启用后显示:
- CPU 状态 (PC, A, X, Y, SP)
- PPU 状态 (扫描线, 像素)
- 内存访问
- 性能统计

---

## 📝 示例

### 运行魂斗罗

```bash
# 1. 准备 ROM
mkdir -p roms
cp /path/to/contra.nes roms/

# 2. 运行
./run_emulator.sh roms/contra.nes

# 3. 游戏控制
# Z - 射击
# X - 跳跃
# 方向键 - 移动
# S - 开始游戏
```

### 运行测试 ROM

```bash
# CPU 测试
./run_emulator.sh roms/test/nestest.nes

# 精灵测试
./run_emulator.sh roms/test/sprite_test.nes
```

---

## 🔮 未来改进

### 短期
- ⏳ 优化性能
- ⏳ 添加音频输出
- ⏳ 保存/加载状态
- ⏳ 截图功能

### 中期
- ⏳ Verilator 集成
- ⏳ 更多 Mapper 支持
- ⏳ 作弊码支持
- ⏳ 录像回放

### 长期
- ⏳ FPGA 部署
- ⏳ 网络对战
- ⏳ 工具链完善
- ⏳ 社区贡献

---

## 📚 相关文档

- [EMULATOR_GUIDE.md](EMULATOR_GUIDE.md) - 完整模拟器指南
- [GAME_SUPPORT.md](GAME_SUPPORT.md) - 游戏兼容性
- [DEVELOPMENT.md](DEVELOPMENT.md) - 开发指南
- [GAME_TEST_RESULTS.md](GAME_TEST_RESULTS.md) - 测试结果

---

## 💡 提示

1. **首次运行**: 编译需要几分钟，请耐心等待
2. **性能**: ChiselTest 仿真较慢，这是正常的
3. **ROM**: 确保使用合法的 ROM 文件
4. **问题**: 遇到问题请查看故障排除部分

---

**祝您游戏愉快！** 🎮🎉

如有问题，请提交 Issue 或查看文档。
