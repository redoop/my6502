# 项目文档

欢迎查阅 NES 模拟器项目文档。

---

## 📚 文档列表

### 入门文档
- **[QUICKSTART.md](QUICKSTART.md)** - 快速开始指南
  - 环境配置
  - 构建运行
  - 基本使用

### 项目状态
- **[PROJECT_STATUS.md](PROJECT_STATUS.md)** - 项目当前状态
  - 完成功能清单
  - 已知问题
  - 开发计划
  - 技术栈

### 开发历史
- **[CHANGELOG.md](CHANGELOG.md)** - 开发日志
  - 版本历史
  - 功能变更
  - Bug 修复
  - 里程碑

### 技术文档
- **[instruction_dependency_tree.txt](../instruction_dependency_tree.txt)** - 指令依赖树
  - 6502 指令集架构
  - 依赖关系
  - 实现优先级

---

## 🎯 快速导航

### 我想...

#### 开始使用
→ 阅读 [QUICKSTART.md](QUICKSTART.md)

#### 了解项目进度
→ 阅读 [PROJECT_STATUS.md](PROJECT_STATUS.md)

#### 查看更新历史
→ 阅读 [CHANGELOG.md](CHANGELOG.md)

#### 理解 CPU 架构
→ 阅读 [instruction_dependency_tree.txt](../instruction_dependency_tree.txt)

#### 贡献代码
→ 阅读 [PROJECT_STATUS.md](PROJECT_STATUS.md) 的"贡献指南"部分

---

## 📊 项目概览

**项目名称**: NES 模拟器 (SystemVerilog 实现)  
**当前版本**: v0.6.0  
**开发阶段**: 核心功能完成，准备游戏测试  
**完成度**: 60%

### 核心组件状态
- ✅ CPU (6502) - 100% 完成
- ✅ PPU (2C02) - 基础完成
- ✅ APU - 基础完成
- ✅ DMA - 完成
- ✅ 系统集成 - 完成
- ✅ 单元测试 - 6/6 通过

---

## 🔗 外部资源

### 技术参考
- [NESDev Wiki](https://www.nesdev.org/wiki/) - NES 技术文档
- [6502.org](http://www.6502.org/) - 6502 CPU 参考
- [Verilator Manual](https://verilator.org/guide/latest/) - Verilator 文档

### 工具文档
- [SDL2 Documentation](https://wiki.libsdl.org/) - SDL2 API 文档
- [SystemVerilog LRM](https://ieeexplore.ieee.org/document/8299595) - SystemVerilog 语言规范

---

## 📝 文档维护

**最后更新**: 2025-11-30  
**维护者**: tongxiaojun

### 更新频率
- **PROJECT_STATUS.md**: 每次重大功能完成后更新
- **CHANGELOG.md**: 每次提交后更新
- **QUICKSTART.md**: 工具链变更时更新

---

## 🤝 反馈

发现文档问题？
- 检查文档是否为最新版本
- 提交 Issue 或 Pull Request
- 联系项目维护者

---

**感谢阅读！** 📖
