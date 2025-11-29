# 问题分析请求 - 需要单元测试专家支持

**日期**: 2025-11-29 19:34  
**请求人**: 研发主程  
**优先级**: 🔴 High

## 问题概述

游戏 Donkey Kong 卡在等待循环中，需要单元测试专家帮助定位根本原因。

## 已完成的工作

### ✅ Bug 修复 (已验证)
1. **LDA 指令 Bug** - 修复并通过测试
2. **STA 指令 Bug** - 修复并通过测试
3. **PPU 寄存器写入** - 修复并通过测试

### ✅ 单元测试状态
```
LoadStoreInstructionsSpec: 18/18 通过 ✅
```

### 🟡 集成测试状态
- Donkey Kong: 卡在等待循环
- Super Mario Bros: 无法启动 (Mapper 4)

## 需要单元测试专家协助的问题

### 问题 1: 游戏等待循环分析

**现象**:
```assembly
$C7A9: AD 02 20  LDA $2002    ; 读取 PPUSTATUS
$C7AC: 29 xx     AND #xx      ; AND 操作
$C7AE: F0 xx     BEQ $C7A0    ; 如果 Z=1，跳回
```

**数据**:
- LDA $2002 读取到: 0x40 或 0x10
- AND 后结果: 0x00
- BEQ 跳转: 是 (Z=1)

**请求**:
1. 创建单元测试验证 AND 指令的正确性
2. 创建单元测试验证 BEQ 指令的正确性
3. 创建集成测试模拟这个循环

### 问题 2: PPUSTATUS 读取验证

**现象**:
- PPUSTATUS 返回 0x40 (bit 6 = Sprite 0 Hit)
- PPUSTATUS 返回 0x10 (bit 4 = ?)

**请求**:
1. 验证 PPUSTATUS 的位定义是否正确
2. 创建测试验证读取 PPUSTATUS 后是否清除 VBlank
3. 验证 Sprite 0 Hit 的实现

### 问题 3: 指令周期数验证

**修改**:
- Fetch 状态: 从 2 周期增加到 3 周期 (预读下一个字节)
- 立即寻址: 从 2 周期减少到 1 周期
- 绝对寻址: 保持 3 周期

**请求**:
1. 验证这些周期数是否符合 6502 规范
2. 创建性能测试验证指令时序
3. 确认是否有其他指令受影响

## 测试数据

### 执行的指令
```
0x29: AND #imm
0x8D: STA abs
0x9A: TXS
0xA2: LDX #imm
0xA9: LDA #imm
0xAD: LDA abs
0xD8: CLD
0xF0: BEQ
```

### 寄存器状态
```
PC: 0xC79F-0xC7AE (循环)
A: 0x00, 0x10, 0x40 (变化)
X: 0xFF (固定)
Y: 0x00 (固定)
PPUCTRL: 0x10 (固定)
```

### PPU 状态
```
VBlank: 0/1 (正常切换)
NMI: 0 (从未触发)
PPUSTATUS: 0x40 或 0x10
```

## 期望的测试输出

### 1. AND 指令测试
```scala
test("AND immediate with PPUSTATUS values") {
  // 测试 0x40 AND 0x?? = 0x00
  // 测试 0x10 AND 0x?? = 0x00
  // 确定 AND 的操作数
}
```

### 2. BEQ 指令测试
```scala
test("BEQ with zero result") {
  // 测试 Z=1 时跳转
  // 测试 Z=0 时不跳转
  // 验证跳转地址计算
}
```

### 3. PPUSTATUS 读取测试
```scala
test("PPUSTATUS read clears VBlank") {
  // 读取前: VBlank=1
  // 读取后: VBlank=0
  // 验证其他位不受影响
}
```

## 协作方式

### 单元测试专家
- [ ] 创建上述测试用例
- [ ] 运行测试并提供结果
- [ ] 分析失败原因
- [ ] 提供修复建议

### 研发主程 (我)
- [ ] 根据测试结果修复代码
- [ ] 验证修复效果
- [ ] 更新文档
- [ ] 集成测试

## 时间线

- **T+0h**: 提交请求
- **T+1h**: 单元测试专家创建测试
- **T+2h**: 测试结果分析
- **T+3h**: 修复实施
- **T+4h**: 验证完成

## 相关文档

- CPU 修复总结: `docs/logs/cpu_fix_summary.md`
- PPU 寄存器修复: `docs/logs/ppu_register_fix_completed.md`
- 游戏测试结果: `docs/logs/game_test_results.md`
- 当前状态总结: `docs/logs/current_status_summary.md`

## 联系方式

**研发主程**: 主研发窗口  
**会话 ID**: 51812_1764411996  
**状态**: 等待单元测试专家响应

---

**请求提交时间**: 2025-11-29 19:34
