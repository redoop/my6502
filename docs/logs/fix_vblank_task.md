# VBlank 修复任务

## 任务分配

**接收人**: 研发主程  
**优先级**: 🔴 P0 - Critical  
**预计时间**: 25 分钟

---

## 问题描述

PPU 未在 scanline 241 时触发 VBlank，导致所有游戏卡在初始化循环。

**测试证据**:
```
❌ Test 1: VBlank at scanline 241 = false (应该是 true)
❌ Test 4: CPU 卡在 PC=0x0002 (等待 VBlank)
```

---

## 修复步骤

### Step 1: 定位问题代码

**文件**: `src/main/scala/nes/PPURefactored.scala`

**查找关键字**:
```bash
grep -n "pixelY.*241\|setVBlank\|clearVBlank" src/main/scala/nes/PPURefactored.scala
```

**预期找到**:
- Scanline 计数器逻辑
- VBlank 设置条件
- VBlank 清除条件

---

### Step 2: 检查 Scanline 计数

**查找**:
```scala
when(pixelX === 340.U) {
  pixelX := 0.U
  when(pixelY === ???.U) {  // 检查这里
    pixelY := 0.U
  }.otherwise {
    pixelY := pixelY + 1.U
  }
}
```

**问题可能**:
- pixelY 最大值不是 261
- 跳过了 scanline 241
- 计数器重置过早

**正确逻辑**:
```scala
when(pixelX === 340.U) {
  pixelX := 0.U
  when(pixelY === 261.U) {
    pixelY := 0.U  // 重置到 0
  }.otherwise {
    pixelY := pixelY + 1.U
  }
}
```

---

### Step 3: 检查 VBlank 触发

**查找**:
```scala
regControl.io.setVBlank := ???
regControl.io.clearVBlank := ???
```

**问题可能**:
- 信号永远是 false.B
- 触发条件错误
- 信号未连接

**正确逻辑**:
```scala
// 在 scanline 241, pixel 1 时设置 VBlank
regControl.io.setVBlank := (pixelY === 241.U && pixelX === 1.U)

// 在 scanline 261, pixel 1 时清除 VBlank (pre-render)
regControl.io.clearVBlank := (pixelY === 261.U && pixelX === 1.U)
```

**注意**: NES PPU 在 scanline 241 的第 2 个 pixel (pixel 1) 时设置 VBlank

---

### Step 4: 验证修复

**运行测试**:
```bash
sbt "testOnly nes.VBlankDebugTest"
```

**期望输出**:
```
✅ Test 1: VBlank at scanline 241 = true
✅ Test 2: PPUSTATUS = 0x80, VBlank bit = true
✅ Test 3: VBlank after read: false
✅ Test 4: CPU escaped loop at cycle XXXX
```

---

### Step 5: 重新编译

```bash
# 1. 重新生成 Verilog
sbt "runMain nes.GenerateNESVerilog"

# 2. 重新编译仿真器
./scripts/build.sh fast

# 3. 测试游戏
./scripts/run.sh games/Donkey-Kong.nes --quiet
```

**期望结果**:
- CPU 不再卡在 0xC7A8-0xC7AD
- PC 继续执行到其他地址
- 游戏窗口显示内容

---

## 参考资料

### NES PPU 时序

```
Scanline   0-239: 可见扫描线 (240 条)
Scanline     240: Post-render 扫描线
Scanline 241-260: VBlank 期间 (20 条)
Scanline     261: Pre-render 扫描线

每条扫描线: 341 个 pixel (0-340)
```

### VBlank 标志

```
Scanline 241, Pixel 1: 设置 VBlank (PPUSTATUS bit 7 = 1)
Scanline 261, Pixel 1: 清除 VBlank (PPUSTATUS bit 7 = 0)
读取 $2002:          清除 VBlank
```

---

## 检查清单

- [ ] pixelX 范围 0-340
- [ ] pixelY 范围 0-261
- [ ] scanline 241 时设置 VBlank
- [ ] scanline 261 时清除 VBlank
- [ ] regControl.io.setVBlank 正确连接
- [ ] regControl.io.clearVBlank 正确连接
- [ ] 单元测试全部通过
- [ ] 游戏能够启动

---

## 提交要求

修复完成后，请提供：

1. ✅ 修改的代码片段
2. ✅ 测试结果截图
3. ✅ 游戏运行状态

---

**任务创建时间**: 2025-11-29 20:49  
**期望完成时间**: 2025-11-29 21:15
