# VBlank 问题单元测试需求

## 问题描述

**日期**: 2025-11-29  
**优先级**: 🔴 Critical  
**影响**: 所有游戏无法启动

### 现象

1. CPU 卡在初始化循环：
   ```
   PC: 0xC7A8-0xC7AD (循环)
   指令: LDA $2002 (读 PPUSTATUS)
         AND #$80  (检查 VBlank 位)
         BEQ -14   (如果 VBlank=0，跳回去)
   ```

2. PPUSTATUS 始终返回 `0x40` (VBlank=0)

3. PPU 正在渲染：
   ```
   pixelX/Y 变化正常
   帧率: 12-16 FPS
   ```

4. 游戏窗口显示黑屏/灰屏

---

## 需要测试的组件

### 1. PPU VBlank 生成

**测试目标**: 验证 PPU 是否正确生成 VBlank 信号

**测试用例**:
```scala
test("PPU should set VBlank at scanline 241") {
  val ppu = Module(new PPURefactored(enableDebug = false))
  
  // 模拟到 scanline 241
  for (i <- 0 until 241 * 341) {
    ppu.clock.step()
  }
  
  // 验证 VBlank 标志
  ppu.io.vblank.expect(true.B)
}
```

**预期**: VBlank 在 scanline 241 时设置为 1

---

### 2. PPUSTATUS 寄存器读取

**测试目标**: 验证 CPU 读取 $2002 时返回正确的 VBlank 位

**测试用例**:
```scala
test("PPUSTATUS read should return VBlank bit") {
  val ppu = Module(new PPURefactored(enableDebug = false))
  
  // 设置 VBlank
  ppu.io.setVBlank := true.B
  ppu.clock.step()
  
  // 读取 PPUSTATUS ($2002)
  ppu.io.cpuAddr := 2.U
  ppu.io.cpuRead := true.B
  ppu.clock.step()
  
  // 验证返回值 bit 7 = 1
  val status = ppu.io.cpuDataOut.peek().litValue
  assert((status & 0x80) != 0, s"VBlank bit should be 1, got 0x${status.toHexString}")
}
```

**预期**: PPUSTATUS bit 7 = 1 (0x80 或更高)

---

### 3. VBlank 清除时序

**测试目标**: 验证读取 PPUSTATUS 后 VBlank 是否正确清除

**测试用例**:
```scala
test("Reading PPUSTATUS should clear VBlank") {
  val ppu = Module(new PPURefactored(enableDebug = false))
  
  // 设置 VBlank
  ppu.io.setVBlank := true.B
  ppu.clock.step()
  
  // 第一次读取
  ppu.io.cpuAddr := 2.U
  ppu.io.cpuRead := true.B
  ppu.clock.step()
  
  // 验证 VBlank 已清除
  ppu.io.cpuRead := false.B
  ppu.clock.step()
  
  ppu.io.vblank.expect(false.B)
}
```

**预期**: 读取后 VBlank 清除

---

### 4. NES 系统集成测试

**测试目标**: 验证 CPU 能否正确读取 PPU 的 VBlank

**测试用例**:
```scala
test("CPU should read VBlank from PPU") {
  val nes = Module(new NESSystemRefactored(enableDebug = false))
  
  // 加载测试程序
  val testProg = Seq(
    0xAD, 0x02, 0x20,  // LDA $2002
    0x29, 0x80,        // AND #$80
    0xF0, 0xF8         // BEQ -8 (loop if VBlank=0)
  )
  
  // 运行到 VBlank
  for (i <- 0 until 30000) {  // ~1 frame
    nes.clock.step()
  }
  
  // 验证 CPU 不再卡在循环
  val pc = nes.io.debug_cpuPC.peek().litValue
  assert(pc > 0xC7AD, s"CPU stuck at PC=0x${pc.toHexString}")
}
```

**预期**: CPU 跳出等待循环

---

## 可能的问题点

### 1. PPU 时序问题
- VBlank 信号生成延迟
- scanline 计数错误
- pixel 计数错误

### 2. 寄存器读取问题
- PPUSTATUS 未连接到 VBlank 信号
- 寄存器地址映射错误
- 读取时序错误

### 3. 信号传递问题
- PPU → NESSystem 信号未连接
- VBlank 信号被覆盖
- 时钟域问题

---

## 调试信息

### 当前代码位置

1. **PPU VBlank 生成**: `src/main/scala/nes/PPURefactored.scala`
2. **PPUSTATUS 寄存器**: `src/main/scala/nes/core/PPURegisters.scala`
3. **NES 系统集成**: `src/main/scala/nes/NESSystemRefactored.scala`

### 相关信号

```scala
// PPU 输出
io.vblank: Bool()  // VBlank 标志

// PPU 寄存器
regs.vblank: Bool()  // 内部 VBlank 状态
regs.ppuStatus: UInt(8.W)  // PPUSTATUS 寄存器

// CPU 读取
io.cpuAddr: UInt(3.W)  // 寄存器地址 (2 = PPUSTATUS)
io.cpuRead: Bool()     // 读使能
io.cpuDataOut: UInt(8.W)  // 读取数据
```

---

## 测试优先级

1. 🔴 **Priority 1**: PPUSTATUS 读取测试 (最可能的问题)
2. 🟡 **Priority 2**: VBlank 生成测试
3. 🟢 **Priority 3**: VBlank 清除测试
4. 🟢 **Priority 4**: 系统集成测试

---

## 期望输出

请提供：
1. ✅/❌ 每个测试的结果
2. 失败测试的详细错误信息
3. 实际值 vs 期望值对比
4. 根本原因分析
5. 修复建议

---

## 联系方式

**提交人**: 玩家测试窗口  
**接收人**: 单元测试专家  
**紧急程度**: 立即处理
