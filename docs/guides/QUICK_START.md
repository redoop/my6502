# 🚀 快速开始指南

5 分钟快速上手 NES 模拟器项目。

---

## 📋 前置要求

```bash
# macOS
brew install sbt verilator sdl2

# Ubuntu/Debian
sudo apt-get install sbt verilator libsdl2-dev

# 检查安装
sbt --version      # 应该 >= 1.9.0
verilator --version # 应该 >= 5.0
```

---

## ⚡ 3 步快速运行

### 1️⃣ 克隆项目
```bash
git clone https://github.com/redoop/my6502.git
cd my6502
```

### 2️⃣ 编译模拟器
```bash
./scripts/build.sh fast
```

### 3️⃣ 运行游戏
```bash
./scripts/run.sh games/Donkey-Kong.nes
```

**就这么简单！** 🎉

---

## 🎮 控制方式

| 按键 | 功能 |
|------|------|
| ⬆️⬇️⬅️➡️ | 方向键 |
| Z | A 按钮 |
| X | B 按钮 |
| Enter | Start |
| RShift | Select |
| Ctrl+C | 退出 |

---

## 🧪 运行测试

```bash
# 快速测试
./scripts/test.sh quick

# 完整测试
./scripts/test.sh all

# 单个测试
sbt "testOnly cpu6502.instructions.FlagInstructionsSpec"
```

---

## 🔍 常用命令

### 构建
```bash
./scripts/build.sh              # 普通构建
./scripts/build.sh fast         # 快速构建（无 trace）
./scripts/build.sh trace        # 带 VCD trace
./scripts/build.sh optimized    # 优化构建
```

### 测试
```bash
./scripts/test.sh               # 所有测试
./scripts/test.sh unit          # 单元测试
./scripts/test.sh integration   # 集成测试
./scripts/test.sh quick         # 快速测试
```

### 运行游戏
```bash
./scripts/run.sh                           # Donkey Kong (默认)
./scripts/run.sh games/Super-Mario.nes     # Super Mario
./scripts/run.sh games/Contra.nes          # Contra
```

### 调试
```bash
./scripts/debug.sh opcodes <rom>    # 分析 ROM opcodes
./scripts/debug.sh vcd              # 分析 VCD 波形
./scripts/debug.sh monitor pc       # 监控 PC
./scripts/debug.sh transistors      # 统计晶体管
```

### 项目工具
```bash
./scripts/tools.sh clean      # 清理构建
./scripts/tools.sh generate   # 生成 Verilog
./scripts/tools.sh stats      # 项目统计
./scripts/tools.sh rom        # ROM 信息
./scripts/tools.sh check      # 检查环境
```

---

## 📚 下一步

### 新手
1. 阅读 [项目概述](01_PROJECT_OVERVIEW.md)
2. 查看 [游戏兼容性报告](GAME_COMPATIBILITY_REPORT.md)
3. 尝试运行不同的游戏

### 开发者
1. 阅读 [开发指南](02_DEVELOPMENT_GUIDE.md)
2. 查看 [CPU 实现](06_CPU_IMPLEMENTATION.md)
3. 运行测试并查看代码

### 贡献者
1. 查看 [已知问题](https://github.com/redoop/my6502/issues)
2. 阅读 [测试指南](03_TESTING_GUIDE.md)
3. 提交 Pull Request

---

## 🐛 遇到问题？

### 常见问题

**Q: 编译失败？**
```bash
# 清理并重新构建
./scripts/tools.sh clean
./scripts/build.sh fast
```

**Q: 游戏运行很慢？**
- 这是正常的！Verilator 是硬件级仿真，约 2-5 FPS
- 它在模拟每个时钟周期

**Q: 游戏画面卡住？**
- 查看 [已知问题 #4](https://github.com/redoop/my6502/issues/4)
- PPU 寄存器写入问题正在修复中

**Q: 测试失败？**
```bash
# 查看详细日志
sbt test 2>&1 | tee test.log

# 运行单个测试
sbt "testOnly <TestName>"
```

### 获取帮助

- 📖 查看 [完整文档](INDEX.md)
- 🐛 提交 [Issue](https://github.com/redoop/my6502/issues)
- 💬 查看 [讨论区](https://github.com/redoop/my6502/discussions)

---

## 📊 项目状态

**当前版本**: v0.7.1  
**测试通过率**: 122+/122+ (100%)  
**游戏兼容性**: 53%

**最新修复**:
- ✅ CPU Fetch 状态内存延迟
- ✅ PRG ROM 镜像映射

**进行中**:
- 🚧 PPU 寄存器写入修复

---

## 🔗 快速链接

- [项目主页](https://github.com/redoop/my6502)
- [完整文档](INDEX.md)
- [更新日志](../CHANGELOG.md)
- [游戏兼容性报告](GAME_COMPATIBILITY_REPORT.md)
- [问题追踪](https://github.com/redoop/my6502/issues)

---

**准备好了吗？开始探索吧！** 🚀

```bash
./scripts/run.sh games/Donkey-Kong.nes
```
