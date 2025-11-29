# 🔧 故障排除指南

常见问题和解决方案。

---

## 🚨 编译问题

### SBT 编译失败

**问题**: `sbt compile` 失败
```
[error] (compile) java.lang.OutOfMemoryError: Java heap space
```

**解决方案**:
```bash
# 增加 JVM 内存
export SBT_OPTS="-Xmx4G -Xss2M"
sbt compile
```

---

### Verilator 编译失败

**问题**: `./scripts/build.sh` 失败
```
%Error: VNESSystemRefactored.cpp: No such file or directory
```

**解决方案**:
```bash
# 清理并重新生成 Verilog
./scripts/tools.sh clean
sbt "runMain nes.GenerateNESVerilog"
./scripts/build.sh fast
```

---

### 依赖下载慢

**问题**: SBT 下载依赖很慢

**解决方案**: 使用阿里云镜像
```bash
# 已配置在 build.sbt 中
# 如果还是慢，检查网络连接
```

---

## 🎮 运行问题

### 游戏运行很慢

**问题**: FPS 只有 2-5

**这是正常的！**
- Verilator 是硬件级仿真
- 它在模拟每个时钟周期
- 真实硬件会快得多

**优化建议**:
```bash
# 使用优化构建
./scripts/build.sh optimized

# 减少调试输出
# 编辑 verilator/testbench_main.cpp
# 注释掉 printf 语句
```

---

### 游戏画面卡住

**问题**: 游戏启动后画面不动

**原因**: PPU 寄存器写入问题 (#4)

**状态**: 
- CPU 正常运行
- PPU 渲染正常
- 但 PPUCTRL 写入失败
- NMI 中断无法触发

**临时解决方案**: 等待修复

**查看进度**: https://github.com/redoop/my6502/issues/4

---

### SDL 窗口无法打开

**问题**: 
```
SDL 初始化失败: Could not initialize video
```

**解决方案**:
```bash
# macOS
brew install sdl2

# Ubuntu/Debian
sudo apt-get install libsdl2-dev

# 检查安装
sdl2-config --version
```

---

### 控制器无响应

**问题**: 按键没有反应

**检查**:
1. SDL 窗口是否获得焦点
2. 使用正确的按键映射：
   - 方向键: ⬆️⬇️⬅️➡️
   - A: Z
   - B: X
   - Start: Enter
   - Select: RShift

**调试**:
```bash
# 查看控制器输出
./scripts/run.sh games/Donkey-Kong.nes 2>&1 | grep "Controller"
```

---

## 🧪 测试问题

### 测试失败

**问题**: `sbt test` 有测试失败

**步骤 1**: 查看详细日志
```bash
sbt test 2>&1 | tee test.log
```

**步骤 2**: 运行单个测试
```bash
sbt "testOnly cpu6502.instructions.FlagInstructionsSpec"
```

**步骤 3**: 清理并重试
```bash
./scripts/tools.sh clean
sbt test
```

---

### 测试超时

**问题**: 测试运行很久不结束

**解决方案**:
```bash
# 使用 timeout
timeout 60 sbt test

# 或运行快速测试
./scripts/test.sh quick
```

---

## 🔍 调试问题

### VCD 文件太大

**问题**: VCD trace 文件几个 GB

**解决方案**:
```bash
# 使用 fast 模式（无 trace）
./scripts/build.sh fast

# 或限制运行时间
timeout 5 ./scripts/run.sh games/xxx.nes
```

---

### 找不到 ROM 文件

**问题**: 
```
Error: Cannot open ROM file
```

**解决方案**:
```bash
# 检查 ROM 文件是否存在
ls -lh games/

# 使用正确的路径
./scripts/run.sh games/Donkey-Kong.nes

# 不要使用相对路径
# ❌ ./scripts/run.sh ../games/xxx.nes
# ✅ ./scripts/run.sh games/xxx.nes
```

---

### CPU 卡死

**问题**: CPU PC 不变化

**已修复**: v0.7.1 修复了 2 个关键 bug
- ✅ CPU Fetch 状态内存延迟
- ✅ PRG ROM 镜像映射

**如果还有问题**:
```bash
# 查看 CPU 状态
./scripts/run.sh games/xxx.nes 2>&1 | grep "PC="

# 反汇编 ROM
./scripts/debug.sh opcodes games/xxx.nes
```

---

## 📊 性能问题

### 内存占用高

**问题**: 进程占用几个 GB 内存

**原因**: 
- Verilator 仿真需要大量内存
- VCD trace 会占用更多内存

**解决方案**:
```bash
# 使用 fast 模式
./scripts/build.sh fast

# 限制运行时间
timeout 10 ./scripts/run.sh games/xxx.nes
```

---

### CPU 占用高

**问题**: CPU 占用 100%

**这是正常的！**
- Verilator 是单线程仿真
- 需要大量计算

**优化**:
```bash
# 使用优化构建
./scripts/build.sh optimized

# 减少批量处理大小
# 编辑 verilator/testbench_main.cpp
# 修改 for (int i = 0; i < 100; i++)
```

---

## 🐛 已知问题

### Issue #4: PPU 寄存器写入无效

**状态**: 🔴 Open  
**优先级**: High  
**影响**: 所有游戏无法进入主循环

**症状**:
- CPU 执行 `STA $2000`
- 但 PPUCTRL 保持 0x00
- NMI 中断无法触发

**临时解决方案**: 无，等待修复

**进度**: https://github.com/redoop/my6502/issues/4

---

## 🔧 环境问题

### macOS 特定问题

**问题**: Verilator 找不到

**解决方案**:
```bash
# 安装 Verilator
brew install verilator

# 检查路径
which verilator
```

---

### Linux 特定问题

**问题**: SDL2 头文件找不到

**解决方案**:
```bash
# Ubuntu/Debian
sudo apt-get install libsdl2-dev

# Fedora/RHEL
sudo dnf install SDL2-devel

# Arch
sudo pacman -S sdl2
```

---

## 📝 日志分析

### 查看详细日志

```bash
# CPU 状态
./scripts/run.sh games/xxx.nes 2>&1 | grep "PC="

# PPU 状态
./scripts/run.sh games/xxx.nes 2>&1 | grep "PPU"

# 控制器
./scripts/run.sh games/xxx.nes 2>&1 | grep "Controller"

# 保存完整日志
./scripts/run.sh games/xxx.nes 2>&1 | tee full.log
```

---

### 分析 VCD 波形

```bash
# 生成 VCD
./scripts/build.sh trace
./scripts/run.sh games/xxx.nes

# 使用 GTKWave 查看
gtkwave waveform.vcd
```

---

## 🆘 获取帮助

### 自助资源

1. **查看文档**
   - [完整文档索引](INDEX.md)
   - [游戏兼容性报告](GAME_COMPATIBILITY_REPORT.md)
   - [CPU 修复总结](logs/cpu_fix_summary.md)

2. **搜索 Issues**
   - https://github.com/redoop/my6502/issues
   - 可能已有相同问题

3. **查看日志**
   - `docs/logs/` 目录
   - 包含详细的调试信息

---

### 寻求帮助

如果以上方法都无法解决问题：

1. **创建 Issue**
   - https://github.com/redoop/my6502/issues/new
   - 使用 [Bug 报告模板](../CONTRIBUTING.md#1-报告-bug)

2. **提供信息**
   - 操作系统和版本
   - 软件版本（SBT、Verilator）
   - 完整的错误信息
   - 复现步骤
   - 相关日志

3. **示例 Issue**
   ```markdown
   **问题描述**
   运行 Donkey Kong 时 CPU 卡死
   
   **环境**
   - OS: macOS 14.0
   - Verilator: 5.042
   - SBT: 1.9.7
   
   **复现步骤**
   1. ./scripts/build.sh fast
   2. ./scripts/run.sh games/Donkey-Kong.nes
   3. CPU PC 卡在 0xC7A0
   
   **日志**
   ```
   [Cycle 30000] PC=0xC7A0 State=Execute
   [Cycle 40000] PC=0xC7A0 State=Execute
   ```
   ```

---

## 📚 相关文档

- [快速开始](QUICK_START.md)
- [开发指南](02_DEVELOPMENT_GUIDE.md)
- [调试指南](08_DEBUG_GUIDE.md)
- [贡献指南](../CONTRIBUTING.md)

---

**还有问题？** 创建 [Issue](https://github.com/redoop/my6502/issues/new) 寻求帮助！
