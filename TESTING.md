# 快速测试参考

## 5 阶段测试流程

### ✅ Stage 1: 基础模块
```bash
sbt "testOnly cpu6502.core.CPU6502CoreSpec -- -z \"register\""
sbt "testOnly cpu6502.core.CPU6502CoreSpec -- -z \"memory\""
```

### ✅ Stage 2: 指令集 (122+ tests)
```bash
sbt "testOnly cpu6502.instructions.*"
```

### ✅ Stage 3: 子系统
```bash
sbt "testOnly cpu6502.core.CPU6502CoreSpec"
sbt "testOnly nes.ppu.PPURenderSpec"
```

### ✅ Stage 4: 系统集成
```bash
sbt "testOnly nes.NESIntegrationQuickSpec"
sbt "testOnly nes.GameCompatibilityQuickSpec"
```

### ✅ Stage 5: 硬件仿真
```bash
./scripts/build.sh fast
./scripts/run.sh
```

## 一键命令

```bash
# 完整流程
./scripts/tools.sh check && \
./scripts/test.sh all && \
./scripts/build.sh fast && \
./scripts/run.sh
```

## 详细文档

📖 [docs/BUILD_AND_TEST_GUIDE.md](docs/BUILD_AND_TEST_GUIDE.md)
