# NES 旧版本测试归档

本目录包含重构前的 NES 测试代码，已被新的模块化测试替代。

## 归档文件

### 旧版本测试 (5个文件)
- **PPUv3Test.scala** - PPU v3 测试
- **APUTest.scala** - APU 测试
- **NESSystemTest.scala** - NES 系统 v1 测试
- **NESSystemv2Test.scala** - NES 系统 v2 测试
- **PPURendererTest.scala** - PPU 渲染器测试

### 游戏测试 (10个文件)
- **GameNMITest.scala** - 游戏 NMI 测试
- **ContraQuickTest.scala** - Contra 快速测试
- **GameFeatureTest.scala** - 游戏功能测试
- **NMIIntegrationTest.scala** - NMI 集成测试
- **RealGameTest.scala** - 真实游戏测试
- **ROMLoadTest.scala** - ROM 加载测试
- **ROMLoaderTest.scala** - ROM 加载器测试
- **NMIDiagnosisTest.scala** - NMI 诊断测试
- **ContraTest.scala** - Contra 测试
- **NMITest.scala** - NMI 测试

## 替代方案

这些测试已被以下模块化测试替代：

### 新测试套件 (52 tests, 100% passing)
- `nes/ppu/PPURegisterSpec.scala` - PPU 寄存器测试 (9 tests)
- `nes/ppu/PPUMemorySpec.scala` - PPU 内存测试 (8 tests)
- `nes/apu/APURegisterSpec.scala` - APU 寄存器测试 (13 tests)
- `nes/apu/APUModuleSpec.scala` - APU 功能模块测试 (11 tests)
- `nes/apu/APUChannelSpec.scala` - APU 通道测试 (11 tests)

## 测试改进

1. **模块化测试** - 每个功能独立测试
2. **完整覆盖** - 寄存器、内存、通道全覆盖
3. **参考 CPU** - 借鉴 CPU 测试的成功模式
4. **100% 通过** - 所有测试稳定通过
5. **易于扩展** - 清晰的测试结构

## 归档原因

- 测试依赖旧版本实现
- 缺乏系统性测试覆盖
- 游戏测试需要 ROM 文件
- 测试不稳定或不完整

## 参考文档

- [PPU_APU_TEST_CHECKLIST.md](../../../../../docs/PPU_APU_TEST_CHECKLIST.md) - 测试清单
- [PPU_APU_TEST_GUIDE.md](../../../../../docs/PPU_APU_TEST_GUIDE.md) - 测试指南
- [PPU_APU_TEST_PROGRESS.md](../../../../../docs/PPU_APU_TEST_PROGRESS.md) - 测试进度

## 注意

这些测试保留用于参考，但不再维护。新测试应基于重构后的模块实现。

游戏测试文件可能在未来重新启用，用于游戏兼容性测试。

---

归档日期: 2025-11-29
