# DEX 循环 Bug 分析

## 问题描述
游戏卡在内存清零循环 (0xf19f-0xf1a8)，X 寄存器从 4 跳到 247，循环永不退出。

## 循环代码
```
0xf19f: STA ($04),Y  ; 存储 A 到间接地址
0xf1a1: INY          ; Y++
0xf1a2: INY          ; Y++
0xf1a3: INY          ; Y++
0xf1a4: INY          ; Y++
0xf1a5: DEX          ; X--
0xf1a6: BNE $f19f    ; 如果 X != 0，跳回开始
```

## 观察到的 X 值序列
```
X = 0x51 (81)
X = 0x44 (68)   递减 13
X = 0x36 (54)   递减 14
X = 0x29 (41)   递减 13
X = 0x1c (28)   递减 13
X = 0x4 (4)     递减 24
X = 0xf7 (247)  ❌ 从 4 跳到 247！
X = 0xea (234)
...
```

## 根本原因

### DEX 指令实现（正确）
```scala
is(0xCA.U) {  // DEX
  val res = regs.x - 1.U
  newRegs.x := res
  newRegs.flagN := res(7)
  newRegs.flagZ := res === 0.U
}
```

### BNE 指令实现（正确）
```scala
is(0xD0.U) { takeBranch := !regs.flagZ }  // BNE
```

### 问题分析

**X 值变化过程：**
1. X = 4, DEX → X = 3, Z = 0, BNE 跳转 ✓
2. X = 3, DEX → X = 2, Z = 0, BNE 跳转 ✓
3. X = 2, DEX → X = 1, Z = 0, BNE 跳转 ✓
4. X = 1, DEX → X = 0, Z = 1, BNE 不跳转 ✓ **应该在这里退出！**
5. **但是循环继续执行！** X = 0, DEX → X = 255, Z = 0, BNE 跳转 ❌

## 可能的原因

### 假设 1: 循环没有在 X = 0 时退出
- BNE 指令在 Z = 1 时应该不跳转
- 但循环继续执行，说明 BNE 仍然跳转了
- **可能原因**: 在 X = 0 时，Z 标志没有被正确设置或读取

### 假设 2: 指令执行顺序问题
- DEX 设置了 Z 标志
- 但在 BNE 读取 Z 标志之前，Z 被其他指令修改了
- **需要检查**: INY 指令是否会修改 Z 标志

### 假设 3: 寄存器更新时序问题
- DEX 计算 `newRegs.flagZ`
- 但 `newRegs` 可能没有正确应用到下一条指令
- **需要检查**: `execResult.regs` 的应用时机

## 下一步调试

1. ✅ 检查 INY 是否修改 Z 标志
2. ✅ 检查寄存器更新逻辑
3. ✅ 添加详细的标志位日志
4. ⬜ 创建单元测试验证 DEX + BNE 组合

## 解决方案

待确定根本原因后更新...
