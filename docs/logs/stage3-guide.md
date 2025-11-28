# 阶段 3: PPU 寄存器访问验证指南

## 目标

验证 CPU 能正确读写 PPU 寄存器，游戏能启用渲染。

## 验证项

- [ ] PPUCTRL (0x2000) 写入正常
- [ ] PPUMASK (0x2001) 写入正常  
- [ ] PPUSTATUS (0x2002) 读取正常
- [ ] 游戏最终启用渲染（PPUMASK bit 3 或 4）

## 当前状态

**游戏状态**: 正在初始化  
**PPUMASK**: 0x6 (渲染未启用)  
**PC 位置**: 在多个初始化循环之间切换

## 验证方法

### 方法 1: 自动等待（推荐）

```bash
./scripts/wait_for_rendering.sh
```

这个脚本会：
- 运行游戏最多 10 分钟
- 自动检测渲染启用
- 显示实时进度

### 方法 2: 手动监控

```bash
./scripts/stage3_ppu_registers.sh
```

运行 3 分钟并监控 PPUMASK 变化。

### 方法 3: 快速检查

```bash
./scripts/quick_status.sh
```

快速查看当前状态。

## 预期结果

### 成功标志

当看到以下输出时，阶段 3 通过：

```
PPUMASK: 0x1e (BG: ON, SPR: ON)
```

或

```
PPUMASK: 0x18 (BG: ON, SPR: ON)
```

### 时间估算

在当前 2 FPS 速度下：
- 最快: 2-3 分钟
- 通常: 5-10 分钟
- 最慢: 15-20 分钟

## 加速方法

### 选项 1: 性能优化编译

```bash
./scripts/verilator_build_optimized.sh
```

预期提升: 3-5x（从 2 FPS 到 6-10 FPS）

### 选项 2: 减少调试输出

修改 `verilator/nes_testbench.cpp`，将调试输出间隔从 5 秒改为 30 秒。

### 选项 3: 禁用波形追踪

如果不需要调试波形，可以在编译时移除 `--trace` 选项。

## 故障排除

### 问题 1: 长时间无变化

**症状**: PPUMASK 一直是 0x6  
**原因**: 游戏还在初始化  
**解决**: 继续等待或实施性能优化

### 问题 2: PPUMASK 变化但不启用渲染

**症状**: PPUMASK 从 0x6 变为其他值，但 bit 3/4 仍为 0  
**原因**: 游戏在设置其他 PPU 参数  
**解决**: 这是正常的，继续等待

### 问题 3: 游戏卡在某个 PC

**症状**: PC 长时间不变  
**原因**: 可能是死循环或等待条件  
**解决**: 运行 `./scripts/verify_progress.sh` 检查

## 下一步

阶段 3 完成后：
1. 验证非零像素数量
2. 进入阶段 4: PPU 内存访问验证
3. 检查实际渲染效果

## 参考

- [debugging-strategy.md](debugging-strategy.md) - 完整调试策略
- [performance-optimization.md](performance-optimization.md) - 性能优化
- [verification-complete.md](verification-complete.md) - CPU 验证报告
