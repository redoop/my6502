# 📚 NES 模拟器文档索引

**最后更新**: 2025-11-28  
**版本**: v0.8.0

## 🎯 核心文档（10 个）

本项目文档已整理为 10 个核心文档，涵盖项目的所有方面。

### 1. [项目概述](01_PROJECT_OVERVIEW.md) ⭐ 从这里开始

**内容**:
- 项目简介和特性
- 技术栈
- 系统架构图
- 项目结构
- 当前状态和进度
- 快速开始指南
- 主要成就和未来计划

**适合**: 新用户、项目概览

---

### 2. [开发指南](02_DEVELOPMENT_GUIDE.md)

**内容**:
- 开发环境设置
- 项目克隆和配置
- 开发工作流
- 代码结构详解
- 添加新指令的方法
- 调试技巧
- 性能优化
- 代码规范

**适合**: 开发者、贡献者

---

### 3. [测试指南](03_TESTING_GUIDE.md)

**内容**:
- 测试类型（单元、集成、游戏）
- 测试工具使用
- 测试场景和用例
- 测试结果分析
- 性能测试
- 调试测试失败
- 持续集成

**适合**: 测试人员、QA

---

### 4. [Verilator 仿真指南](04_VERILATOR_GUIDE.md)

**内容**:
- Verilator 安装
- 工作流程
- Testbench 实现
- 编译选项
- 调试技巧
- 性能优化
- 常见问题

**适合**: 硬件仿真、FPGA 开发者

---

### 5. [PPU 渲染系统](05_PPU_SYSTEM.md)

**内容**:
- PPU 架构
- 内存映射
- 寄存器详解
- 背景渲染流程
- 精灵渲染流程
- 调色板系统
- 时序和 VBlank
- OAM DMA

**适合**: 图形系统开发者

---

### 6. [CPU 实现详解](06_CPU_IMPLEMENTATION.md)

**内容**:
- 6502 架构
- 寄存器详解
- 寻址模式（13 种）
- 指令集完整列表
- CPU 状态机
- 中断处理
- 实现细节
- 性能指标

**适合**: CPU 开发者、指令集研究

---

### 7. [游戏兼容性](07_GAME_COMPATIBILITY.md)

**内容**:
- 总体兼容性状态
- 已测试游戏列表
- Mapper 支持情况
- 功能兼容性矩阵
- 游戏分类兼容性
- 已知问题
- 测试方法
- 改进计划

**适合**: 游戏测试、兼容性评估

---

### 8. [调试指南](08_DEBUG_GUIDE.md)

**内容**:
- 调试工具（ChiselTest, VCD, Verilator）
- CPU 调试方法
- PPU 调试方法
- APU 调试方法
- 内存调试
- 常见问题诊断
- 调试脚本
- 性能分析

**适合**: 调试、问题排查

---

### 9. [发布说明](09_RELEASE_NOTES.md)

**内容**:
- 版本历史（v0.1.0 - v0.8.0）
- 每个版本的新功能
- Bug 修复记录
- 性能改进
- 升级指南
- 已知问题
- 路线图

**适合**: 了解项目演进、版本管理

---

### 10. [快速参考](10_QUICK_REFERENCE.md) ⭐ 速查手册

**内容**:
- 快速开始命令
- 寄存器速查表
- 内存映射速查
- 常用指令速查
- 调试命令速查
- 常见问题速查
- 文件结构速查
- 性能指标速查

**适合**: 日常开发、快速查询

---

## 📖 按需求查找

### 我想了解项目
→ [01_PROJECT_OVERVIEW.md](01_PROJECT_OVERVIEW.md)

### 我想开始开发
→ [02_DEVELOPMENT_GUIDE.md](02_DEVELOPMENT_GUIDE.md)

### 我想运行测试
→ [03_TESTING_GUIDE.md](03_TESTING_GUIDE.md)

### 我想使用 Verilator
→ [04_VERILATOR_GUIDE.md](04_VERILATOR_GUIDE.md)

### 我想了解 PPU
→ [05_PPU_SYSTEM.md](05_PPU_SYSTEM.md)

### 我想了解 CPU
→ [06_CPU_IMPLEMENTATION.md](06_CPU_IMPLEMENTATION.md)

### 我想测试游戏
→ [07_GAME_COMPATIBILITY.md](07_GAME_COMPATIBILITY.md)

### 我遇到问题
→ [08_DEBUG_GUIDE.md](08_DEBUG_GUIDE.md)

### 我想了解版本历史
→ [09_RELEASE_NOTES.md](09_RELEASE_NOTES.md)

### 我需要快速查询
→ [10_QUICK_REFERENCE.md](10_QUICK_REFERENCE.md)

---

## 🗺️ 文档地图

```
docs/
├── INDEX.md                      ← 你在这里
│
├── 核心文档 (10 个)
│   ├── 01_PROJECT_OVERVIEW.md    项目概述
│   ├── 02_DEVELOPMENT_GUIDE.md   开发指南
│   ├── 03_TESTING_GUIDE.md       测试指南
│   ├── 04_VERILATOR_GUIDE.md     Verilator 指南
│   ├── 05_PPU_SYSTEM.md          PPU 系统
│   ├── 06_CPU_IMPLEMENTATION.md  CPU 实现
│   ├── 07_GAME_COMPATIBILITY.md  游戏兼容性
│   ├── 08_DEBUG_GUIDE.md         调试指南
│   ├── 09_RELEASE_NOTES.md       发布说明
│   └── 10_QUICK_REFERENCE.md     快速参考
│
├── 导航文档 (4 个)
│   ├── INDEX.md                  文档索引
│   ├── README.md                 文档导航
│   ├── DOCUMENTATION_SUMMARY.md  整理说明
│   └── ARCHIVE_SUMMARY.md        归档总结
│
├── 参考文档 (1 个)
│   └── ARCHITECTURE.md           完整架构文档
│
├── 图片 (1 个)
│   └── my6502.png                芯片布局图
│
└── archive/ (65 个)
    ├── README.md                 归档说明
    └── ... (64 个归档文档)
```

---

## 📊 文档完整度

```
核心文档:     10/10  ✅ 100%
文档总页数:   ~500 页
代码示例:     200+
图表:         20+
```

---

## 🎯 推荐阅读路径

### 新手路径
1. [项目概述](01_PROJECT_OVERVIEW.md) - 了解项目
2. [快速参考](10_QUICK_REFERENCE.md) - 快速上手
3. [开发指南](02_DEVELOPMENT_GUIDE.md) - 开始开发

### 开发者路径
1. [开发指南](02_DEVELOPMENT_GUIDE.md) - 环境设置
2. [CPU 实现](06_CPU_IMPLEMENTATION.md) - 理解 CPU
3. [PPU 系统](05_PPU_SYSTEM.md) - 理解 PPU
4. [调试指南](08_DEBUG_GUIDE.md) - 调试技巧

### 测试路径
1. [测试指南](03_TESTING_GUIDE.md) - 测试方法
2. [游戏兼容性](07_GAME_COMPATIBILITY.md) - 兼容性测试
3. [调试指南](08_DEBUG_GUIDE.md) - 问题排查

### 硬件路径
1. [Verilator 指南](04_VERILATOR_GUIDE.md) - 仿真
2. [CPU 实现](06_CPU_IMPLEMENTATION.md) - CPU 架构
3. [PPU 系统](05_PPU_SYSTEM.md) - PPU 架构

---

## 💡 文档使用技巧

### 搜索功能
使用 Ctrl+F (或 Cmd+F) 在文档中搜索关键词

### 交叉引用
每个文档底部都有相关文档链接

### 代码示例
所有代码示例都可以直接运行

### 更新频率
- 核心文档：随版本更新
- 专题文档：按需更新

---

## 🔄 文档维护

### 更新日志
- 2025-11-28: 创建 10 个核心文档
- 2025-11-27: 整理历史文档
- 2025-11-26: 初始文档结构

### 贡献指南
欢迎改进文档！请遵循：
1. 保持简洁明了
2. 使用代码示例
3. 添加图表说明
4. 更新索引

---

## 📞 获取帮助

### 文档问题
- 检查 [快速参考](10_QUICK_REFERENCE.md)
- 查看 [调试指南](08_DEBUG_GUIDE.md)
- 搜索相关文档

### 技术问题
- 查看 [常见问题](08_DEBUG_GUIDE.md#常见问题诊断)
- 运行测试验证
- 查看日志输出

---

**文档版本**: v1.0  
**最后更新**: 2025-11-28  
**维护者**: NES 开发团队

🎮 Happy Coding! 🎵
