# NMI 未触发问题诊断

## 测试时间
2025年11月28日

## 问题描述
运行 `scripts/test_nmi_game.sh` 时，游戏加载成功但未检测到 NMI 中断触发。

## 系统架构分析

### 1. NMI 信号流
```
PPU (PPUSimplified) 
  └─> io.nmiOut 
      └─> CPU (CPU6502Core)
          └─> io.nmi
```

### 2. NMI 触发条件（在 PPUSimplified.scala）

```scala
when(scanlineY === 241.U && scanlineX === 1.U) {
  vblankFlag := true.B
  when(ppuCtrl(7)) {
    nmiOccurred := true.B
  }
}
```

**关键点：**
- VBlank 在扫描线 241、像素 1 时设置
- 只有当 `ppuCtrl(7) == 1` 时才设置 `nmiOccurred`
- `io.nmiOut := nmiOccurred`

### 3. CPU NMI 处理（在 CPU6502Core.scala）

```scala
// NMI 边沿检测
val nmiLast = RegInit(false.B)
val nmiPending = RegInit(false.B)

// 检测 NMI 上升沿
when(io.nmi && !nmiLast) {
  nmiPending := true.B
}
```

**关键点：**
- CPU 使用边沿检测（上升沿触发）
- 需要 `io.nmi` 从 false 变为 true

## 可能的问题

### 问题 1: PPUCTRL 未设置
**症状：** 游戏未写入 PPUCTRL 寄存器或未设置 bit 7

**原因：**
- 游戏初始化时间不够
- ROM 加载有问题
- 游戏代码未执行到设置 PPUCTRL 的部分

### 问题 2: VBlank 时序问题
**症状：** PPU 扫描线计数器未正确工作

**原因：**
- PPU 时钟可能与 CPU 不同步
- 扫描线计数器可能未正确递增

### 问题 3: NMI 信号清除问题
**症状：** `nmiOccurred` 设置后未正确清除

**当前代码：**
```scala
when(scanlineY === 261.U && scanlineX === 1.U) {
  vblankFlag := false.B
  nmiOccurred := false.B
  sprite0Hit := false.B
}
```

**问题：** 如果 CPU 在 VBlank 期间未处理 NMI，信号会在下一帧开始时清除，导致 CPU 错过中断。

### 问题 4: 读取 PPUSTATUS 清除 VBlank
**当前代码：**
```scala
when(io.cpuRead) {
  switch(io.cpuAddr) {
    is(0x2.U) {  // PPUSTATUS
      io.cpuDataOut := Cat(vblankFlag, sprite0Hit, 0.U(6.W))
      vblankClearNext := true.B  // 延迟清除
      ppuAddrLatch := false.B
    }
  }
}

when(vblankClearNext) {
  vblankFlag := false.B
  nmiOccurred := false.B  // ⚠️ 这里也清除了 NMI！
  vblankClearNext := false.B
}
```

**问题：** 读取 PPUSTATUS 会清除 `nmiOccurred`，这可能导致 CPU 错过 NMI。

## 诊断步骤

### 步骤 1: 检查 PPUCTRL 是否被设置
运行游戏并监控 PPUCTRL 寄存器的值。

### 步骤 2: 检查 VBlank 是否触发
监控 `vblankFlag` 和扫描线计数器。

### 步骤 3: 检查 nmiOccurred 信号
监控 `nmiOccurred` 是否被设置。

### 步骤 4: 检查 CPU 是否接收到 NMI
监控 CPU 的 `io.nmi` 输入和 `nmiPending` 标志。

## 建议的修复方案

### 修复 1: 分离 VBlank 和 NMI 的清除逻辑
```scala
// 读取 PPUSTATUS 只清除 vblankFlag，不清除 nmiOccurred
when(vblankClearNext) {
  vblankFlag := false.B
  // nmiOccurred := false.B  // 删除这行
  vblankClearNext := false.B
}

// nmiOccurred 只在帧开始时清除
when(scanlineY === 261.U && scanlineX === 1.U) {
  vblankFlag := false.B
  nmiOccurred := false.B
  sprite0Hit := false.B
}
```

### 修复 2: 改进 NMI 边沿检测
确保 CPU 能够正确检测 NMI 上升沿。

### 修复 3: 增加调试输出
在测试中添加更详细的日志，监控：
- PPUCTRL 的每次写入
- VBlank 标志的变化
- nmiOccurred 的变化
- CPU nmiPending 的变化

## 下一步行动
1. 创建详细的诊断测试
2. 修复 PPUSTATUS 读取清除 NMI 的问题
3. 验证修复后的行为
