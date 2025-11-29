# Translation Plan / 翻译计划

**Created**: 2025-11-30  
**Status**: Planning Phase

---

## 📊 Translation Scope / 翻译范围

### Files to Translate / 需要翻译的文件
- **Scala files**: 72 files
- **Markdown docs**: 222 files  
- **C++ files**: 1 file
- **Total**: 295 files

### Estimated Effort / 预估工作量
- **Full translation**: 40-60 hours
- **Core translation**: 10-15 hours
- **Code comments only**: 5-8 hours

---

## 🎯 Translation Strategy / 翻译策略

### Phase 1: Critical Documents (Priority 1) / 阶段1：关键文档
**Estimated time**: 3-4 hours

#### Root Level / 根目录
- [ ] README.md (already mostly English)
- [ ] CHANGELOG.md
- [ ] CONTRIBUTING.md

#### Core Documentation / 核心文档 (docs/)
- [ ] INDEX.md
- [ ] STRUCTURE.md
- [ ] 01_PROJECT_OVERVIEW.md
- [ ] 02_DEVELOPMENT_GUIDE.md
- [ ] 03_TESTING_GUIDE.md
- [ ] 04_VERILATOR_GUIDE.md
- [ ] 05_PPU_SYSTEM.md
- [ ] 06_CPU_IMPLEMENTATION.md
- [ ] 07_GAME_COMPATIBILITY.md
- [ ] 08_DEBUG_GUIDE.md
- [ ] 09_RELEASE_NOTES.md
- [ ] 10_QUICK_REFERENCE.md

---

### Phase 2: Code Comments (Priority 2) / 阶段2：代码注释
**Estimated time**: 5-8 hours

#### Key Modules / 关键模块
- [ ] src/main/scala/cpu/core/*.scala
- [ ] src/main/scala/cpu/instructions/*.scala
- [ ] src/main/scala/nes/*.scala
- [ ] verilator/testbench_main.cpp

---

### Phase 3: Supporting Documents (Priority 3) / 阶段3：支持文档
**Estimated time**: 8-10 hours

#### Subdirectories / 子目录
- [ ] docs/guides/*.md
- [ ] docs/testing/*.md
- [ ] docs/reports/*.md
- [ ] docs/checklists/*.md
- [ ] docs/logs/*.md (recent only)

---

### Phase 4: Archive (Priority 4) / 阶段4：归档文档
**Estimated time**: 20-30 hours

- [ ] docs/archive/*.md (64 files)
- [ ] Other historical documents

---

## 🛠️ Translation Tools / 翻译工具

### Option 1: Manual Translation / 手动翻译
**Pros**:
- Highest quality
- Context-aware
- Technical accuracy

**Cons**:
- Time-consuming
- Requires bilingual expertise

### Option 2: AI-Assisted Translation / AI 辅助翻译
**Pros**:
- Fast
- Consistent terminology
- Good for technical content

**Cons**:
- Requires review
- May miss context

### Option 3: Hybrid Approach / 混合方式
**Recommended**: Use AI for first pass, manual review for accuracy

---

## 📋 Translation Guidelines / 翻译指南

### Technical Terms / 技术术语
Keep consistent translations:
- 处理器 → Processor
- 指令 → Instruction
- 寄存器 → Register
- 状态机 → State Machine
- 渲染 → Rendering
- 精灵 → Sprite
- 扫描线 → Scanline

### Code Comments / 代码注释
Format:
```scala
// Original Chinese comment
// English translation
```

Or replace entirely with English.

### Documentation / 文档
- Translate titles and headers
- Translate body text
- Keep code examples as-is
- Update links if needed

---

## 🚀 Quick Start / 快速开始

### For Phase 1 (Critical Documents)

1. **Backup first** / 先备份:
```bash
git checkout -b translation-phase1
```

2. **Translate files** / 翻译文件:
   - Use AI tool (ChatGPT, DeepL, etc.)
   - Review for technical accuracy
   - Test all links

3. **Commit changes** / 提交更改:
```bash
git add docs/
git commit -m "docs: translate core documentation to English"
```

---

## 📊 Progress Tracking / 进度跟踪

### Phase 1: Critical Documents
- [ ] 0/15 files completed

### Phase 2: Code Comments  
- [ ] 0/72 files completed

### Phase 3: Supporting Documents
- [ ] 0/30 files completed

### Phase 4: Archive
- [ ] 0/64 files completed

**Overall Progress**: 0/181 files (0%)

---

## 🎯 Next Steps / 下一步

### Immediate Actions / 立即行动
1. Decide on translation approach
2. Set up translation workflow
3. Start with Phase 1

### Tools Needed / 需要的工具
- Translation tool (ChatGPT, DeepL, etc.)
- Text editor with find/replace
- Git for version control

### Timeline / 时间表
- **Phase 1**: 1 week
- **Phase 2**: 2 weeks  
- **Phase 3**: 2 weeks
- **Phase 4**: 3-4 weeks

**Total**: 8-9 weeks for complete translation

---

## 💡 Recommendations / 建议

### Priority Order / 优先级顺序
1. **Start with Phase 1** - Most visible to users
2. **Then Phase 2** - Improves code readability
3. **Phase 3 as needed** - Based on usage
4. **Phase 4 optional** - Archive is low priority

### Quality Over Speed / 质量优先
- Don't rush translation
- Review technical terms carefully
- Test documentation after translation
- Get feedback from users

---

## 📝 Notes / 注意事项

### What NOT to Translate / 不要翻译的内容
- Code syntax
- Variable names
- File paths
- URLs
- Command examples
- Error messages (keep original)

### What TO Translate / 需要翻译的内容
- Documentation text
- Comments
- Commit messages (future)
- User-facing strings

---

## 🔗 Resources / 资源

### Translation Tools / 翻译工具
- ChatGPT: https://chat.openai.com
- DeepL: https://www.deepl.com
- Google Translate: https://translate.google.com

### Style Guides / 风格指南
- Technical writing best practices
- Markdown formatting
- Code comment conventions

---

**Status**: Ready to begin Phase 1  
**Next Action**: Choose translation tool and start with critical documents

---

**Note**: This is a living document. Update progress as translation proceeds.
