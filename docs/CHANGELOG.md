# Changelog

## [v0.7.2] - 2025-11-28

### 🚀 指令集大幅扩展
- **48 种新指令** - 从 76 种增加到 124 种 (82% 覆盖率)
- **Logic 指令完整实现** - ORA, AND, EOR 所有寻址模式
- **Load/Store 扩展** - LDX, LDY, STA 各种寻址模式
- **Compare 指令完整** - CMP, CPX, CPY 包括 65C02 扩展

### 🛠️ 新增工具
- `scripts/analyze_opcodes.py` - ROM 指令分析工具
- `scripts/test_reset_trace.sh` - Reset 序列测试
- `scripts/monitor_opcodes.sh` - Opcode 监控
- `scripts/test_donkey_kong.sh` - 快速测试脚本

### 📚 新增文档
- `docs/IMPLEMENTATION_SUMMARY.md` - 指令实现总结
- `docs/MISSING_OPCODES.md` - 缺失指令分析
- `docs/FINAL_STATUS.md` - 项目最终状态
- `docs/VERILATOR_TEST_RESULTS.md` - 测试结果
- `docs/RELEASE_NOTES_v0.7.2.md` - 发布说明

### 📁 项目结构优化
- 所有文档移至 `docs/` 目录
- 所有脚本移至 `scripts/` 目录
- 测试代码移至 `verilator/` 目录

### 🔧 技术改进
- 使用通用函数减少代码重复
- 统一的寻址模式实现
- 完善的错误处理

---

## [v0.7.1] - 2025-11-28

### 🎉 重大进展
- **PPU 渲染成功** - 实现完整的 nametable 渲染管道
- **NMI 中断支持** - CPU 现在支持 NMI 中断处理
- **调色板系统** - 32 色调色板初始化和管理
- **图形显示** - 成功显示 CHR ROM 和 nametable 内容

### ✨ 新功能

#### CPU
- ✅ 实现 NMI 中断处理（7 周期）
- ✅ NMI 边沿检测
- ✅ 中断向量读取 (0xFFFA-0xFFFB)
- ✅ 状态寄存器压栈
- ✅ PC 压栈和恢复

#### PPU
- ✅ 完整的 nametable 渲染
- ✅ Attribute table 支持
- ✅ 调色板初始化（32 字节）
- ✅ Pattern table 读取
- ✅ 像素颜色计算
- ✅ PPU 调试接口

#### 系统
- ✅ CPU-PPU NMI 连接
- ✅ 调试信息输出
- ✅ 一键构建脚本（集成 Verilog 生成）
- ✅ PPU 状态监控

### 🔧 改进
- 优化 ROM 地址映射（16KB 镜像支持）
- 改进 CPU reset 逻辑（添加 resetReleased 标志）
- 完善调试输出系统
- 添加 PPU 寄存器状态监控

### 📊 测试结果
- CPU 正确从 reset vector (0xC79E) 启动 ✅
- NMI 向量正确读取 (0xC85F) ✅
- PPU 渲染管道工作正常 ✅
- 显示 23040 个非零像素（37.5% 屏幕）✅
- FPS: 2-3（需要优化）

### 📝 文档
- 添加 `docs/PPU_RENDERING_STATUS.md` - PPU 渲染状态报告
- 添加 `docs/PPU_COMPARISON.md` - PPU 实现对比
- 添加 `docs/CURRENT_STATUS.md` - 项目当前状态
- 更新 `docs/DEBUG_RESET_VECTOR.md`

### 🐛 已知问题
- PPUMASK = 0（游戏还未启用渲染）
- 性能较低（FPS 2-3）
- 游戏还在初始化阶段

### 🎯 下一步计划
1. 等待游戏完成初始化
2. 实现精灵渲染
3. 性能优化
4. 完善 PPU 功能

---

## [v0.7.0] - 2025-11-27

### 初始版本
- 基础 CPU 6502 实现
- 基础 PPU 框架
- ROM 加载系统
- Verilator 仿真环境

