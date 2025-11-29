#!/usr/bin/env python3
"""
Translate Chinese comments in code to English - Version 2
"""

import re
import sys
from pathlib import Path

# Full sentence translations
SENTENCE_TRANSLATIONS = {
    # Common patterns
    "核心模块": "Core Module",
    "重构版": "Refactored Version",
    "寄存器": "Registers",
    "状态机": "State Machine",
    "内存接口": "Memory Interface",
    "调试接口": "Debug Interface",
    "中断信号": "Interrupt Signal",
    "边沿检测": "Edge Detection",
    "上升沿": "Rising Edge",
    "下降沿": "Falling Edge",
    "默认值": "Default Value",
    "初始化": "Initialize",
    "更新": "Update",
    "检测": "Detect",
    "设置": "Set",
    "清除": "Clear",
    "开始": "Start",
    "结束": "End",
    "读取": "Read",
    "写入": "Write",
    "执行": "Execute",
    "完成": "Complete",
    "等待": "Wait",
    "准备好": "Ready",
    "有效": "Valid",
    "无效": "Invalid",
    "启用": "Enable",
    "禁用": "Disable",
    "触发": "Trigger",
    "标志": "Flag",
    "向量": "Vector",
    "序列": "Sequence",
    "周期": "Cycle",
    "时钟": "Clock",
    "数据": "Data",
    "地址": "Address",
    "信号": "Signal",
    "输入": "Input",
    "输出": "Output",
    "接口": "Interface",
    "模块": "Module",
    "指令": "Instruction",
    "操作码": "Opcode",
    "操作数": "Operand",
    "结果": "Result",
    "状态": "State",
    "控制": "Control",
    "处理": "Process",
    "应用": "Apply",
    "保存": "Save",
    "恢复": "Restore",
    "增加": "Increase",
    "减少": "Decrease",
    "支持": "Support",
    "更长的": "Longer",
    "以": "to",
    "从": "from",
    "到": "to",
    "并": "and",
    "或": "or",
    "时": "when",
    "在": "at/in",
    "为": "as/for",
}

def translate_line(line):
    """Translate a line of code"""
    # If no Chinese, return as-is
    if not re.search(r'[\u4e00-\u9fff]', line):
        return line
    
    # Handle single-line comments
    if '//' in line:
        parts = line.split('//', 1)
        code = parts[0]
        comment = parts[1] if len(parts) > 1 else ''
        
        # Translate comment
        translated_comment = comment
        for cn, en in SENTENCE_TRANSLATIONS.items():
            translated_comment = translated_comment.replace(cn, en)
        
        # Remove remaining Chinese characters
        translated_comment = re.sub(r'[\u4e00-\u9fff]+', '', translated_comment)
        translated_comment = translated_comment.strip()
        
        if translated_comment:
            return code + '// ' + translated_comment + '\n'
        else:
            return code.rstrip() + '\n'
    
    # Handle multi-line comments
    if '/*' in line or '*/' in line or line.strip().startswith('*'):
        translated = line
        for cn, en in SENTENCE_TRANSLATIONS.items():
            translated = translated.replace(cn, en)
        # Remove remaining Chinese
        translated = re.sub(r'[\u4e00-\u9fff]+', '', translated)
        return translated
    
    return line

def translate_file(filepath):
    """Translate a file"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        translated_lines = [translate_line(line) for line in lines]
        
        # Check if anything changed
        if translated_lines != lines:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.writelines(translated_lines)
            return True
        
        return False
    except Exception as e:
        print(f"Error: {filepath}: {e}")
        return False

def main():
    project_root = Path(__file__).parent.parent
    src_dir = project_root / 'src'
    
    print("🌐 Translating code comments (v2)...")
    
    count = 0
    for scala_file in src_dir.rglob('*.scala'):
        if translate_file(scala_file):
            count += 1
            print(f"  ✅ {scala_file.relative_to(project_root)}")
    
    print(f"\n✅ Translated {count} files")

if __name__ == '__main__':
    main()
