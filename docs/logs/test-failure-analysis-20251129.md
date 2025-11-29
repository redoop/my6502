# 测试失败分析 - 2025-11-29

## 问题概述
运行 `sbt test` 时，227 个测试通过，88 个测试失败。

## 失败的测试套件
1. ❌ cpu6502.core.CPU6502CoreSpec (5/7 失败)
2. ❌ cpu6502.CPU6502Test
3. ❌ cpu6502.DebugTest
4. ❌ nes.GameCompatibilitySpec
5. ❌ nes.GameCompatibilityQuickSpec
6. ❌ nes.NESIntegrationSpec
7. ❌ nes.NESIntegrationQuickSpec
8. ❌ nes.ppu.PPUMemorySpec
9. ❌ nes.ppu.PPURegisterSpec
10. ❌ nes.ppu.PPURenderSpec

## 根本原因

### CPU6502Core 的 Reset 序列
CPU6502Core 从 `sReset` 状态开始，需要 **6 个时钟周期** 来读取 Reset Vector ($FFFC-$FFFD)：

```scala
val sReset :: sFetch :: sExecute :: sNMI :: sDone :: Nil = Enum(5)
val state = RegInit(sReset)  // 从 Reset 开始
```

Reset 序列：
- Cycle 0: 设置地址 $FFFC
- Cycle 1: 等待数据准备
- Cycle 2: 读取低字节
- Cycle 3: 设置地址 $FFFD
- Cycle 4: 等待数据准备
- Cycle 5: 读取高字节，设置 PC，进入 Fetch

### 测试代码的问题
测试代码直接开始执行指令，没有等待 Reset 完成：

```scala
it should "execute LDA immediate" in {
  test(new CPU6502Core) { dut =>
    // ❌ 直接 poke 指令，但 CPU 还在 Reset 状态
    dut.io.memDataIn.poke(0xA9.U)
    dut.clock.step()  // 只运行 1 个周期
    
    dut.io.memDataIn.poke(0x42.U)
    dut.clock.step()  // 只运行 2 个周期
    
    // ❌ 期望寄存器更新，但 CPU 还没进入 Fetch
    dut.io.debug.regA.expect(0x42.U)
  }
}
```

## 为什么 GameCompatibilityQuickSpec 通过？

`GameCompatibilityQuickSpec` 使用完整的 NES 系统，包含：
1. Memory Controller - 提供正确的 Reset Vector
2. 足够的运行周期 (100 cycles)
3. 完整的系统初始化

```scala
// ✅ 正确的测试方式
val nes = Module(new NESSystemv2(romData, chrData, mapper))
dut.clock.step(100)  // 运行足够的周期
```

## 解决方案

### 方案 1: 修复测试代码（推荐）
在每个测试开始时等待 Reset 完成：

```scala
it should "execute LDA immediate" in {
  test(new CPU6502Core) { dut =>
    // 1. 提供 Reset Vector
    dut.io.memDataIn.poke(0x00.U)  // PC = $0000
    dut.clock.step(6)  // 等待 Reset 完成
    
    // 2. 执行指令
    dut.io.memDataIn.poke(0xA9.U)  // LDA #$42
    dut.clock.step()
    
    dut.io.memDataIn.poke(0x42.U)
    dut.clock.step()
    
    // 3. 验证结果
    dut.io.debug.regA.expect(0x42.U)
  }
}
```

### 方案 2: 添加测试辅助函数
创建一个辅助函数来处理 Reset：

```scala
def waitForReset(dut: CPU6502Core, resetVector: Int = 0x0000): Unit = {
  val low = resetVector & 0xFF
  val high = (resetVector >> 8) & 0xFF
  
  // Cycle 0-2: 读取低字节
  dut.io.memDataIn.poke(low.U)
  dut.clock.step(3)
  
  // Cycle 3-5: 读取高字节
  dut.io.memDataIn.poke(high.U)
  dut.clock.step(3)
}

it should "execute LDA immediate" in {
  test(new CPU6502Core) { dut =>
    waitForReset(dut)  // ✅ 等待 Reset
    
    // 执行测试...
  }
}
```

### 方案 3: 修改 CPU6502Core（不推荐）
添加一个 `skipReset` 参数，但这会破坏硬件的真实性。

## 影响范围

需要修复的测试文件：
1. `src/test/scala/cpu/core/CPU6502CoreSpec.scala` (7 tests)
2. `src/test/scala/cpu/CPU6502Test.scala`
3. `src/test/scala/cpu/DebugTest.scala`
4. 其他直接测试 CPU Core 的测试

不需要修复的测试：
- ✅ 所有 instruction 测试 (65 tests) - 使用 CPU6502Refactored
- ✅ GameCompatibilityQuickSpec - 使用完整 NES 系统
- ✅ 其他使用完整系统的测试

## 下一步行动

1. **立即**: 修复 CPU6502CoreSpec.scala
2. **然后**: 修复其他 CPU 测试
3. **最后**: 验证所有测试通过

## 验证命令

```bash
# 测试单个文件
sbt "testOnly cpu6502.core.CPU6502CoreSpec"

# 测试所有 CPU 测试
sbt "testOnly cpu6502.*"

# 运行所有测试
sbt test
```

## 时间估计
- 修复 CPU6502CoreSpec: 10 分钟
- 修复其他 CPU 测试: 20 分钟
- 验证所有测试: 5 分钟
- **总计**: ~35 分钟
