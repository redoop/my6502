# PPU & APU 测试快速参考

## 文档索引

| 文档 | 用途 | 链接 |
|------|------|------|
| 测试清单 | 完整的测试项目列表 | [PPU_APU_TEST_CHECKLIST.md](PPU_APU_TEST_CHECKLIST.md) |
| 实现指南 | 如何实现测试 | [PPU_APU_TEST_GUIDE.md](PPU_APU_TEST_GUIDE.md) |
| 进度追踪 | 测试完成情况 | [PPU_APU_TEST_PROGRESS.md](PPU_APU_TEST_PROGRESS.md) |

## 快速开始

### 1. 运行现有测试模板
```bash
cd /Users/tongxiaojun/github/my6502

# 编译测试
sbt compile

# 运行 PPU 寄存器测试
sbt "testOnly nes.ppu.PPURegisterSpec"

# 运行 APU 寄存器测试
sbt "testOnly nes.apu.APURegisterSpec"

# 运行 APU 功能模块测试
sbt "testOnly nes.apu.APUModuleSpec"
```

### 2. 测试文件位置
```
src/test/scala/nes/
├── ppu/
│   └── PPURegisterSpec.scala       ✅ 已创建 (模板)
└── apu/
    ├── APURegisterSpec.scala       ✅ 已创建 (模板)
    └── APUModuleSpec.scala         ✅ 已创建 (模板)
```

### 3. 下一步任务
1. 完善 `PPURegisterSpec.scala` 中的 TODO 项
2. 完善 `APURegisterSpec.scala` 中的 TODO 项
3. 完善 `APUModuleSpec.scala` 中的 TODO 项

## PPU 寄存器地址映射

| 寄存器 | 地址 | cpuAddr | 功能 |
|--------|------|---------|------|
| PPUCTRL | $2000 | 0 | 控制寄存器 |
| PPUMASK | $2001 | 1 | 掩码寄存器 |
| PPUSTATUS | $2002 | 2 | 状态寄存器 |
| OAMADDR | $2003 | 3 | OAM 地址 |
| OAMDATA | $2004 | 4 | OAM 数据 |
| PPUSCROLL | $2005 | 5 | 滚动寄存器 |
| PPUADDR | $2006 | 6 | VRAM 地址 |
| PPUDATA | $2007 | 7 | VRAM 数据 |

## APU 寄存器地址映射

| 寄存器 | 地址 | cpuAddr | 功能 |
|--------|------|---------|------|
| Pulse1_0 | $4000 | 0x00 | 占空比/包络/音量 |
| Pulse1_1 | $4001 | 0x01 | 扫描单元 |
| Pulse1_2 | $4002 | 0x02 | 定时器低字节 |
| Pulse1_3 | $4003 | 0x03 | 定时器高字节/长度 |
| Pulse2_0 | $4004 | 0x04 | 占空比/包络/音量 |
| Pulse2_1 | $4005 | 0x05 | 扫描单元 |
| Pulse2_2 | $4006 | 0x06 | 定时器低字节 |
| Pulse2_3 | $4007 | 0x07 | 定时器高字节/长度 |
| Triangle_0 | $4008 | 0x08 | 线性计数器 |
| Triangle_2 | $400A | 0x0A | 定时器低字节 |
| Triangle_3 | $400B | 0x0B | 定时器高字节/长度 |
| Noise_0 | $400C | 0x0C | 包络/音量 |
| Noise_2 | $400E | 0x0E | 模式/周期 |
| Noise_3 | $400F | 0x0F | 长度 |
| DMC_0 | $4010 | 0x10 | 频率/循环/IRQ |
| DMC_1 | $4011 | 0x11 | 直接加载 |
| DMC_2 | $4012 | 0x12 | 样本地址 |
| DMC_3 | $4013 | 0x13 | 样本长度 |
| Status | $4015 | 0x15 | 通道使能/状态 |
| FrameCtr | $4017 | 0x17 | 帧计数器 |

## 测试模式参考

### 基本寄存器写入测试
```scala
it should "write to register" in {
  test(new Module) { dut =>
    dut.io.cpuAddr.poke(addr.U)
    dut.io.cpuDataIn.poke(value.U)
    dut.io.cpuWrite.poke(true.B)
    dut.clock.step()
    
    // 验证
    dut.io.debug.register.expect(value.U)
  }
}
```

### 基本寄存器读取测试
```scala
it should "read from register" in {
  test(new Module) { dut =>
    dut.io.cpuAddr.poke(addr.U)
    dut.io.cpuRead.poke(true.B)
    dut.clock.step()
    
    // 验证
    dut.io.cpuDataOut.expect(expected.U)
  }
}
```

### 多周期功能测试
```scala
it should "test multi-cycle function" in {
  test(new Module) { dut =>
    // 初始化
    dut.io.input.poke(value.U)
    dut.clock.step()
    
    // 多个周期
    for (i <- 0 until cycles) {
      dut.io.clock.poke(true.B)
      dut.clock.step()
      dut.io.clock.poke(false.B)
      dut.clock.step()
    }
    
    // 验证最终状态
    dut.io.output.expect(expected.U)
  }
}
```

### 边界条件测试
```scala
it should "handle boundary condition" in {
  test(new Module) { dut =>
    // 测试最大值
    dut.io.input.poke(0xFF.U)
    dut.clock.step()
    
    // 测试最小值
    dut.io.input.poke(0x00.U)
    dut.clock.step()
    
    // 测试回绕
    dut.io.input.poke(0xFF.U)
    dut.io.increment.poke(true.B)
    dut.clock.step()
    dut.io.output.expect(0x00.U)
  }
}
```

## 常用测试断言

```scala
// 相等断言
dut.io.output.expect(0x42.U)

// 布尔断言
dut.io.flag.expect(true.B)
dut.io.flag.expect(false.B)

// 读取值（不断言）
val value = dut.io.output.peek().litValue
println(s"Output = $value")

// 条件断言
if (condition) {
  dut.io.output.expect(value1.U)
} else {
  dut.io.output.expect(value2.U)
}
```

## 调试技巧

### 1. 生成 VCD 波形
```scala
test(new Module).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
  // 测试代码
}
// 波形文件: test_run_dir/*/Module.vcd
```

### 2. 打印调试信息
```scala
println(s"Cycle $i: value = ${dut.io.output.peek().litValue}")
println(f"Hex: 0x${dut.io.output.peek().litValue}%02X")
```

### 3. 单步执行
```scala
for (i <- 0 until 10) {
  println(s"=== Cycle $i ===")
  dut.clock.step()
  println(s"Output: ${dut.io.output.peek().litValue}")
}
```

## 测试优先级

### P0 - 必须完成 (Week 1-2)
- PPU 寄存器测试: 40 tests
- APU 寄存器测试: 20 tests
- APU 功能模块测试: 35 tests
- **总计: 95 tests**

### P1 - 重要功能 (Week 3-4)
- PPU 内存测试: 20 tests
- PPU 渲染测试: 25 tests
- APU 通道测试: 20 tests
- **总计: 65 tests**

### P2 - 高级功能 (Week 5-6)
- PPU 时序测试: 15 tests
- **总计: 15 tests**

## 测试统计命令

```bash
# 查看测试数量
sbt "testOnly nes.*" | grep "Total number of tests"

# 查看通过率
sbt "testOnly nes.*" | grep "Tests:"

# 查看失败的测试
sbt "testOnly nes.*" | grep "FAILED"

# 生成测试报告
sbt "testOnly nes.*" 2>&1 | tee test_report.txt
```

## 参考链接

### NES 技术文档
- [NES Dev Wiki](http://wiki.nesdev.com/)
- [PPU Registers](http://wiki.nesdev.com/w/index.php/PPU_registers)
- [APU Registers](http://wiki.nesdev.com/w/index.php/APU)

### CPU 测试参考
- `src/test/scala/cpu/instructions/` - CPU 指令测试
- `src/test/scala/cpu6502/instructions/` - CPU 绝对寻址测试

### 现有 NES 测试
- `src/test/scala/nes/PPUv3Test.scala`
- `src/test/scala/nes/APUTest.scala`

## 快速命令

```bash
# 编译
sbt compile

# 运行所有测试
sbt test

# 运行 NES 测试
sbt "testOnly nes.*"

# 运行 PPU 测试
sbt "testOnly nes.ppu.*"

# 运行 APU 测试
sbt "testOnly nes.apu.*"

# 清理
sbt clean

# 查看测试覆盖率
sbt coverage test coverageReport
```
