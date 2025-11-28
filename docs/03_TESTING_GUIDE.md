# 测试指南

## 测试概述

本项目包含多层次的测试：单元测试、集成测试和游戏测试。

## 测试类型

### 1. 单元测试

测试单个模块的功能。

```bash
# 运行所有单元测试
sbt test

# 运行特定测试
sbt "testOnly *CPU6502Test"
```

### 2. 集成测试

测试模块间的交互。

```bash
./scripts/run_tests.sh
```

### 3. 游戏测试

使用实际 ROM 测试。

```bash
./scripts/verilator_run.sh games/Donkey-Kong.nes
```

## 测试工具

### 最小化测试程序

用于快速调试：

```bash
# 编译
./scripts/build_minimal.sh

# 运行（指定周期数）
./build/minimal/VNESSystem games/Donkey-Kong.nes 10000
```

### VCD 波形分析

生成波形文件用于调试：

```bash
# 生成 VCD
./scripts/test_reset_trace.sh

# 分析 VCD
python3 scripts/analyze_vcd.py nes_trace.vcd
```

### 执行日志分析

分析 CPU 执行轨迹：

```bash
# 捕获日志
./build/verilator/VNESSystem games/Donkey-Kong.nes 2>&1 | tee execution.log

# 分析日志
python3 scripts/analyze_execution.py execution.log
```

## 测试场景

### CPU 指令测试

验证指令实现的正确性：

```scala
class ArithmeticTest extends AnyFlatSpec with ChiselScalatestTester {
  "ADC" should "correctly add with carry" in {
    test(new CPU6502Core) { dut =>
      // 测试 ADC 指令
      dut.io.memDataIn.poke(0x69.U)  // ADC immediate
      dut.clock.step()
      // 验证结果
    }
  }
}
```

### PPU 渲染测试

验证渲染管道：

```bash
# 测试 PPU 渲染
./scripts/test_ppu_render.sh
```

### Reset 序列测试

验证 CPU 启动：

```bash
./scripts/test_reset.sh
```

## 测试结果

### CPU 指令覆盖率

- **已实现**: 124/151 (82%)
- **测试通过**: 100%

### PPU 功能测试

- **背景渲染**: ✅ 通过
- **精灵渲染**: ✅ 通过（8 个精灵）
- **VBlank**: ✅ 通过
- **调色板**: ✅ 通过

### 游戏兼容性

- **Donkey Kong**: ✅ 可运行
- **其他游戏**: 待测试

## 性能测试

### FPS 测试

```bash
# 运行并观察 FPS
./build/verilator/VNESSystem games/Donkey-Kong.nes
```

当前性能：
- FPS: 2-3
- 目标: 60

### 内存测试

检查内存使用：

```bash
# 使用 valgrind
valgrind --leak-check=full ./build/verilator/VNESSystem games/Donkey-Kong.nes
```

## 调试测试失败

### 1. 查看日志

```bash
# 详细日志
./build/verilator/VNESSystem games/Donkey-Kong.nes --verbose
```

### 2. 使用 GDB

```bash
gdb ./build/verilator/VNESSystem
(gdb) run games/Donkey-Kong.nes
(gdb) bt  # 查看堆栈
```

### 3. 检查波形

使用 GTKWave 查看 VCD 文件：

```bash
gtkwave nes_trace.vcd
```

## 持续集成

### GitHub Actions

项目使用 GitHub Actions 进行 CI：

```yaml
# .github/workflows/test.yml
name: Test
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run tests
        run: sbt test
```

## 测试最佳实践

1. **编写测试先行** - TDD 方法
2. **保持测试独立** - 每个测试应该独立运行
3. **使用有意义的名称** - 测试名称应该描述测试内容
4. **测试边界条件** - 测试极端情况
5. **定期运行测试** - 每次提交前运行测试

## 已知问题

1. **性能** - FPS 较低，需要优化
2. **精灵** - 只支持前 8 个精灵
3. **滚动** - 尚未实现

## 测试清单

- [x] CPU Reset 序列
- [x] 基础指令执行
- [x] 内存读写
- [x] PPU 背景渲染
- [x] PPU 精灵渲染
- [x] VBlank 和 NMI
- [x] 游戏启动
- [ ] 完整游戏流程
- [ ] 音频输出
- [ ] 保存/加载

---
**最后更新**: 2025-11-28
