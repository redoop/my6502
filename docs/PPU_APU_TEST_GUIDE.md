# PPU & APU 测试实现指南

本文档说明如何实现 PPU 和 APU 的测试程序集合。

## 测试文件组织

```
src/test/scala/nes/
├── ppu/
│   ├── PPURegisterSpec.scala       # PPU 寄存器测试 (40+ tests)
│   ├── PPUMemorySpec.scala         # PPU 内存测试 (20+ tests)
│   ├── PPURenderSpec.scala         # PPU 渲染测试 (25+ tests)
│   └── PPUTimingSpec.scala         # PPU 时序测试 (15+ tests)
└── apu/
    ├── APURegisterSpec.scala       # APU 寄存器测试 (20+ tests)
    ├── APUModuleSpec.scala         # APU 功能模块测试 (35+ tests)
    └── APUChannelSpec.scala        # APU 通道测试 (20+ tests)
```

## 测试模板说明

### 1. PPU 寄存器测试模板

参考: `src/test/scala/nes/ppu/PPURegisterSpec.scala`

**测试结构:**
```scala
class PPURegisterSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "PPU Registers - PPUCTRL ($2000)"
  
  it should "write to PPUCTRL" in {
    test(new PPUSimplified) { dut =>
      // 1. 设置输入
      dut.io.cpuAddr.poke(0.U)
      dut.io.cpuDataIn.poke(0x80.U)
      dut.io.cpuWrite.poke(true.B)
      
      // 2. 时钟步进
      dut.clock.step()
      
      // 3. 验证输出
      dut.io.debug.ppuCtrl.expect(0x80.U)
    }
  }
}
```

**测试要点:**
- 每个寄存器至少 5 个测试用例
- 测试读写操作
- 测试位字段功能
- 测试边界条件

### 2. APU 寄存器测试模板

参考: `src/test/scala/nes/apu/APURegisterSpec.scala`

**测试结构:**
```scala
class APURegisterSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "APU Registers - Pulse 1 ($4000-$4003)"
  
  it should "write to Pulse 1 register 0" in {
    test(new APU) { dut =>
      dut.io.cpuAddr.poke(0x00.U)
      dut.io.cpuDataIn.poke(0xBF.U)
      dut.io.cpuWrite.poke(true.B)
      dut.clock.step()
      
      // 验证寄存器写入
    }
  }
}
```

### 3. APU 功能模块测试模板

参考: `src/test/scala/nes/apu/APUModuleSpec.scala`

**测试结构:**
```scala
class APUModuleSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "APU Module - Envelope"
  
  it should "start envelope" in {
    test(new Envelope) { dut =>
      // 设置输入
      dut.io.start.poke(true.B)
      dut.io.loop.poke(false.B)
      dut.clock.step()
      
      // 验证状态
    }
  }
}
```

## 测试实现步骤

### Phase 1: PPU 寄存器测试 (优先级 P0)

**目标:** 完成 40+ PPU 寄存器测试

**步骤:**
1. 完善 `PPURegisterSpec.scala` 中的 TODO 项
2. 为每个寄存器添加 5+ 测试用例
3. 运行测试: `sbt "testOnly nes.ppu.PPURegisterSpec"`
4. 确保所有测试通过

**测试清单:**
- [ ] PPUCTRL: 8 tests (每个位字段1个)
- [ ] PPUMASK: 8 tests
- [ ] PPUSTATUS: 5 tests
- [ ] OAMADDR: 3 tests
- [ ] OAMDATA: 4 tests
- [ ] PPUSCROLL: 5 tests
- [ ] PPUADDR: 5 tests
- [ ] PPUDATA: 5 tests

### Phase 2: APU 寄存器测试 (优先级 P0)

**目标:** 完成 20+ APU 寄存器测试

**步骤:**
1. 完善 `APURegisterSpec.scala` 中的 TODO 项
2. 为每个通道添加测试
3. 运行测试: `sbt "testOnly nes.apu.APURegisterSpec"`

**测试清单:**
- [ ] Pulse 1: 4 tests
- [ ] Pulse 2: 4 tests
- [ ] Triangle: 3 tests
- [ ] Noise: 3 tests
- [ ] DMC: 4 tests
- [ ] Control: 2 tests

### Phase 3: APU 功能模块测试 (优先级 P0)

**目标:** 完成 35+ APU 功能模块测试

**步骤:**
1. 完善 `APUModuleSpec.scala`
2. 测试每个功能模块
3. 运行测试: `sbt "testOnly nes.apu.APUModuleSpec"`

**测试清单:**
- [ ] Envelope: 5 tests
- [ ] LengthCounter: 5 tests
- [ ] LinearCounter: 4 tests
- [ ] Sweep: 5 tests (待实现)
- [ ] Timer: 4 tests (待实现)
- [ ] FrameCounter: 6 tests (待实现)
- [ ] Mixer: 6 tests (待实现)

### Phase 4: PPU 内存测试 (优先级 P1)

**目标:** 完成 20+ PPU 内存测试

**步骤:**
1. 创建 `PPUMemorySpec.scala`
2. 测试各个内存区域
3. 运行测试: `sbt "testOnly nes.ppu.PPUMemorySpec"`

**测试清单:**
- [ ] Pattern Table: 4 tests
- [ ] Nametable: 6 tests
- [ ] Attribute Table: 3 tests
- [ ] Palette: 4 tests
- [ ] OAM: 3 tests

### Phase 5: PPU 渲染测试 (优先级 P1)

**目标:** 完成 25+ PPU 渲染测试

**步骤:**
1. 创建 `PPURenderSpec.scala`
2. 测试渲染功能
3. 运行测试: `sbt "testOnly nes.ppu.PPURenderSpec"`

### Phase 6: APU 通道测试 (优先级 P1)

**目标:** 完成 20+ APU 通道测试

**步骤:**
1. 创建 `APUChannelSpec.scala`
2. 测试各个音频通道
3. 运行测试: `sbt "testOnly nes.apu.APUChannelSpec"`

### Phase 7: 时序和集成测试 (优先级 P2)

**目标:** 完成 20+ 时序和集成测试

## 运行测试

### 运行所有 PPU 测试
```bash
sbt "testOnly nes.ppu.*"
```

### 运行所有 APU 测试
```bash
sbt "testOnly nes.apu.*"
```

### 运行所有 NES 测试
```bash
sbt "testOnly nes.*"
```

### 运行特定测试
```bash
sbt "testOnly nes.ppu.PPURegisterSpec"
sbt "testOnly nes.apu.APUModuleSpec"
```

## 测试覆盖率追踪

创建测试进度追踪文件:

```bash
# 查看测试统计
sbt "testOnly nes.*" | grep "Tests:"

# 预期输出示例:
# Tests: succeeded 95, failed 0, canceled 0, ignored 0, pending 0
```

## 调试技巧

### 1. 使用 VCD 波形
```scala
test(new PPUSimplified).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
  // 测试代码
}
```

### 2. 打印调试信息
```scala
println(s"PPUCTRL = ${dut.io.debug.ppuCtrl.peek().litValue}")
```

### 3. 单步调试
```scala
for (i <- 0 until 10) {
  dut.clock.step()
  println(s"Cycle $i: counter = ${dut.io.counter.peek().litValue}")
}
```

## 参考资料

### CPU 测试参考
- `src/test/scala/cpu/instructions/ArithmeticInstructionsSpec.scala`
- `src/test/scala/cpu/instructions/LoadStoreInstructionsSpec.scala`
- `src/test/scala/cpu6502/instructions/ArithmeticAbsoluteTestModule.scala`

### NES 文档
- [NES Dev Wiki - PPU](http://wiki.nesdev.com/w/index.php/PPU)
- [NES Dev Wiki - APU](http://wiki.nesdev.com/w/index.php/APU)
- [NES Dev Wiki - PPU Registers](http://wiki.nesdev.com/w/index.php/PPU_registers)
- [NES Dev Wiki - APU Registers](http://wiki.nesdev.com/w/index.php/APU)

### 现有测试
- `src/test/scala/nes/PPUv3Test.scala`
- `src/test/scala/nes/APUTest.scala`

## 下一步

1. 完成 Phase 1: PPU 寄存器测试 (40 tests)
2. 完成 Phase 2: APU 寄存器测试 (20 tests)
3. 完成 Phase 3: APU 功能模块测试 (35 tests)
4. 达到 P0 目标: 95+ 测试用例

目标: 在 2 周内完成 P0 和 P1 测试 (130+ 测试用例)
