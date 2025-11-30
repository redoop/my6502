# 项目组织策略

## 目录结构

```
my6502/
├── README.md              # 项目主文档（保留在根目录）
├── docs/                  # 所有文档
│   ├── 中文文档.md
│   ├── English docs.md
│   └── ...
├── scripts/               # 所有脚本
│   ├── *.sh              # Shell脚本
│   ├── *.py              # Python脚本
│   └── ...
├── src/                   # 源代码
├── games/                 # ROM文件
└── ...
```

## 文件放置规则

### 文档 (docs/)
- 所有 `.md` 文件（除了根目录的 README.md）
- 技术文档、实现总结、测试报告等
- 中英文文档都放在此目录

### 脚本 (scripts/)
- 所有 `.sh` 脚本
- 所有 `.py` 脚本
- 测试、构建、分析等工具脚本

### 根目录
- 仅保留 `README.md` 作为项目入口文档
- 其他配置文件（如 .gitignore）

## 脚本使用

从项目根目录运行脚本：
```bash
./scripts/run_smb.sh
./scripts/test_audio.sh
./scripts/verify_roms.sh
```

或进入scripts目录：
```bash
cd scripts
./run_smb.sh
```

## 注意事项

- 脚本中的路径已更新为相对于scripts目录
- 文档之间的引用需要使用相对路径
- 保持目录结构清晰，便于维护
