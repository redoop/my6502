# NMI 调试最终总结

**日期**: 2025-11-29  
**时间**: 17:35 - 17:42  
**耗时**: 7 分钟

---

## ✅ 重大发现

### 1. PPU 正常工作
- ✅ pixelX/pixelY 正常计数
- ✅ VBlank 标志正常设置
- ✅ PPU 完全正常运行

### 2. CPU NMI 实现完整
- ✅ 有 NMI 边沿检测
- ✅ 有完整的 NMI 处理流程
- ✅ 会从 $FFFA-$FFFB 读取向量

### 3. 问题根源

**游戏从未设置 PPUCTRL**
- 游戏卡在初始化阶段
- 从未写入 $2000 (PPUCTRL)
- NMI enable 位从未设置
- 所以 NMI 永远不会触发

---

## 🔍 测试结果

### Super Mario Bros (Mapper 4)
- PC 卡在: 0x952b (死循环)
- 行为: 完全不动
- PPUCTRL: 从未写入
- FPS: 35

### Donkey Kong (Mapper 0)
- PC: 在变化 (0x0, 等)
- 行为: 有一些执行
- PPUCTRL: 从未写入
- FPS: 54 (更快)

---

## 💡 可能的原因

### 1. ROM 加载问题 🔴 最可能
**现象**: 
- Super Mario Bros 从 0x952b 开始（不正常）
- 应该从 Reset 向量指向的地址开始

**可能问题**:
- Mapper 4 (MMC3) bank switching 不正确
- Reset 向量读取错误
- PRG ROM 映射不正确

### 2. 缺少关键初始化 🟠
**可能缺少**:
- APU 初始化
- 某些内存初始化
- 特定的时序要求

### 3. Reset 处理问题 🟡
**可能问题**:
- Reset 向量 ($FFFC-$FFFD) 读取不正确
- CPU Reset 处理有问题

---

## 🎯 下一步建议

### 优先级 1: 检查 Reset 向量 🔴

**方法**:
1. 读取 ROM 的最后 6 个字节
2. 验证 Reset/NMI/IRQ 向量
3. 确认 CPU 从正确地址开始

**命令**:
```bash
# 查看 ROM 向量
hexdump -C games/Super-Mario-Bros.nes | tail -2

# 或使用 ROMAnalyzer
sbt "runMain nes.ROMAnalyzer \"games/Super-Mario-Bros.nes\""
```

### 优先级 2: 检查 Mapper 4 实现 🟠

**问题**: MMC3 bank switching 可能不正确

**检查**:
- PRG ROM bank 切换
- Reset 时的初始 bank
- $8000-$FFFF 的映射

### 优先级 3: 测试更简单的游戏 🟡

**尝试**:
- 其他 Mapper 0 游戏
- 或创建最小测试 ROM

---

## 📊 当前状态

### 工作的部分
- ✅ PPU 完全正常
- ✅ CPU 基本执行
- ✅ 输入检测
- ✅ NMI 实现

### 不工作的部分
- ❌ 游戏初始化
- ❌ PPUCTRL 设置
- ❌ NMI 触发
- ❌ 游戏主循环

### 阻塞问题
**游戏卡在初始化** - 可能是 ROM 加载或 Mapper 问题

---

## 🔬 技术细节

### NMI 触发条件
1. PPUCTRL bit 7 = 1 (NMI enable)
2. VBlank 标志 = 1
3. 产生上升沿（0→1）

### 当前实现
```scala
// 正确的 NMI 脉冲生成
val nmiTrigger = RegInit(false.B)
when(scanline === 241.U && pixel === 1.U && nmiEnable) {
  nmiTrigger := true.B
}.otherwise {
  nmiTrigger := false.B
}
io.nmiOut := nmiTrigger
```

### 测试的修复
1. ✅ 强制 NMI enable - 无效
2. ✅ NMI 脉冲生成 - 无效
3. ❌ 游戏仍然卡住

---

## 💭 反思

### 为什么强制 NMI 无效？

因为游戏根本没到需要 NMI 的阶段：
1. 游戏应该先初始化
2. 设置 PPUCTRL
3. 然后等待 VBlank
4. 最后进入主循环

我们卡在步骤 1，所以强制 NMI 没用。

### 真正的问题

**游戏的初始化代码没有正确执行**

可能原因：
- ROM 加载到错误的地址
- Mapper 配置不正确
- Reset 向量错误

---

## 📝 建议

### 短期（下次会话）

1. **验证 Reset 向量** - 10 分钟
2. **检查 Mapper 4** - 20 分钟
3. **测试简单 ROM** - 10 分钟

### 中期

1. 创建最小测试 ROM
2. 逐步添加功能
3. 验证每个步骤

### 长期

1. 完善 Mapper 实现
2. 添加更多调试工具
3. 支持更多游戏

---

**调试时间**: 7 分钟  
**状态**: 🟡 找到根本原因，但未解决  
**下次重点**: 检查 Reset 向量和 Mapper
