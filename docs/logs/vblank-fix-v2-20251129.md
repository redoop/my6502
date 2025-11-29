# VBlank 修复总结 v2 - 2025-11-29 19:40

## 问题回顾

Donkey Kong 卡在 VBlank 等待循环：
```
PC: 0xC7A8-0xC7AE (循环)
代码: LDA $2002 (PPUSTATUS) / AND #$80 / BEQ (跳回去)
```

## 修复过程

### 修复 1: VBlank 时序 ✅
**问题**: VBlank 在 pixel 2 生效，而不是 pixel 1
**修复**: 在 pixel 0 设置，pixel 1 生效
```scala
// Before
when(scanline === 241.U && pixel === 1.U) {
  vblankFlag := true.B  // pixel 2 生效
}

// After
when(scanline === 241.U && pixel === 0.U) {
  vblankFlag := true.B  // pixel 1 生效
}
```

### 修复 2: VBlank 清除 ✅
**问题**: 读取 PPUSTATUS 后 VBlank 没有被清除
**原因**: `io.vblank` 连接到 `vblankFlag`，但清除的是 `regs.vblank`
**修复**: 在 PPURefactored 中添加读取清除逻辑
```scala
// 读取 PPUSTATUS 清除 VBlank
when(io.cpuRead && io.cpuAddr === 2.U) {
  vblankFlag := false.B
}
```

## 单元测试验证

### 测试 1: VBlank 生成 ✅
```scala
test(new PPURefactored) { dut =>
  dut.clock.step(241 * 341 + 1)
  dut.io.vblank.expect(true.B)  // ✅ 通过
}
```

### 测试 2: VBlank 持久性 ✅
```scala
// VBlank 应该保持直到读取
for (i <- 1 to 10) {
  dut.clock.step(100)
  assert(vblank == 1)  // ✅ 通过
}
```

### 测试 3: VBlank 清除 ✅
```scala
dut.io.cpuRead.poke(true.B)
dut.clock.step(1)
dut.io.vblank.expect(false.B)  // ✅ 通过
```

### 测试 4: PPUSTATUS 读取时序 ✅
```scala
// CPU 能在读取时看到 VBlank=1
dut.io.cpuRead.poke(true.B)
val status = dut.io.cpuDataOut.peek().litValue
assert((status & 0x80) != 0)  // ✅ 通过
```

## 当前状态

### Chisel 测试 ✅
- ✅ VBlank 在 scanline 241 pixel 1 设置
- ✅ PPUSTATUS bit 7 正确返回 VBlank
- ✅ 读取后 VBlank 被清除
- ✅ NMI 在 VBlank 开始时触发

### Verilator 仿真 ⚠️
- ⚠️ CPU 还是卡在循环
- ✅ VBlank 在闪烁（说明设置和清除都工作）
- ❌ CPU 没有跳出循环

## 可能的问题

### 1. 内存读取延迟
Verilator 使用 `SyncReadMem`，读取有 1 个周期延迟：
```scala
val prgData = prgRom.read(prgAddr)  // 下一个周期才有数据
```

CPU 可能在读取 PPUSTATUS 时，数据还没准备好。

### 2. CPU 读取时序
CPU 的 Fetch/Execute 状态机可能需要多个周期才能完成 PPUSTATUS 读取。

### 3. PPU 寄存器映射
NES 的 PPU 寄存器在 $2000-$2007，但有镜像到 $2008-$3FFF。
可能需要检查地址映射。

## 下一步调试

### 方案 1: 添加详细日志
在 Verilator testbench 中添加 PPUSTATUS 读取日志：
```cpp
if (cpu_addr == 0x2002 && cpu_read) {
  printf("CPU Read PPUSTATUS = 0x%02x at PC=0x%04x\n", 
         ppu_status, cpu_pc);
}
```

### 方案 2: 单步调试
使用 VCD 波形查看：
```bash
./scripts/build.sh trace
./scripts/run.sh games/Donkey-Kong.nes
gtkwave dump.vcd
```

### 方案 3: 简化测试
创建一个最小的 ROM 来测试 VBlank 等待：
```asm
loop:
  LDA $2002  ; Read PPUSTATUS
  AND #$80   ; Check VBlank
  BEQ loop   ; Loop if not set
  ; Continue...
```

## 测试文件

创建的测试文件：
1. `PPUVBlankTest.scala` - VBlank 基本功能
2. `PPUVBlankDebugTest.scala` - 逐周期调试
3. `PPUStatusClearTest.scala` - VBlank 清除
4. `PPUStatusReadTimingTest.scala` - 读取时序

## 总结

✅ **Chisel 层面**: VBlank 功能完全正确
⚠️ **Verilator 层面**: 需要进一步调试

**可能原因**:
1. 内存读取延迟
2. CPU 状态机时序
3. 地址映射问题

**建议**:
- 添加详细日志
- 使用 VCD 波形分析
- 创建简化测试 ROM

**时间**: 60 分钟
- VBlank 时序修复: 15 分钟
- VBlank 清除修复: 20 分钟
- 测试验证: 25 分钟
