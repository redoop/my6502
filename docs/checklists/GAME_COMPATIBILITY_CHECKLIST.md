# 游戏兼容性测试清单

## 🎯 快速检查清单

### 前置条件 (5 阶段)
- [ ] Stage 1: 基础模块 (寄存器、内存)
- [ ] Stage 2: 指令集 (122+ tests)
- [ ] Stage 3: 子系统 (CPU、PPU)
- [ ] Stage 4: NES 集成
- [ ] Stage 5: Verilator 仿真

### 单个游戏测试 (5 步骤)
- [ ] 1. ROM 分析: `sbt "runMain nes.ROMAnalyzer \"games/<game>.nes\""`
- [ ] 2. 系统初始化: `sbt "testOnly nes.GameCompatibilityQuickSpec -- -z \"<游戏名>\""`
- [ ] 3. Verilator 编译: `./scripts/build.sh fast`
- [ ] 4. 短时运行: `timeout 5 ./scripts/run.sh games/<game>.nes`
- [ ] 5. 完整测试: `./scripts/run.sh games/<game>.nes`

### 当前游戏库
- [ ] Donkey Kong (Mapper 0) - ✅ 通过
- [ ] Super Mario Bros (Mapper 4) - ✅ 通过
- [ ] Super Contra X (Mapper 4) - ✅ 通过

---

## 📋 详细说明

### 测试前置条件检查

在开始游戏测试前，必须确认以下 5 个阶段全部通过：

#### Stage 1: 基础模块测试
```bash
sbt "testOnly cpu6502.core.CPU6502CoreSpec -- -z \"register\""
sbt "testOnly cpu6502.core.CPU6502CoreSpec -- -z \"memory\""
```

#### Stage 2: 指令集测试 (122+ tests)
```bash
sbt "testOnly cpu6502.instructions.*"
```

#### Stage 3: 子系统测试
```bash
sbt "testOnly cpu6502.core.CPU6502CoreSpec"
sbt "testOnly nes.ppu.PPURenderSpec"
```

#### Stage 4: NES 系统集成
```bash
sbt "testOnly nes.NESIntegrationQuickSpec"
sbt "testOnly nes.GameCompatibilityQuickSpec"
```

#### Stage 5: Verilator 硬件仿真
```bash
./scripts/build.sh fast
./scripts/run.sh
```

---

## 📝 单个游戏测试流程

### 1️⃣ ROM 分析
```bash
sbt "runMain nes.ROMAnalyzer \"games/<game>.nes\""
```
检查: ROM 格式、Mapper、PRG/CHR 大小、Mirroring

### 2️⃣ 系统初始化测试
```bash
sbt "testOnly nes.GameCompatibilityQuickSpec -- -z \"<游戏名>\""
```
检查: ROM 加载、系统初始化、Reset Vector、内存映射

### 3️⃣ Verilator 编译检查
```bash
./scripts/build.sh fast
```
检查: Verilog 生成、C++ 编译、可执行文件

### 4️⃣ 短时运行测试 (5秒)
```bash
timeout 5 ./scripts/run.sh games/<game>.nes
```
检查: 启动无崩溃、CPU/PPU 正常、窗口显示

### 5️⃣ 完整功能测试 (手动)
```bash
./scripts/run.sh games/<game>.nes
```
检查: 标题画面、菜单、移动、碰撞、音效、滚动、动画、FPS ≥ 3

---

## 🔍 问题诊断

失败时按顺序检查:
1. ROM 问题 → 验证文件完整性、格式、Mapper
2. 系统初始化 → 检查 Reset Vector、内存映射、PPU 初始化
3. 编译问题 → 检查 Chisel 语法、Verilog 生成、C++ 环境
4. 运行时问题 → 查看 CPU/PPU 日志、内存访问、使用 `./scripts/debug.sh`
5. 性能问题 → 分析 FPS、渲染瓶颈

---

## 📊 测试记录模板

**游戏**: _______________  
**日期**: _______________

**ROM 信息**:
- Mapper: ___ | PRG: ___ | CHR: ___ | Mirroring: ___

**测试结果**:
- [ ] ROM 分析 | [ ] 系统初始化 | [ ] Verilator 编译 | [ ] 短时运行 | [ ] 完整功能

**性能**: FPS: ___ | 内存: ___ | CPU: ___

**兼容性**: [ ] 完全 (95-100%) | [ ] 基本 (80-94%) | [ ] 部分 (50-79%) | [ ] 不兼容 (<50%)

**问题**: _______________

---

## 🎯 测试目标

- **短期**: 测试现有 3 游戏，记录结果
- **中期**: 添加 5+ 游戏，支持更多 Mapper，FPS 10+
- **长期**: 测试 20+ 游戏，60 FPS，完整兼容性

---

## 📚 相关文档

- [游戏兼容性](07_GAME_COMPATIBILITY.md)
- [测试指南](03_TESTING_GUIDE.md)
- [调试指南](08_DEBUG_GUIDE.md)

---

**版本**: v1.1 | **更新**: 2025-11-29
