# NES 硬件模拟器 (Chisel + Verilator)

一个基于 Chisel 硬件描述语言和 Verilator 仿真的 NES (Nintendo Entertainment System) 模拟器。

## 🎮 特性

- ✅ **完整的 6502 CPU** - 82% 指令集实现
- ✅ **功能完整的 PPU** - 背景和精灵渲染
- ✅ **硬件级仿真** - 使用 Verilator 周期精确仿真
- ✅ **实时显示** - SDL2 图形输出
- ✅ **游戏兼容** - 成功运行 Donkey Kong

## 📸 截图

当前运行 Donkey Kong 的画面：
- 清晰的背景 tile 渲染
- 正确的调色板颜色
- 稳定的实时显示

## 🚀 快速开始

### 环境要求

- Scala 2.13+
- SBT 1.9+
- Verilator 5.0+
- SDL2
- C++ 编译器

### 编译和运行

```bash
# 1. 生成 Verilog
./scripts/generate_verilog.sh

# 2. 编译 Verilator 仿真器
./scripts/verilator_build.sh

# 3. 运行游戏
./build/verilator/VNESSystem games/Donkey-Kong.nes
```

### 一键运行

```bash
./scripts/verilator_run.sh games/Donkey-Kong.nes
```

## 📁 项目结构

```
my6502/
├── src/main/scala/       # Chisel 硬件描述
│   ├── cpu/             # 6502 CPU 实现
│   ├── nes/             # NES 系统组件
│   └── ...
├── verilator/           # Verilator testbench
├── scripts/             # 构建和测试脚本
├── docs/                # 项目文档
└── games/               # ROM 文件
```

## 🎯 已实现功能

### CPU (6502)
- [x] 基础指令集 (124/151)
- [x] 寄存器和标志位
- [x] 内存访问
- [x] 分支和跳转
- [x] 栈操作
- [x] 中断支持 (NMI)

### PPU (图形处理)
- [x] 背景渲染
- [x] 精灵渲染 (前 8 个)
- [x] VBlank 和 NMI
- [x] 调色板系统
- [x] 扫描线计数

### 系统
- [x] 内存控制器
- [x] ROM 加载
- [x] OAM DMA
- [x] SDL2 显示

## 📊 性能

- **FPS**: 2-3 (目标 60)
- **分辨率**: 256x240
- **颜色**: 64 色调色板
- **精灵**: 前 8 个精灵支持

## 🔧 技术细节

### 硬件架构

```
CPU (6502) ←→ Memory Controller ←→ PPU
                    ↓
              ROM / RAM / OAM
                    ↓
              Framebuffer
                    ↓
              SDL2 Display
```

### 关键技术

1. **VBlank 延迟清除** - 正确的 NES 时序
2. **优先级编码器** - 避免组合循环
3. **OAM DMA** - 快速精灵数据传输
4. **周期精确仿真** - Verilator 硬件仿真

## 📚 文档

- [当前状态](docs/CURRENT_STATUS.md)
- [最终状态报告](docs/FINAL_PROJECT_STATUS.md)
- [优化记录](docs/OPTIMIZATION_2025-11-28.md)
- [PPU 功能增强](docs/PPU_ENHANCEMENTS.md)
- [精灵渲染实现](docs/SPRITE_RENDERING.md)
- [会话总结](docs/SESSION_SUMMARY_2025-11-28.md)

## 🎯 未来计划

### 短期
- [ ] 性能优化 (提升到 60 FPS)
- [ ] 支持全部 64 个精灵
- [ ] 实现滚动功能

### 中期
- [ ] 8x16 精灵模式
- [ ] Sprite 0 碰撞检测
- [ ] 更多游戏测试

### 长期
- [ ] APU (音频) 支持
- [ ] 更多 Mapper
- [ ] FPGA 部署

## 🐛 已知问题

1. **性能** - FPS 较低，需要优化
2. **精灵** - 只支持前 8 个精灵
3. **滚动** - 尚未实现

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可

MIT License

## 🙏 致谢

- NES Dev Wiki - 技术参考
- Chisel 团队 - 优秀的硬件描述语言
- Verilator 项目 - 强大的仿真工具

## 📞 联系

如有问题或建议，欢迎联系！

---

**状态**: ✅ 可运行  
**版本**: v1.0  
**日期**: 2025-11-28
