# VBlank Bug 定位报告

## 测试结果总结

**日期**: 2025-11-29  
**测试人**: 单元测试专家  
**优先级**: 🔴 Critical

---

## 测试结果

| 测试 | 结果 | 说明 |
|------|------|------|
| Test 1: PPU VBlank 生成 | ❌ **失败** | PPU 在 scanline 241 时 VBlank=false |
| Test 2: PPUSTATUS 读取 | ✅ 通过 | 返回 0x80 (VBlank bit 正确) |
| Test 3: VBlank 清除 | ✅ 通过 | 读取后正确清除 |
| Test 4: NES 系统集成 | ❌ **失败** | CPU 卡在 PC=0x0002 |

---

## 根本原因

### 🔴 问题定位：PPU 未在 scanline 241 触发 VBlank

**问题模块**: `src/main/scala/nes/PPURefactored.scala`

**症状**:
```
✅ Test 1: VBlank at scanline 241 = false  ❌ 应该是 true
```

**影响**:
- PPU 永远不会进入 VBlank 状态
- CPU 无法检测到 VBlank
- 游戏初始化卡死
- 所有游戏无法运行

---

## 代码分析

### 需要检查的代码位置

**文件**: `src/main/scala/nes/PPURefactored.scala`

**关键逻辑**:
1. **Scanline 计数器**
   ```scala
   // 查找类似这样的代码
   when(pixelX === 340.U) {
     pixelX := 0.U
     pixelY := pixelY + 1.U
   }
   ```

2. **VBlank 触发条件**
   ```scala
   // 应该在 scanline 241 时设置 VBlank
   when(pixelY === 241.U && pixelX === 0.U) {
     // 设置 VBlank
     regControl.io.setVBlank := true.B
   }
   ```

3. **VBlank 清除条件**
   ```scala
   // 应该在 scanline 261 时清除 VBlank
   when(pixelY === 261.U && pixelX === 0.U) {
     regControl.io.clearVBlank := true.B
   }
   ```

---

## 可能的问题

### 问题 1: VBlank 信号未连接
```scala
// ❌ 错误：信号未连接
regControl.io.setVBlank := false.B  // 永远是 false

// ✅ 正确：根据 scanline 设置
regControl.io.setVBlank := (pixelY === 241.U && pixelX === 0.U)
```

### 问题 2: Scanline 计数错误
```scala
// ❌ 错误：计数器溢出或重置错误
when(pixelY === 240.U) {
  pixelY := 0.U  // 跳过了 241
}

// ✅ 正确：应该到 261 才重置
when(pixelY === 261.U && pixelX === 340.U) {
  pixelY := 0.U
}
```

### 问题 3: 时序问题
```scala
// ❌ 错误：在错误的周期设置
when(pixelY === 241.U && pixelX === 1.U) {  // 晚了 1 个周期
  regControl.io.setVBlank := true.B
}

// ✅ 正确：在 scanline 开始时设置
when(pixelY === 241.U && pixelX === 0.U) {
  regControl.io.setVBlank := true.B
}
```

---

## 修复任务

### 任务 1: 检查 PPU 渲染循环

**负责人**: 研发主程  
**文件**: `src/main/scala/nes/PPURefactored.scala`

**检查项**:
- [ ] pixelX 计数范围 (0-340)
- [ ] pixelY 计数范围 (0-261)
- [ ] scanline 241 时是否触发 VBlank
- [ ] scanline 261 时是否清除 VBlank

**期望行为**:
```
Scanline   0-239: 可见扫描线
Scanline     240: Post-render
Scanline 241-260: VBlank 期间
Scanline     261: Pre-render
```

---

### 任务 2: 检查 VBlank 信号连接

**负责人**: 研发主程  
**文件**: `src/main/scala/nes/PPURefactored.scala`

**检查项**:
- [ ] `regControl.io.setVBlank` 是否正确连接
- [ ] `regControl.io.clearVBlank` 是否正确连接
- [ ] `io.vblank` 输出是否连接到寄存器

**验证方法**:
```scala
// 添加调试输出
when(pixelY === 241.U && pixelX === 0.U) {
  printf("Setting VBlank at scanline 241\n")
}
```

---

### 任务 3: 添加单元测试

**负责人**: 单元测试专家  
**文件**: `src/test/scala/nes/PPUVBlankTest.scala`

**测试用例**:
```scala
test("PPU scanline counter") {
  val ppu = Module(new PPURefactored(enableDebug = false))
  ppu.clock.setTimeout(0)
  
  // 测试 1 帧
  for (scanline <- 0 to 261) {
    for (pixel <- 0 to 340) {
      ppu.clock.step()
      
      if (scanline == 241 && pixel == 0) {
        assert(ppu.io.vblank.peek().litToBoolean, 
               "VBlank should be set at scanline 241")
      }
    }
  }
}
```

---

## 修复验证

### 验证步骤

1. **修复代码**
   ```bash
   # 编辑 PPURefactored.scala
   vim src/main/scala/nes/PPURefactored.scala
   ```

2. **运行单元测试**
   ```bash
   sbt "testOnly nes.VBlankDebugTest"
   ```

3. **期望结果**
   ```
   ✅ Test 1: VBlank at scanline 241 = true
   ✅ Test 2: PPUSTATUS = 0x80, VBlank bit = true
   ✅ Test 3: VBlank after read: false
   ✅ Test 4: CPU escaped loop at cycle XXXX
   ```

4. **重新生成 Verilog**
   ```bash
   sbt "runMain nes.GenerateNESVerilog"
   ```

5. **重新编译仿真器**
   ```bash
   ./scripts/build.sh fast
   ```

6. **测试游戏**
   ```bash
   ./scripts/run.sh games/Donkey-Kong.nes --quiet
   ```

---

## 预期修复时间

- 🔍 **定位问题**: 10 分钟
- 🔧 **修复代码**: 5 分钟
- ✅ **验证测试**: 5 分钟
- 📦 **重新编译**: 5 分钟

**总计**: ~25 分钟

---

## 相关文件

- 问题模块: `src/main/scala/nes/PPURefactored.scala`
- 测试文件: `src/test/scala/nes/VBlankDebugTest.scala`
- 测试需求: `docs/logs/vblank_test_request.md`

---

## 联系方式

**报告人**: 单元测试专家  
**接收人**: 研发主程  
**抄送**: 玩家测试窗口  
**紧急程度**: 🔴 立即处理
