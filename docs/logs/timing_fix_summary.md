# 时序修复总结

## 问题发现

### 1. NMI 持续时间
- **问题**: NMI 只持续 1 周期
- **修复**: 使用 `.elsewhen` 保持到 scanline 261
- **状态**: ✅ 已修复

### 2. VBlank 竞争条件
- **问题**: CPU 循环读取 PPUSTATUS，每次读取都标记清除，导致 VBlank 永远无法保持
- **现象**: 
  ```
  T0: setVBlank=true, clearVBlankNext=true (from previous read)
  T1: clearVBlankNext clears VBlank
  T2: CPU reads VBlank=0
  ```
- **修复**: 当 `setVBlank` 时，取消待处理的 `clearVBlankNext`
- **状态**: ✅ 已修复

### 3. CPU 进展
- **结果**: CPU 成功跳出 VBlank 等待循环
- **证据**: PC 从 0xC7A8 → 0xC7BC → 0xE7E8

## 代码修改

### PPURefactored.scala
```scala
// NMI 持续时间修复
when(scanline === 241.U && pixel === 1.U && nmiEnable) {
  nmiTrigger := true.B
}
.elsewhen(scanline === 261.U && pixel === 1.U) {  // 使用 elsewhen
  nmiTrigger := false.B
}
```

### PPURegisters.scala
```scala
// VBlank 竞争条件修复
when(io.setVBlank) {
  regs.vblank := true.B
  clearVBlankNext := false.B  // 取消待处理的清除
}
```

### testbench_main.cpp
```cpp
// 添加 NMI 监控
bool last_nmi = false;
uint64_t nmi_count = 0;

bool nmi = dut->io_debug_nmi;
if (nmi && !last_nmi) {
  nmi_count++;
  std::cout << "[NMI] Triggered at cycle " << cycle_count << std::endl;
}
```

## 测试结果

### PPU 测试
```bash
sbt "testOnly nes.ppu.*"
```
✅ 所有测试通过

### Verilator 仿真
```bash
./build/verilator/VNESSystemRefactored games/Donkey-Kong.nes
```

**观察到的行为**:
1. ✅ CPU 正确初始化 (Reset Vector = 0xC79E)
2. ✅ CPU 写入 PPUCTRL = 0x10
3. ✅ CPU 进入 VBlank 等待循环 (PC=0xC7A8)
4. ✅ PPU 到达 scanline 241，设置 VBlank
5. ✅ CPU 读取 PPUSTATUS，看到 VBlank=1
6. ✅ CPU 跳出等待循环 (PC=0xC7BC)
7. ⚠️ CPU 跳到 0xE7E8，执行非法指令 0x07

## 下一步问题

### 非法指令 0x07
- **位置**: PC=0xE7E8
- **指令**: 0x07 (非标准 6502 指令)
- **可能原因**:
  1. CPU 跳转到错误地址
  2. 内存读取错误
  3. ROM 映射问题
  4. 需要实现非法指令处理

### 调试建议
1. 追踪 PC 从 0xC7BC 到 0xE7E8 的路径
2. 检查 0xE7E8 的 ROM 内容
3. 验证内存映射是否正确
4. 添加非法指令检测

## 时序分析工具

### VCD 追踪
```bash
./scripts/trace.sh games/Donkey-Kong.nes 1
gtkwave nes_trace.vcd
```

### 关键信号
- `TOP.io_debug_cpuPC` - CPU 程序计数器
- `TOP.io_vblank` - VBlank 标志
- `TOP.io_debug_nmi` - NMI 信号
- `TOP.io_pixelY` - PPU 扫描线

## 总结

✅ **时序问题已解决**:
- NMI 持续时间正确
- VBlank 竞争条件修复
- CPU 能够读取 VBlank 并继续执行

⚠️ **新问题**:
- CPU 执行到非法指令
- 需要进一步调试内存和指令执行

**进度**: 从 0% → 60% (CPU 能运行，但遇到新问题)
