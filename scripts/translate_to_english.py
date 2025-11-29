#!/usr/bin/env python3
"""
自动翻译项目文件到英文
Automatically translate project files to English
"""

import os
import re
import sys
from pathlib import Path

# 翻译映射表
TRANSLATIONS = {
    # 常用词汇
    "项目": "Project",
    "文档": "Documentation",
    "测试": "Test",
    "指南": "Guide",
    "报告": "Report",
    "总结": "Summary",
    "分析": "Analysis",
    "实现": "Implementation",
    "修复": "Fix",
    "问题": "Issue",
    "功能": "Feature",
    "版本": "Version",
    "更新": "Update",
    "开发": "Development",
    "调试": "Debug",
    "性能": "Performance",
    "优化": "Optimization",
    "架构": "Architecture",
    "设计": "Design",
    "代码": "Code",
    "注释": "Comment",
    
    # CPU 相关
    "处理器": "Processor",
    "指令": "Instruction",
    "寄存器": "Register",
    "状态机": "State Machine",
    "周期": "Cycle",
    "执行": "Execute",
    "取指": "Fetch",
    "译码": "Decode",
    
    # PPU 相关
    "渲染": "Rendering",
    "精灵": "Sprite",
    "背景": "Background",
    "扫描线": "Scanline",
    "像素": "Pixel",
    
    # 游戏相关
    "游戏": "Game",
    "兼容性": "Compatibility",
    "控制器": "Controller",
    "按键": "Button",
    
    # 状态
    "完成": "Complete",
    "进行中": "In Progress",
    "待修复": "To Fix",
    "已修复": "Fixed",
    "正常": "Normal",
    "错误": "Error",
    "警告": "Warning",
    
    # 动作
    "创建": "Create",
    "删除": "Delete",
    "修改": "Modify",
    "添加": "Add",
    "移除": "Remove",
    "更新": "Update",
    "检查": "Check",
    "验证": "Verify",
    "运行": "Run",
    "编译": "Compile",
    "构建": "Build",
    
    # 文件类型
    "源文件": "Source File",
    "配置文件": "Config File",
    "脚本": "Script",
    "库": "Library",
    
    # 其他
    "说明": "Description",
    "示例": "Example",
    "参考": "Reference",
    "链接": "Link",
    "目录": "Directory",
    "文件": "File",
    "路径": "Path",
    "命令": "Command",
    "选项": "Option",
    "参数": "Parameter",
    "返回": "Return",
    "输入": "Input",
    "输出": "Output",
    "结果": "Result",
    "成功": "Success",
    "失败": "Failure",
}

def translate_text(text):
    """简单的文本翻译"""
    for cn, en in TRANSLATIONS.items():
        text = text.replace(cn, en)
    return text

def should_skip_file(filepath):
    """检查是否应该跳过文件"""
    skip_dirs = {'.git', 'node_modules', 'target', 'build', 'generated'}
    skip_files = {'README_CN.md'}
    
    path = Path(filepath)
    
    # 跳过特定目录
    if any(skip_dir in path.parts for skip_dir in skip_dirs):
        return True
    
    # 跳过特定文件
    if path.name in skip_files:
        return True
    
    return False

def translate_file(filepath):
    """翻译单个文件"""
    if should_skip_file(filepath):
        return False
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 检查是否包含中文
        if not re.search(r'[\u4e00-\u9fff]', content):
            return False
        
        # 翻译内容
        translated = translate_text(content)
        
        # 写回文件
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(translated)
        
        return True
    except Exception as e:
        print(f"Error translating {filepath}: {e}")
        return False

def main():
    """主函数"""
    project_root = Path(__file__).parent.parent
    
    # 文件类型
    extensions = ['.scala', '.md', '.cpp', '.h', '.sh']
    
    translated_count = 0
    total_count = 0
    
    print("🌐 Starting translation...")
    print(f"Project root: {project_root}")
    
    for ext in extensions:
        print(f"\n📝 Processing {ext} files...")
        
        for filepath in project_root.rglob(f'*{ext}'):
            total_count += 1
            
            if translate_file(filepath):
                translated_count += 1
                print(f"  ✅ {filepath.relative_to(project_root)}")
    
    print(f"\n✅ Translation complete!")
    print(f"   Translated: {translated_count}/{total_count} files")

if __name__ == '__main__':
    main()
