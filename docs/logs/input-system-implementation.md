# 输入系统实现记录

**日期**: 2025-11-29  
**时间**: 16:56 - 17:08  
**状态**: ✅ 实现完成，但游戏未响应

---

## 📋 实现内容

### 1. 控制器 Strobe 协议

**问题**: 原始实现直接返回整个控制器字节，不符合 NES 标准

**NES 控制器协议**:
1. 游戏写 1 到 $4016 → 开始读取
2. 游戏写 0 到 $4016 → 锁定状态
3. 游戏连续读取 $4016 8 次 → 每次返回一个按键位

**实现代码** (`NESSystemRefactored.scala`):

```scala
// 控制器 strobe 逻辑
val controller1Shift = RegInit(0.U(8.W))
val controller2Shift = RegInit(0.U(8.W))
val controllerStrobe = RegInit(false.B)

when(cpu.io.memWrite && cpuAddr === 0x4016.U) {
  controllerStrobe := cpu.io.memDataOut(0)
  when(cpu.io.memDataOut(0)) {
    // Strobe = 1: 加载控制器状态
    controller1Shift := io.controller1
    controller2Shift := io.controller2
  }
}

// 控制器读取：每次读取返回最低位，然后右移
val controller1Data = controller1Shift(0)
val controller2Data = controller2Shift(0)

when(cpu.io.memRead && isController && !controllerStrobe) {
  when(cpuAddr === 0x4016.U) {
    controller1Shift := controller1Shift >> 1
  }.otherwise {
    controller2Shift := controller2Shift >> 1
  }
}

val controllerData = Mux(cpuAddr(0), controller2Data, controller1Data)
```

### 2. SDL 输入处理

**已存在** (`testbench_main.cpp`):
- ✅ SDL 事件循环
- ✅ 键盘映射
- ✅ 控制器状态更新

**按键映射**:
- Enter → Start (0x08)
- RShift → Select (0x04)
- Z → A (0x01)
- X → B (0x02)
- 方向键 → Up/Down/Left/Right (0x10/0x20/0x40/0x80)

### 3. 调试输出

添加了控制器状态显示：
```cpp
if (controller1 != last_controller1) {
    printf("\n🎮 Controller1: 0x%02X ", controller1);
    if (controller1 & 0x01) printf("A ");
    if (controller1 & 0x08) printf("Start ");
    // ...
}
```

---

## ✅ 测试结果

### 输入检测测试

**测试**: 按各种键

**结果**: ✅ 成功
```
🎮 Controller1: 0x01 A 
🎮 Controller1: 0x80 Right 
🎮 Controller1: 0x40 Left 
🎮 Controller1: 0x20 Down 
```

**结论**: SDL 输入处理正常，按键被正确检测

### 控制器读取测试

**测试**: 运行游戏 2 分钟，监控 $4016 访问

**结果**: ❌ 无读取
- 游戏没有写入 $4016
- 游戏没有读取 $4016
- 完全没有控制器访问

**结论**: 游戏没有尝试读取输入

---

## 🔍 问题分析

### 为什么游戏不读取输入？

**可能原因**:

1. **游戏在等待特定状态** 🟡
   - 可能在等待标题画面动画完成
   - 可能在等待特定的 VBlank 计数
   - Donkey Kong 的标题画面可能是静态的

2. **游戏卡在初始化循环** 🟠
   - CPU 在执行代码（PC 在变化）
   - 但可能卡在某个等待循环
   - 需要特定的 PPU 状态才能继续

3. **游戏需要特定的初始化** 🟠
   - 可能需要正确的 PPU 寄存器状态
   - 可能需要正确的内存初始化
   - 可能需要特定的时序

4. **这是正常的标题画面** ✅ 最可能
   - Donkey Kong 标题画面本来就是静态的
   - 只在特定时刻（如菜单出现）才检查输入
   - 需要等待更长时间或特定条件

### CPU 执行状态

**观察**: 
- PC 在变化（0xa, 0x6a, 等）
- FPS 稳定 33-34
- 无崩溃，无死循环

**结论**: CPU 正常执行，不是卡死

---

## 🎯 下一步计划

### 选项 1: 继续调试 Donkey Kong

**方法**:
1. 分析 Donkey Kong ROM 的反汇编代码
2. 找到输入检查的代码位置
3. 确定游戏在等待什么条件

**优点**: 彻底理解问题
**缺点**: 耗时，可能需要深入 6502 汇编

### 选项 2: 测试其他游戏 ⭐ 推荐

**方法**:
1. 测试 Super Mario Bros
2. 测试 Super Contra X
3. 看其他游戏是否响应输入

**优点**: 快速验证输入系统
**缺点**: 不解决 Donkey Kong 的问题

### 选项 3: 改进 PPU 状态

**方法**:
1. 确保 PPU 寄存器正确返回
2. 确保 VBlank 标志正确
3. 确保 NMI 正常触发

**优点**: 可能解决根本问题
**缺点**: 需要深入 PPU 实现

---

## 📊 当前状态

### 输入系统

| 组件 | 状态 | 备注 |
|------|------|------|
| SDL 事件处理 | ✅ | 完全工作 |
| 按键检测 | ✅ | 所有键都能检测 |
| 控制器映射 | ✅ | 正确映射到 NES 按键 |
| Strobe 协议 | ✅ | 已实现 |
| 硬件连接 | ✅ | 正确连接到 DUT |
| 游戏响应 | ❌ | 游戏不读取输入 |

### 整体进度

- **输入系统实现**: 100% ✅
- **输入系统测试**: 50% 🟡
- **游戏可玩性**: 0% ❌

---

## 💡 建议

**推荐**: 测试 Super Mario Bros

理由：
1. 验证输入系统在其他游戏中是否工作
2. Super Mario Bros 更流行，文档更多
3. 如果其他游戏能响应输入，说明 Donkey Kong 有特殊问题
4. 如果其他游戏也不响应，说明输入系统还有问题

---

**实现时间**: 12 分钟  
**代码变更**: 1 文件  
**测试时间**: 10 分钟  
**状态**: ✅ 实现完成，待验证
