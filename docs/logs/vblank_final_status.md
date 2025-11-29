# VBlank 问题最终状态

**日期**: 2025-11-29 21:00  
**状态**: 🔴 未解决

---

## 问题总结

### 单元测试结果

✅ **PPU 单独测试通过** (修正后)
- VBlank 在 scanline 241 正确设置
- PPUSTATUS 读取正确
- VBlank 清除正确

❌ **Verilator 仿真失败**
- Scanline 只到 240
- Pixel 在 scanline 240 时只到 184
- VBlank 永远是 0

---

## 根本原因

**PPU pixel 计数器在 Verilator 中卡住**

### 证据

1. **单元测试**: Pixel 正常计数到 340
2. **Verilator**: Pixel 在 184 停止

### 可能原因

1. **时钟问题**: PPU 时钟未正确连接
2. **Reset 问题**: PPU 被频繁 reset
3. **优化问题**: Verilator 优化导致寄存器行为异常
4. **信号冲突**: 某处覆盖了 pixel 寄存器

---

## 下一步调试

### 方案 1: 检查时钟连接

```scala
// 在 NESSystemRefactored.scala 中
// 确认 PPU 使用系统时钟
val ppu = Module(new PPURefactored(enableDebug))
// PPU 应该自动连接到 clock
```

### 方案 2: 添加 VCD 波形

```bash
# 使用 trace 模式编译
./scripts/build.sh trace

# 运行并生成波形
./scripts/run.sh games/Donkey-Kong.nes

# 分析 pixel 和 scanline 信号
gtkwave trace.vcd
```

### 方案 3: 简化测试

创建最小测试用例：
```scala
test("PPU pixel counter") {
  val ppu = Module(new PPURefactored(enableDebug = false))
  
  for (i <- 0 until 1000) {
    ppu.clock.step()
    if (i % 100 == 0) {
      val x = ppu.io.pixelX.peek().litValue
      println(s"Cycle $i: pixel=$x")
    }
  }
}
```

---

## 临时解决方案

由于问题复杂，建议：

1. **使用调试模式**: `enableDebug = true`
2. **添加更多日志**: 监控 pixel/scanline 变化
3. **生成 VCD 波形**: 分析硬件行为
4. **简化 PPU**: 移除渲染逻辑，只保留计数器

---

## 相关文件

- PPU 源码: `src/main/scala/nes/PPURefactored.scala`
- 测试文件: `src/test/scala/nes/VBlankDebugTest.scala`
- Testbench: `verilator/testbench_main.cpp`
- 生成的 Verilog: `generated/nes/NESSystem.v`

---

## 时间消耗

- 问题定位: 30 分钟
- 单元测试: 20 分钟
- Verilator 调试: 40 分钟
- **总计**: 90 分钟

---

## 建议

🔴 **Critical**: 这个问题阻塞所有游戏运行

**优先级**:
1. 生成 VCD 波形分析
2. 简化 PPU 到最小可工作版本
3. 逐步添加功能并测试

**预计时间**: 2-4 小时
