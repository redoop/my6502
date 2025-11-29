# 📚 NES 模拟器文档索引

**最后更新**: 2025-11-29  
**版本**: v0.7.1

---

## 🚀 快速开始

### 新手必读
1. **[快速开始指南](QUICK_START.md)** ⭐ 5 分钟上手
2. **[项目概述](01_PROJECT_OVERVIEW.md)** - 了解项目
3. **[游戏兼容性报告](GAME_COMPATIBILITY_REPORT.md)** - 查看测试结果

### 开发者必读
1. **[开发指南](02_DEVELOPMENT_GUIDE.md)** - 开发环境设置
2. **[测试指南](03_TESTING_GUIDE.md)** - 运行和编写测试
3. **[贡献指南](../CONTRIBUTING.md)** - 如何贡献代码

---

## 📖 核心文档（10 个）

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

### 4. [Verilator 指南](04_VERILATOR_GUIDE.md)

**内容**:
- Verilator 简介
- 环境配置
- 编译和运行
- 性能优化
- VCD 波形分析
- 调试技巧

**适合**: 硬件仿真、调试

---

### 5. [PPU 系统](05_PPU_SYSTEM.md)

**内容**:
- PPU 架构
- 渲染管线
- 寄存器详解
- 背景渲染
- 精灵渲染
- Sprite 0 Hit
- 调试方法

**适合**: PPU 开发、图形

---

### 6. [CPU 实现](06_CPU_IMPLEMENTATION.md)

**内容**:
- CPU 架构
- 指令集详解
- 寻址模式
- 状态机设计
- 中断处理
- 性能分析

**适合**: CPU 开发、指令

---

### 7. [游戏兼容性](07_GAME_COMPATIBILITY.md)

**内容**:
- 游戏测试方法
- 兼容性报告
- 已知问题
- Mapper 支持
- 调试游戏问题

**适合**: 游戏测试、兼容性

---

### 8. [调试指南](08_DEBUG_GUIDE.md)

**内容**:
- 调试工具
- 日志分析
- VCD 波形
- 常见问题
- 调试技巧

**适合**: 调试、问题排查

---

### 9. [发布说明](09_RELEASE_NOTES.md)

**内容**:
- 版本历史
- 变更日志
- 已知问题
- 升级指南

**适合**: 了解版本变化

---

### 10. [快速参考](10_QUICK_REFERENCE.md) ⭐ 速查表

**内容**:
- 常用命令
- 快捷键
- 寄存器映射
- 内存映射
- 指令速查

**适合**: 日常开发参考

---

## 📋 补充文档

### 新增文档 (v0.7.1)

#### [快速开始指南](QUICK_START.md) ⭐ 新！
5 分钟快速上手，包含：
- 3 步快速运行
- 控制方式
- 常用命令
- 常见问题

#### [游戏兼容性报告](GAME_COMPATIBILITY_REPORT.md) ⭐ 新！
完整的测试报告，包含：
- 3 款游戏测试结果
- 已修复的问题详解
- 当前问题分析
- 系统组件评分

#### [更新日志](../CHANGELOG.md) ⭐ 新！
详细的版本历史，包含：
- v0.7.1 关键修复
- 每个版本的变更
- 问题修复详情
- 新功能说明

#### [贡献指南](../CONTRIBUTING.md) ⭐ 新！
如何贡献代码，包含：
- 贡献流程
- 代码规范
- Commit 规范
- PR 模板

#### [故障排除指南](TROUBLESHOOTING.md) ⭐ 新！
常见问题解决，包含：
- 编译问题
- 运行问题
- 测试问题
- 性能问题
- 已知问题

---

### 参考文档

#### [完整架构](ARCHITECTURE.md)
- 系统架构详解
- 模块交互
- 数据流

#### [技术细节](archive/TECHNICAL_DETAILS.md)
- 实现细节
- 优化技巧
- 性能分析

---

## 📊 测试和报告

### 测试文档
- [测试指南](03_TESTING_GUIDE.md) - 如何测试
- [游戏兼容性](07_GAME_COMPATIBILITY.md) - 游戏测试
- [游戏兼容性报告](GAME_COMPATIBILITY_REPORT.md) - 详细结果

### 调试文档
- [调试指南](08_DEBUG_GUIDE.md) - 调试方法
- [故障排除](TROUBLESHOOTING.md) - 常见问题
- [CPU 修复总结](logs/cpu_fix_summary.md) - 最新修复

---

## 🔗 外部资源

### 6502 相关
- [6502 指令集](http://www.6502.org/tutorials/6502opcodes.html)
- [Visual 6502](http://www.visual6502.org/)
- [6502 编程手册](http://archive.6502.org/books/mcs6500_family_programming_manual.pdf)

### NES 相关
- [NESDev Wiki](https://www.nesdev.org/wiki/)
- [NES 参考指南](https://www.nesdev.org/NESDoc.pdf)

### Chisel 相关
- [Chisel 文档](https://www.chisel-lang.org/)
- [Chisel Bootcamp](https://github.com/freechipsproject/chisel-bootcamp)

---

## 📁 文档组织

```
docs/
├── INDEX.md                          # 本文件
├── QUICK_START.md                    # 快速开始 ⭐ 新！
├── GAME_COMPATIBILITY_REPORT.md      # 游戏兼容性报告 ⭐ 新！
├── TROUBLESHOOTING.md                # 故障排除 ⭐ 新！
├── 01_PROJECT_OVERVIEW.md            # 项目概述
├── 02_DEVELOPMENT_GUIDE.md           # 开发指南
├── 03_TESTING_GUIDE.md               # 测试指南
├── 04_VERILATOR_GUIDE.md             # Verilator 指南
├── 05_PPU_SYSTEM.md                  # PPU 系统
├── 06_CPU_IMPLEMENTATION.md          # CPU 实现
├── 07_GAME_COMPATIBILITY.md          # 游戏兼容性
├── 08_DEBUG_GUIDE.md                 # 调试指南
├── 09_RELEASE_NOTES.md               # 发布说明
├── 10_QUICK_REFERENCE.md             # 快速参考
├── ARCHITECTURE.md                   # 完整架构
├── logs/                             # 调试日志
│   ├── cpu_fix_summary.md           # CPU 修复总结
│   ├── cpu_deadlock_analysis.md     # 问题分析
│   └── session_summary_2025-11-29.md # 工作总结
└── archive/                          # 历史文档
    └── (64 个历史文档)
```

---

## 🎯 文档导航

### 按角色

**新手用户**:
1. [快速开始](QUICK_START.md)
2. [项目概述](01_PROJECT_OVERVIEW.md)
3. [游戏兼容性报告](GAME_COMPATIBILITY_REPORT.md)

**开发者**:
1. [开发指南](02_DEVELOPMENT_GUIDE.md)
2. [CPU 实现](06_CPU_IMPLEMENTATION.md)
3. [测试指南](03_TESTING_GUIDE.md)

**贡献者**:
1. [贡献指南](../CONTRIBUTING.md)
2. [代码规范](02_DEVELOPMENT_GUIDE.md#代码规范)
3. [测试指南](03_TESTING_GUIDE.md)

**调试人员**:
1. [调试指南](08_DEBUG_GUIDE.md)
2. [故障排除](TROUBLESHOOTING.md)
3. [Verilator 指南](04_VERILATOR_GUIDE.md)

---

### 按任务

**运行游戏**:
1. [快速开始](QUICK_START.md)
2. [故障排除](TROUBLESHOOTING.md)
3. [游戏兼容性](07_GAME_COMPATIBILITY.md)

**开发新功能**:
1. [开发指南](02_DEVELOPMENT_GUIDE.md)
2. [CPU 实现](06_CPU_IMPLEMENTATION.md)
3. [测试指南](03_TESTING_GUIDE.md)

**修复 Bug**:
1. [调试指南](08_DEBUG_GUIDE.md)
2. [故障排除](TROUBLESHOOTING.md)
3. [CPU 修复总结](logs/cpu_fix_summary.md)

**测试游戏**:
1. [游戏兼容性](07_GAME_COMPATIBILITY.md)
2. [测试指南](03_TESTING_GUIDE.md)
3. [游戏兼容性报告](GAME_COMPATIBILITY_REPORT.md)

---

## 📝 文档更新

### 最近更新 (v0.7.1 - 2025-11-29)

- ✨ 新增 [快速开始指南](QUICK_START.md)
- ✨ 新增 [游戏兼容性报告](GAME_COMPATIBILITY_REPORT.md)
- ✨ 新增 [更新日志](../CHANGELOG.md)
- ✨ 新增 [贡献指南](../CONTRIBUTING.md)
- ✨ 新增 [故障排除指南](TROUBLESHOOTING.md)
- 🔄 更新 [项目概述](01_PROJECT_OVERVIEW.md) - 添加最新状态
- 🔄 更新 [README](../README.md) - 添加游戏兼容性表格

---

## 🔍 搜索文档

### 按关键词

- **CPU**: [CPU 实现](06_CPU_IMPLEMENTATION.md), [CPU 修复](logs/cpu_fix_summary.md)
- **PPU**: [PPU 系统](05_PPU_SYSTEM.md)
- **游戏**: [游戏兼容性](07_GAME_COMPATIBILITY.md), [游戏报告](GAME_COMPATIBILITY_REPORT.md)
- **测试**: [测试指南](03_TESTING_GUIDE.md)
- **调试**: [调试指南](08_DEBUG_GUIDE.md), [故障排除](TROUBLESHOOTING.md)
- **开发**: [开发指南](02_DEVELOPMENT_GUIDE.md)
- **贡献**: [贡献指南](../CONTRIBUTING.md)

---

## 💡 建议阅读顺序

### 第一次使用
1. [快速开始](QUICK_START.md) - 5 分钟
2. [项目概述](01_PROJECT_OVERVIEW.md) - 10 分钟
3. [游戏兼容性报告](GAME_COMPATIBILITY_REPORT.md) - 5 分钟

### 开始开发
1. [开发指南](02_DEVELOPMENT_GUIDE.md) - 30 分钟
2. [CPU 实现](06_CPU_IMPLEMENTATION.md) - 20 分钟
3. [测试指南](03_TESTING_GUIDE.md) - 15 分钟

### 深入理解
1. [完整架构](ARCHITECTURE.md) - 1 小时
2. [PPU 系统](05_PPU_SYSTEM.md) - 30 分钟
3. [Verilator 指南](04_VERILATOR_GUIDE.md) - 20 分钟

---

## 📞 获取帮助

- 📖 查看 [故障排除指南](TROUBLESHOOTING.md)
- 🐛 提交 [Issue](https://github.com/redoop/my6502/issues)
- 💬 参与 [讨论](https://github.com/redoop/my6502/discussions)

---

**准备好了吗？** 从 [快速开始](QUICK_START.md) 开始吧！ 🚀

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
├── 导航文档 (3 个)
│   ├── INDEX.md                  文档索引
│   ├── README.md                 文档导航
│   └── ARCHITECTURE.md           完整架构文档
│
├── 图片 (1 个)
│   └── my6502.png                芯片布局图
│
├── logs/ (工作日志和技术文档 - 20 个)
│   ├── README.md                 日志说明
│   │
│   ├── 当前状态 (3 个)
│   │   ├── current-status.md     当前项目状态
│   │   ├── next-steps.md         下一步计划
│   │   └── GAME_STATUS.md        游戏测试状态
│   │
│   ├── 技术文档 (7 个)
│   │   ├── stage3-guide.md       Stage 3 指南
│   │   ├── stage3-optimization.md Stage 3 优化
│   │   ├── optimization-summary.md 优化总结
│   │   ├── performance-optimization.md 性能优化
│   │   ├── ppu-registers.md      PPU 寄存器
│   │   ├── VERILATOR_PERFORMANCE.md Verilator 性能
│   │   └── README_NES.md         NES 说明
│   │
│   ├── 调试记录 (5 个)
│   │   ├── debugging-strategy.md 调试策略
│   │   ├── quick-start-debugging.md 快速调试
│   │   ├── bug-resolution.md     Bug 解决
│   │   ├── bug-analysis-dex-loop.md DEX 循环分析
│   │   └── verification-complete.md 验证记录
│   │
│   ├── 分析报告 (1 个)
│   │   └── initialization-analysis.md 初始化分析
│   │
│   └── 整理记录 (3 个)
│       ├── FINAL_STRUCTURE.md    文档结构
│       ├── ARCHIVE_SUMMARY.md    归档总结
│       └── MIGRATION_LOG.md      迁移日志
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

---

## 📂 文档目录结构

### 核心文档 (根目录)
```
docs/
├── 01_PROJECT_OVERVIEW.md      # 项目概述
├── 02_DEVELOPMENT_GUIDE.md     # 开发指南
├── 03_TESTING_GUIDE.md         # 测试指南
├── 04_VERILATOR_GUIDE.md       # Verilator 指南
├── 05_PPU_SYSTEM.md            # PPU 系统
├── 06_CPU_IMPLEMENTATION.md    # CPU 实现
├── 07_GAME_COMPATIBILITY.md    # 游戏兼容性
├── 08_DEBUG_GUIDE.md           # 调试指南
├── 09_RELEASE_NOTES.md         # 发布说明
├── 10_QUICK_REFERENCE.md       # 快速参考
├── INDEX.md                    # 本文件
├── README.md                   # 文档说明
├── ARCHITECTURE.md             # 完整架构
└── STRUCTURE.md                # 文档结构说明
```

### 子目录分类
```
docs/
├── guides/          # 指南类 (3个)
│   ├── BUILD_AND_TEST_GUIDE.md
│   ├── TROUBLESHOOTING.md
│   └── QUICK_START.md
├── testing/         # 测试相关 (8个)
│   ├── PPU_APU_TEST_*.md
│   ├── CPU_INSTRUCTION_TEST_*.md
│   └── test_results_*.md
├── reports/         # 报告类 (5个)
│   ├── GAME_COMPATIBILITY_REPORT.md
│   ├── TEST_REPORT_*.md
│   └── SESSION_SUMMARY_*.md
├── checklists/      # 检查清单 (2个)
│   ├── GAME_COMPATIBILITY_CHECKLIST.md
│   └── NES_TEST_MILESTONE_P0.md
├── logs/            # 日志和分析 (10+个)
│   ├── cpu_*.md
│   ├── nmi_*.md
│   └── session_*.md
└── archive/         # 历史文档 (64个)
```

**详细说明**: 查看 [STRUCTURE.md](STRUCTURE.md)

