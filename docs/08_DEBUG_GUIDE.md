# 调试指南

## 概述

本文档提供 NES 模拟器的调试方法、工具和技巧。

## 调试工具

### 1. ChiselTest

Chisel 内置的测试框架，支持单元测试和集成测试。

```scala
test(new NESSystem) { dut =>
  // peek: 读取信号值
  val pc = dut.io.debug.pc.peek()
  
  // poke: 设置信号值
  dut.io.cpuWrite.poke(true.B)
  
  // step: 推进时钟
  dut.clock.step(1)
}
```

### 2. VCD 波形分析

生成波形文件用于详细分析。

```bash
# 生成 VCD 文件
./scripts/test_reset_trace.sh

# 使用 GTKWave 查看
gtkwave nes_trace.vcd
```

### 3. Verilator 调试

使用 Verilator 进行硬件级仿真。

```bash
# 编译调试版本
./scripts/verilator_build.sh

# 运行并查看日志
./build/verilator/VNESSystem games/game.nes 2>&1 | tee debug.log
```

### 4. 最小化测试程序

快速调试特定问题。

```bash
# 编译最小化版本
./scripts/build_minimal.sh

# 运行指定周期数
./build/minimal/VNESSystem games/game.nes 10000
```

## 调试方法

### CPU 调试

#### 查看 CPU 状态

```scala
println(f"PC: 0x${dut.io.debug.regPC.peek().litValue}%04X")
println(f"A:  0x${dut.io.debug.regA.peek().litValue}%02X")
println(f"X:  0x${dut.io.debug.regX.peek().litValue}%02X")
println(f"Y:  0x${dut.io.debug.regY.peek().litValue}%02X")
println(f"SP: 0x${dut.io.debug.regSP.peek().litValue}%02X")
println(f"P:  0x${dut.io.debug.regP.peek().litValue}%02X")
```

#### 单步执行

```scala
for (i <- 0 until 100) {
  val pc = dut.io.debug.regPC.peek().litValue
  val opcode = dut.io.debug.opcode.peek().litValue
  println(f"[$i] PC: 0x$pc%04X, Opcode: 0x$opcode%02X")
  dut.clock.step(1)
}
```

#### 断点调试

```scala
var breakpoint = 0x8000
while (true) {
  val pc = dut.io.debug.regPC.peek().litValue
  if (pc == breakpoint) {
    println(s"Hit breakpoint at 0x${pc.toHexString}")
    // 检查状态
    break
  }
  dut.clock.step(1)
}
```

#### 追踪指令执行

```scala
var instructionCount = 0
val instructionLog = scala.collection.mutable.ArrayBuffer[(Int, Int)]()

for (i <- 0 until 10000) {
  val pc = dut.io.debug.regPC.peek().litValue.toInt
  val opcode = dut.io.debug.opcode.peek().litValue.toInt
  instructionLog += ((pc, opcode))
  dut.clock.step(1)
}

// 分析最常用的指令
val opcodeFreq = instructionLog.groupBy(_._2).mapValues(_.size)
opcodeFreq.toSeq.sortBy(-_._2).take(10).foreach { case (op, count) =>
  println(f"Opcode 0x$op%02X: $count times")
}
```

### PPU 调试

#### 查看 PPU 状态

```scala
println(f"PPUCTRL:   0x${dut.io.ppuCtrl.peek().litValue}%02X")
println(f"PPUMASK:   0x${dut.io.ppuMask.peek().litValue}%02X")
println(f"PPUSTATUS: 0x${dut.io.ppuStatus.peek().litValue}%02X")
println(f"Scanline:  ${dut.io.scanline.peek().litValue}")
println(f"Cycle:     ${dut.io.cycle.peek().litValue}")
```

#### 等待 VBlank

```scala
// 等待 VBlank 开始
while (!dut.io.vblank.peek().litToBoolean) {
  dut.clock.step(1)
}
println("VBlank started")

// 等待 VBlank 结束
while (dut.io.vblank.peek().litToBoolean) {
  dut.clock.step(1)
}
println("VBlank ended")
```

#### 检查渲染输出

```scala
// 运行一帧
for (i <- 0 until 89342) {  // 262 * 341
  dut.clock.step(1)
}

// 检查像素数据
val pixel = dut.io.pixelOut.peek().litValue
val r = (pixel >> 16) & 0xFF
val g = (pixel >> 8) & 0xFF
val b = pixel & 0xFF
println(f"Pixel: R=$r%02X G=$g%02X B=$b%02X")
```

#### 检查 VRAM 内容

```scala
// 设置 PPUADDR
dut.io.cpuAddr.poke(6.U)  // PPUADDR
dut.io.cpuDataIn.poke(0x20.U)
dut.io.cpuWrite.poke(true.B)
dut.clock.step(1)
dut.io.cpuDataIn.poke(0x00.U)
dut.clock.step(1)

// 读取 PPUDATA
dut.io.cpuAddr.poke(7.U)  // PPUDATA
dut.io.cpuRead.poke(true.B)
dut.clock.step(1)
val data = dut.io.cpuDataOut.peek().litValue
println(f"VRAM[$2000]: 0x$data%02X")
```

### APU 调试

#### 查看 APU 状态

```scala
println(f"APU Status: 0x${dut.io.apuStatus.peek().litValue}%02X")
println(f"Pulse 1 enabled: ${(dut.io.apuStatus.peek().litValue & 0x01) != 0}")
println(f"Pulse 2 enabled: ${(dut.io.apuStatus.peek().litValue & 0x02) != 0}")
println(f"Triangle enabled: ${(dut.io.apuStatus.peek().litValue & 0x04) != 0}")
println(f"Noise enabled: ${(dut.io.apuStatus.peek().litValue & 0x08) != 0}")
```

#### 测试音频输出

```scala
// 配置 Pulse 1
dut.io.cpuAddr.poke(0x4000.U)
dut.io.cpuDataIn.poke(0x48.U)  // duty=25%, volume=8
dut.io.cpuWrite.poke(true.B)
dut.clock.step(1)

// 启用通道
dut.io.cpuAddr.poke(0x4015.U)
dut.io.cpuDataIn.poke(0x01.U)
dut.clock.step(1)

// 检查音频样本
for (i <- 0 until 100) {
  dut.clock.step(1)
  if (dut.io.audioSampleValid.peek().litToBoolean) {
    val sample = dut.io.audioSample.peek().litValue
    println(f"Audio sample: 0x$sample%04X")
  }
}
```

### 内存调试

#### 内存转储

```scala
def dumpMemory(dut: NESSystem, start: Int, length: Int): Unit = {
  println(f"Memory dump from 0x$start%04X:")
  for (i <- 0 until length by 16) {
    print(f"${start + i}%04X: ")
    for (j <- 0 until 16) {
      if (i + j < length) {
        dut.io.cpuAddr.poke((start + i + j).U)
        dut.io.cpuRead.poke(true.B)
        dut.clock.step(1)
        val data = dut.io.cpuDataOut.peek().litValue
        print(f"$data%02X ")
      }
    }
    println()
  }
}

// 使用
dumpMemory(dut, 0x0000, 256)
```

#### 监视内存写入

```scala
var lastWrite = (0, 0)
for (i <- 0 until 10000) {
  if (dut.io.cpuWrite.peek().litToBoolean) {
    val addr = dut.io.cpuAddr.peek().litValue.toInt
    val data = dut.io.cpuDataIn.peek().litValue.toInt
    if ((addr, data) != lastWrite) {
      println(f"Memory write: [$addr%04X] = 0x$data%02X")
      lastWrite = (addr, data)
    }
  }
  dut.clock.step(1)
}
```

## 常见问题诊断

### 问题：游戏不启动

**检查清单**:
1. Reset vector 是否正确读取
2. PC 是否跳转到正确地址
3. ROM 是否正确加载

**调试方法**:
```scala
// 检查 reset vector
println(f"Reset vector: 0x${dut.io.debug.resetVector.peek().litValue}%04X")

// 检查初始 PC
dut.clock.step(10)
println(f"Initial PC: 0x${dut.io.debug.regPC.peek().litValue}%04X")
```

### 问题：画面不显示

**检查清单**:
1. PPUCTRL 是否启用 NMI
2. PPUMASK 是否启用渲染
3. VRAM 是否有数据
4. 调色板是否设置

**调试方法**:
```scala
// 检查 PPU 寄存器
val ppuctrl = dut.io.ppuCtrl.peek().litValue
val ppumask = dut.io.ppuMask.peek().litValue
println(f"PPUCTRL: 0x$ppuctrl%02X (NMI: ${(ppuctrl & 0x80) != 0})")
println(f"PPUMASK: 0x$ppumask%02X (BG: ${(ppumask & 0x08) != 0}, SPR: ${(ppumask & 0x10) != 0})")
```

### 问题：精灵不显示

**检查清单**:
1. OAM 数据是否正确
2. Y 坐标是否在可见范围 (0-239)
3. X 坐标是否在可见范围 (0-255)
4. PPUMASK bit 4 是否启用

**调试方法**:
```scala
// 检查 OAM 数据
for (i <- 0 until 8) {
  val y = dut.io.oam(i * 4).peek().litValue
  val tile = dut.io.oam(i * 4 + 1).peek().litValue
  val attr = dut.io.oam(i * 4 + 2).peek().litValue
  val x = dut.io.oam(i * 4 + 3).peek().litValue
  println(f"Sprite $i: Y=$y%02X Tile=$tile%02X Attr=$attr%02X X=$x%02X")
}
```

### 问题：音频不播放

**检查清单**:
1. APU 通道是否启用
2. 音量是否设置
3. 周期是否正确
4. 音频采样是否输出

**调试方法**:
```scala
// 检查 APU 状态
val status = dut.io.apuStatus.peek().litValue
println(f"APU Status: 0x$status%02X")
println(f"Pulse 1: ${(status & 0x01) != 0}")
println(f"Pulse 2: ${(status & 0x02) != 0}")
println(f"Triangle: ${(status & 0x04) != 0}")
println(f"Noise: ${(status & 0x08) != 0}")
```

### 问题：性能太慢

**检查清单**:
1. 是否有过多的调试输出
2. 编译优化是否启用
3. 是否有死循环

**优化方法**:
```bash
# 使用优化编译
verilator --cc -O3 ...

# 减少调试输出
# 注释掉不必要的 printf

# 使用 profiler
perf record ./build/verilator/VNESSystem game.nes
perf report
```

## 调试脚本

### 自动化测试脚本

```bash
#!/bin/bash
# test_game.sh

GAME=$1
CYCLES=${2:-100000}

echo "Testing $GAME for $CYCLES cycles..."

./build/minimal/VNESSystem "$GAME" $CYCLES 2>&1 | tee test_output.log

# 分析输出
echo "Analyzing output..."
grep "PC:" test_output.log | tail -20
grep "Error" test_output.log
```

### 比较测试脚本

```bash
#!/bin/bash
# compare_output.sh

GAME=$1

# 运行我们的模拟器
./build/verilator/VNESSystem "$GAME" > our_output.log 2>&1

# 运行参考模拟器（如 FCEUX）
fceux --loadlua trace.lua "$GAME" > ref_output.log 2>&1

# 比较输出
diff our_output.log ref_output.log
```

## 性能分析

### 使用 perf

```bash
# 记录性能数据
perf record -g ./build/verilator/VNESSystem game.nes

# 查看报告
perf report

# 查看热点函数
perf top
```

### 使用 valgrind

```bash
# 检查内存泄漏
valgrind --leak-check=full ./build/verilator/VNESSystem game.nes

# 性能分析
valgrind --tool=callgrind ./build/verilator/VNESSystem game.nes
kcachegrind callgrind.out.*
```

## 日志分析

### 执行日志分析

```python
# analyze_execution.py
import sys

def analyze_log(filename):
    pc_freq = {}
    opcode_freq = {}
    
    with open(filename) as f:
        for line in f:
            if 'PC:' in line:
                parts = line.split()
                pc = int(parts[1], 16)
                pc_freq[pc] = pc_freq.get(pc, 0) + 1
                
                if 'Opcode:' in line:
                    opcode = int(parts[3], 16)
                    opcode_freq[opcode] = opcode_freq.get(opcode, 0) + 1
    
    print("Top 10 PC addresses:")
    for pc, count in sorted(pc_freq.items(), key=lambda x: -x[1])[:10]:
        print(f"  0x{pc:04X}: {count} times")
    
    print("\nTop 10 opcodes:")
    for op, count in sorted(opcode_freq.items(), key=lambda x: -x[1])[:10]:
        print(f"  0x{op:02X}: {count} times")

if __name__ == '__main__':
    analyze_log(sys.argv[1])
```

## 相关文档

- [项目概述](01_PROJECT_OVERVIEW.md)
- [开发指南](02_DEVELOPMENT_GUIDE.md)
- [测试指南](03_TESTING_GUIDE.md)
- [CPU 实现详解](06_CPU_IMPLEMENTATION.md)
- [游戏兼容性](07_GAME_COMPATIBILITY.md)

---
**最后更新**: 2025-11-28  
**版本**: v0.8.0
