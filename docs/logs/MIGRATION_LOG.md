# 文档迁移日志

## 迁移日期
2025-11-28

## 迁移目的
将对话过程中产生的中间文档和调试日志从 `docs/` 主目录迁移到 `docs/logs/` 目录，保持主目录的整洁。

## 迁移的文档

### 第一批迁移（早期）
1. `debugging-strategy.md` - 分阶段调试策略
2. `quick-start-debugging.md` - 快速调试指南
3. `verification-complete.md` - 验证完成记录
4. `bug-resolution.md` - Bug 解决记录
5. `initialization-analysis.md` - Donkey Kong 初始化分析

### 第二批迁移（本次）
6. `bug-analysis-dex-loop.md` - DEX 循环 Bug 分析
7. `FINAL_STRUCTURE.md` - 文档最终结构
8. `ARCHIVE_SUMMARY.md` - 文档归档总结

## 保留在主目录的文档

### 核心文档（10个）
- `01_PROJECT_OVERVIEW.md` - 项目概述
- `02_DEVELOPMENT_GUIDE.md` - 开发指南
- `03_TESTING_GUIDE.md` - 测试指南
- `04_VERILATOR_GUIDE.md` - Verilator 指南
- `05_PPU_SYSTEM.md` - PPU 系统
- `06_CPU_IMPLEMENTATION.md` - CPU 实现
- `07_GAME_COMPATIBILITY.md` - 游戏兼容性
- `08_DEBUG_GUIDE.md` - 调试指南
- `09_RELEASE_NOTES.md` - 发布说明
- `10_QUICK_REFERENCE.md` - 快速参考

### 导航文档
- `INDEX.md` - 文档索引
- `README.md` - 文档导航
- `README_NES.md` - NES 说明

### 参考文档
- `ARCHITECTURE.md` - 系统架构

### 当前状态文档
- `current-status.md` - 当前项目状态
- `next-steps.md` - 下一步计划
- `GAME_STATUS.md` - 游戏状态

### 技术文档
- `stage3-guide.md` - Stage 3 指南
- `stage3-optimization.md` - Stage 3 优化
- `optimization-summary.md` - 优化总结
- `performance-optimization.md` - 性能优化指南
- `ppu-registers.md` - PPU 寄存器说明
- `VERILATOR_PERFORMANCE.md` - Verilator 性能说明

## 文档分类原则

### 放在 `docs/logs/` 的文档
- ✅ 调试过程记录
- ✅ 临时分析报告
- ✅ 问题排查日志
- ✅ 实验性文档
- ✅ 文档整理记录
- ✅ Bug 分析记录

### 保留在 `docs/` 的文档
- ✅ 项目主要文档
- ✅ 稳定的技术文档
- ✅ 用户指南和手册
- ✅ API 和架构文档
- ✅ 当前状态和计划
- ✅ 正式的优化报告

## 最终统计

### docs/ 主目录
- 核心文档: 10 个
- 导航文档: 3 个
- 参考文档: 1 个
- 状态文档: 3 个
- 技术文档: 6 个
- **总计**: 23 个 .md 文件

### docs/logs/ 目录
- 调试策略: 2 个
- 问题解决: 3 个
- 分析报告: 1 个
- 整理记录: 3 个
- **总计**: 9 个 .md 文件

## 更新的文件

### 项目规范
- `.kiro/steering/project-conventions.md` - 添加了 logs 目录说明

### 文档索引
- `docs/INDEX.md` - 更新了文档地图，包含 logs 目录

### 日志说明
- `docs/logs/README.md` - 更新了文档列表

## 验证

```bash
# 检查主目录
ls -1 docs/*.md | wc -l
# 应该显示 23

# 检查 logs 目录
ls -1 docs/logs/*.md | wc -l
# 应该显示 9
```

## 维护建议

1. **新增文档时**：
   - 如果是调试过程、临时分析 → 放入 `docs/logs/`
   - 如果是正式文档、用户指南 → 放入 `docs/`

2. **定期清理**：
   - 每个月检查 `docs/logs/` 中的文档
   - 将有价值的内容整理成正式文档
   - 归档或删除过时的临时文档

3. **文档命名**：
   - 正式文档：使用清晰的名称（如 `performance-optimization.md`）
   - 日志文档：可以包含日期或阶段（如 `bug-analysis-dex-loop.md`）

## 完成时间
2025-11-28 18:00
