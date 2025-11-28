# Super Mario Bros 测试分析

## 测试结果

执行 `./scripts/test_mario.sh` 后观察到以下现象：

### 症状
- CPU PC 寄存器在 0x0 和 0x2 之间循环
- Reset 向量正确读取为 0xff40
- 但 PC 从未跳转到 0xff40
- 所有寄存器保持初始值 (A=0x0, X=0x0, Y=0x0)
- PPUMASK 始终为 0x0 (渲染未启用)
- 游戏永远无法启动

### 测试输出关键信息
```
Reset 向量 (0xFFFC-0xFFFD) = 0xff40
周期 0: state=0 cycle=1 PC=0x0
周期 1: state=0 cycle=2 PC=0x0
...
周期 10: state=1 cycle=0 PC=0x0
周期 11: state=2 cycle=0 PC=0x1
周期 12: state=2 cycle=1 PC=0x2
周期 13: state=2 cycle=2 PC=0x2
周期 14: state=2 cycle=3 PC=0x2
✅ CPU 已启动，PC = 0x2

帧: 64 | FPS: 21.1 | PC: 0x2 | A: 0x0 | X: 0x0 | Y: 0x0 | SP: 0x9f
帧: 627 | FPS: 21.5 | PC: 0x2 | A: 0x0 | X: 0x0 | Y: 0x0 | SP: 0xcc
帧: 1287 | FPS: 22.0 | PC: 0x0 | A: 0x0 | X: 0x0 | Y: 0x0 | SP: 0xdc
帧: 1947 | FPS: 22.0 | PC: 0x2 | A: 0x0 | X: 0x0 | Y: 0x0 | SP: 0xed
```

## 根本原因分析

### 问题 1: Reset 序列中的 PC 更新时机错误

在 `CPU6502Core.scala` 的 reset 状态中：

```scala
is(sReset) {
  when(cycle === 0.U) {
    io.memAddr := 0xFFFC.U
    io.memRead := true.B
    cycle := 1.U
  }.elsewhen(cycle === 1.U) {
    io.memAddr := 0xFFFC.U
    io.memRead := true.B
    operand := io.memDataIn  // 读取低字节
    cycle := 2.U
  }.elsewhen(cycle === 2.U) {
    io.memAddr := 0xFFFD.U
    io.memRead := true.B
    cycle := 3.U
  }.otherwise {
    // cycle=3: 完成 reset
    io.memAddr := 0xFFFD.U
    io.memRead := true.B
    val resetVector = Cat(io.memDataIn, operand(7, 0))
    regs.pc := resetVector  // ❌ 问题：这里更新 PC
    regs.sp := 0xFD.U
    regs.flagI := true.B
    cycle := 0.U
    state := sFetch
  }
}
```

**问题**：在 cycle=3 时，我们同时：
1. 读取 0xFFFD 的数据
2. 使用 `io.memDataIn` 构造 resetVector
3. 更新 `regs.pc`

但是 `io.memDataIn` 在这个周期可能还没有稳定的数据！

### 问题 2: 内存读取延迟

Chisel 硬件中，寄存器更新和组合逻辑的时序很重要：
- 当我们设置 `io.memAddr := 0xFFFD.U` 和 `io.memRead := true.B` 时
- 内存需要一个周期才能将数据放到 `io.memDataIn` 上
- 但我们在同一个周期就尝试读取 `io.memDataIn`

### 问题 3: 寄存器更新被覆盖

即使 PC 被正确设置，在 `sExecute` 状态中：

```scala
is(sExecute) {
  execResult := dispatchInstruction(...)
  regs := execResult.regs  // ❌ 完全覆盖 regs
  ...
}
```

如果指令执行返回的 `execResult.regs` 没有正确保留 PC 值，PC 就会被重置。

## 解决方案

### 方案 1: 增加 Reset 序列周期（推荐）

修改 reset 状态机，增加一个周期来等待数据稳定：

```scala
is(sReset) {
  when(cycle === 0.U) {
    // 周期 0: 开始读取低字节
    io.memAddr := 0xFFFC.U
    io.memRead := true.B
    cycle := 1.U
  }.elsewhen(cycle === 1.U) {
    // 周期 1: 等待低字节数据稳定
    io.memAddr := 0xFFFC.U
    io.memRead := true.B
    cycle := 2.U
  }.elsewhen(cycle === 2.U) {
    // 周期 2: 保存低字节，开始读取高字节
    operand := io.memDataIn
    io.memAddr := 0xFFFD.U
    io.memRead := true.B
    cycle := 3.U
  }.elsewhen(cycle === 3.U) {
    // 周期 3: 等待高字节数据稳定
    io.memAddr := 0xFFFD.U
    io.memRead := true.B
    cycle := 4.U
  }.otherwise {
    // 周期 4: 保存高字节并设置 PC
    val resetVector = Cat(io.memDataIn, operand(7, 0))
    regs.pc := resetVector
    regs.sp := 0xFD.U
    regs.flagI := true.B
    cycle := 0.U
    state := sFetch
  }
}
```

### 方案 2: 使用寄存器缓存向量值

```scala
val resetVectorLow = RegInit(0.U(8.W))
val resetVectorHigh = RegInit(0.U(8.W))

is(sReset) {
  when(cycle === 0.U) {
    io.memAddr := 0xFFFC.U
    io.memRead := true.B
    cycle := 1.U
  }.elsewhen(cycle === 1.U) {
    resetVectorLow := io.memDataIn
    io.memAddr := 0xFFFD.U
    io.memRead := true.B
    cycle := 2.U
  }.elsewhen(cycle === 2.U) {
    resetVectorHigh := io.memDataIn
    cycle := 3.U
  }.otherwise {
    val resetVector = Cat(resetVectorHigh, resetVectorLow)
    regs.pc := resetVector
    regs.sp := 0xFD.U
    regs.flagI := true.B
    cycle := 0.U
    state := sFetch
  }
}
```

### 方案 3: 修复 NMI 序列（同样的问题）

NMI 序列也有类似的问题，需要同样的修复：

```scala
is(sNMI) {
  when(cycle === 0.U) {
    cycle := 1.U
  }.elsewhen(cycle === 1.U) {
    // 压栈 PC 高字节
    io.memAddr := Cat(0x01.U(8.W), regs.sp)
    io.memDataOut := regs.pc(15, 8)
    io.memWrite := true.B
    regs.sp := regs.sp - 1.U
    cycle := 2.U
  }.elsewhen(cycle === 2.U) {
    // 压栈 PC 低字节
    io.memAddr := Cat(0x01.U(8.W), regs.sp)
    io.memDataOut := regs.pc(7, 0)
    io.memWrite := true.B
    regs.sp := regs.sp - 1.U
    cycle := 3.U
  }.elsewhen(cycle === 3.U) {
    // 压栈状态寄存器
    val status = Cat(regs.flagN, regs.flagV, 1.U(1.W), 0.U(1.W), 
                   regs.flagD, regs.flagI, regs.flagZ, regs.flagC)
    io.memAddr := Cat(0x01.U(8.W), regs.sp)
    io.memDataOut := status
    io.memWrite := true.B
    regs.sp := regs.sp - 1.U
    cycle := 4.U
  }.elsewhen(cycle === 4.U) {
    // 开始读取 NMI 向量低字节
    io.memAddr := 0xFFFA.U
    io.memRead := true.B
    cycle := 5.U
  }.elsewhen(cycle === 5.U) {
    // 等待数据稳定
    io.memAddr := 0xFFFA.U
    io.memRead := true.B
    cycle := 6.U
  }.elsewhen(cycle === 6.U) {
    // 保存低字节，读取高字节
    operand := io.memDataIn
    io.memAddr := 0xFFFB.U
    io.memRead := true.B
    cycle := 7.U
  }.elsewhen(cycle === 7.U) {
    // 等待高字节数据稳定
    io.memAddr := 0xFFFB.U
    io.memRead := true.B
    cycle := 8.U
  }.otherwise {  // cycle === 8
    // 设置 PC 到 NMI 向量
    val nmiVector = Cat(io.memDataIn, operand(7, 0))
    regs.pc := nmiVector
    regs.flagI := true.B
    cycle := 0.U
    state := sFetch
  }
}
```

## 实施步骤

1. **修改 CPU6502Core.scala**
   - 修复 sReset 状态的时序问题
   - 修复 sNMI 状态的时序问题

2. **重新编译**
   ```bash
   sbt "runMain nes.NESSystemMain"
   bash scripts/verilator_build_optimized.sh
   ```

3. **测试**
   ```bash
   bash scripts/test_mario.sh
   ```

4. **验证**
   - PC 应该跳转到 reset vector (0xff40)
   - CPU 应该开始执行指令
   - 寄存器值应该开始变化
   - PPUMASK 最终应该变为非零值

## 预期结果

修复后，应该看到：
- PC 从 0xff40 开始执行
- A, X, Y, SP 寄存器随着程序执行而变化
- PPUMASK 在初始化后变为 0x18 或 0x1E (启用背景和精灵渲染)
- 游戏画面开始显示

## 对比 Donkey Kong

两个游戏都有同样的问题，因为问题在 CPU 核心，不在游戏 ROM。修复后两个游戏都应该能正常启动。
