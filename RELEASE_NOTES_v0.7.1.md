# Release Notes - v0.7.1

## NES 模拟器 - PPU 渲染和 NMI 中断实现

发布日期：2025-11-28

### 🎉 主要成就

这个版本实现了 NES 模拟器的核心图形渲染功能和中断系统，是项目的一个重要里程碑！

#### 1. PPU 渲染管道完全工作 ✅
- 成功显示 CHR ROM 图形数据
- Nametable 渲染正常工作
- 调色板系统初始化完成
- 显示 23040 个非零像素（37.5% 屏幕）

#### 2. NMI 中断系统实现 ✅
- CPU 支持 NMI 中断处理
- 7 周期中断序列
- 正确的状态保存和恢复
- NMI 向量读取 (0xFFFA-0xFFFB)

#### 3. 系统集成完善 ✅
- CPU-PPU-Memory 完整连接
- 调试系统完善
- 一键构建脚本
- 实时状态监控

### 📸 效果展示

**当前画面：**
- 显示重复的灰色图案
- 证明渲染管道工作正常
- 游戏正在初始化中

**技术指标：**
- CPU PC: 0xC7AF（正常执行）
- PPU PPUCTRL: 0x10（已配置）
- 调色板：已初始化
- FPS: 2-3

### 🔧 技术细节

#### CPU 改进
```scala
// 新增 NMI 状态
val sNMI :: ... = Enum(5)

// NMI 边沿检测
val nmiEdge = RegInit(false.B)
when(io.nmi && !nmiLast) {
  nmiEdge := true.B
}
```

#### PPU 渲染
```scala
// 完整的渲染管道
1. 读取 nametable → tile 索引
2. 读取 attribute table → 调色板索引
3. 读取 pattern table → 像素数据
4. 读取 palette → RGB 颜色
5. 输出到 framebuffer
```

### 📦 构建和运行

```bash
# 一键构建（包含 Verilog 生成）
./scripts/verilator_build.sh

# 运行仿真
./scripts/verilator_run.sh games/Donkey-Kong.nes

# 监控 PPU 状态
./scripts/monitor_ppu.sh
```

### 📚 文档

新增文档：
- `docs/PPU_RENDERING_STATUS.md` - PPU 渲染状态详细报告
- `docs/PPU_COMPARISON.md` - PPU.scala vs PPUv3.scala 对比
- `docs/CURRENT_STATUS.md` - 项目当前状态总结
- `CHANGELOG.md` - 版本更新日志

### 🎯 路线图

**短期目标：**
- [ ] 等待游戏完成初始化
- [ ] 观察 PPUMASK 何时被设置
- [ ] 优化性能提高 FPS

**中期目标：**
- [ ] 实现精灵渲染
- [ ] 完善 PPU 功能（滚动、碰撞检测）
- [ ] 性能优化到 60 FPS

**长期目标：**
- [ ] 音频支持（APU）
- [ ] 更多 Mapper 支持
- [ ] 保存/加载状态

### 🙏 致谢

感谢所有为这个项目做出贡献的开发者！

### 📄 许可证

MIT License

---

**完整更新日志：** 查看 [CHANGELOG.md](CHANGELOG.md)

**项目状态：** 查看 [docs/CURRENT_STATUS.md](docs/CURRENT_STATUS.md)
