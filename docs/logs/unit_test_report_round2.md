# 单元测试报告 - 第2轮 - 2025-11-29 20:04

## 执行摘要

**任务**: 创建 PPUSTATUS 读取时序测试  
**执行人**: 单元测试专家  
**状态**: ✅ 测试创建完成，❌ 发现时序问题

## 测试结果

### PPUStatusReadTimingSpec (0/4 通过)

| 测试用例 | 状态 | 问题 |
|---------|------|------|
| 返回 VBlank bit | ❌ | cpuDataOut = 0x00 |
| 清除 VBlank | ❌ | 读取时已清除 |
| 反映 VBlank | ❌ | PPUSTATUS = 0x00 |
| 多次读取 | ❌ | 第一次读取就是 0x00 |

## 关键发现 🎯

### 问题：读取时序不匹配

**日志分析**:
```
Before read: PPUSTATUS = 0x80  ✅ VBlank 已设置
[PPU Regs] Read PPUSTATUS: vblank=1 -> 0, status=0x80  ✅ 清除逻辑触发
During read: PPUSTATUS = 0x00  ❌ 但读取到的是 0x00
```

**时序图**:
```
Cycle N:   cpuRead=1, cpuAddr=2
           ↓
           PPURegisterControl 检测到读取
           ↓
           regs.vblank := false.B  (立即清除)
           ↓
           regs.ppuStatus := Cat(regs.vblank, ...)  (组装为 0x00)
           ↓
           io.cpuDataOut := regs.ppuStatus  (输出 0x00)
           
Cycle N+1: CPU 读取到 cpuDataOut = 0x00  ❌
```

### 根本原因

**问题**: 读取清除是组合逻辑，立即生效
- `when(io.cpuRead && io.cpuAddr === 2.U)` 立即触发
- `regs.vblank := false.B` 立即清除
- `regs.ppuStatus` 立即更新为 0x00
- CPU 读取到的是清除后的值

**期望行为**:
- CPU 应该读取到清除前的值 (0x80)
- 然后 VBlank 被清除

### 解决方案

#### 方案 1: 延迟清除 ⭐ 推荐

**原理**: 在下一个周期清除 VBlank

```scala
// PPURegisterControl.scala
val clearVBlankNext = RegInit(false.B)

when(io.cpuRead && io.cpuAddr === 2.U) {
  clearVBlankNext := true.B  // 标记下一个周期清除
}.otherwise {
  clearVBlankNext := false.B
}

when(clearVBlankNext) {
  regs.vblank := false.B  // 下一个周期才清除
}
```

**优点**:
- CPU 能读取到正确的值
- 符合 NES 硬件行为
- 不影响其他逻辑

#### 方案 2: 使用读取前的值

**原理**: 保存读取前的 PPUSTATUS

```scala
val ppuStatusSnapshot = RegInit(0.U(8.W))

when(io.cpuRead && io.cpuAddr === 2.U) {
  ppuStatusSnapshot := regs.ppuStatus  // 保存当前值
  regs.vblank := false.B  // 清除
}

io.cpuDataOut := Mux(
  io.cpuRead && io.cpuAddr === 2.U,
  ppuStatusSnapshot,  // 返回保存的值
  MuxLookup(io.cpuAddr, 0.U, ...)
)
```

**缺点**: 需要额外的寄存器

#### 方案 3: 组合逻辑组装

**原理**: 在输出时动态组装 PPUSTATUS

```scala
// 不使用 regs.ppuStatus
io.cpuDataOut := MuxLookup(io.cpuAddr, 0.U, Seq(
  2.U -> Cat(
    regs.vblank,  // 使用当前值，不是清除后的
    regs.sprite0Hit,
    regs.spriteOverflow,
    0.U(5.W)
  ),
  ...
))

// 清除在读取后
when(io.cpuRead && io.cpuAddr === 2.U) {
  regs.vblank := false.B
}
```

**优点**: 最简单，不需要额外寄存器

## 测试代码

### 创建的文件

1. **PPUStatusReadTimingSpec.scala** (4 tests)
   - ✅ 成功创建
   - ❌ 全部失败（预期，等待修复）
   - 📝 提供详细的时序验证

### 测试覆盖

- ✅ 读取时序
- ✅ 清除时序
- ✅ 反映时序
- ✅ 多次读取

## 反馈给研发主程

### 🔴 Critical Issue

**问题**: PPUSTATUS 读取返回清除后的值 (0x00)

**影响**: 
- 游戏无法检测到 VBlank
- 导致无限循环

**建议修复**: 方案 1 (延迟清除) 或方案 3 (组合逻辑)

**优先级**: 🔴 Critical - 阻塞游戏运行

### 测试准备就绪

✅ 测试代码已创建  
✅ 测试用例覆盖完整  
✅ 等待修复后验证  

### 下一步

1. 研发主程选择修复方案
2. 实施修复
3. 运行 `sbt "testOnly integration.PPUStatusReadTimingSpec"`
4. 验证所有测试通过

## 时间统计

- 创建测试: 15 分钟
- 运行测试: 5 分钟
- 分析问题: 5 分钟
- 编写报告: 5 分钟
- **总计**: 30 分钟

## 附录

### 运行命令

```bash
# 运行新测试
sbt "testOnly integration.PPUStatusReadTimingSpec"

# 查看详细日志
sbt "testOnly integration.PPUStatusReadTimingSpec" 2>&1 | grep "PPU"
```

### 相关文件

- 测试: `src/test/scala/integration/PPUStatusReadTimingSpec.scala`
- PPU 寄存器: `src/main/scala/nes/core/PPURegisters.scala`
- PPU 主模块: `src/main/scala/nes/PPURefactored.scala`

### 日志片段

```
Before read: PPUSTATUS = 0x80  ✅
[PPU Regs] Read PPUSTATUS: vblank=1 -> 0, status=0x80  ✅
During read: PPUSTATUS = 0x00  ❌ 问题在这里
```

---

**状态**: 等待研发主程修复  
**下一步**: 验证修复效果
