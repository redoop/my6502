#!/usr/bin/env python3
"""
Safely translate Chinese comments in Scala source code
Only translates comments, preserves all code structure
"""

import re
from pathlib import Path

# Translation dictionary
TRANS = {
    # Core terms
    "核心模块": "Core Module",
    "重构版": "Refactored Version",
    "寄存器": "Registers",
    "状态机": "State Machine",
    "内存接口": "Memory Interface",
    "调试接口": "Debug Interface",
    "中断信号": "Interrupt Signal",
    "边沿检测": "Edge Detection",
    "上升沿": "Rising Edge",
    "默认值": "Default Value",
    "初始化": "Initialize",
    "更新": "Update",
    "检测": "Detect",
    "设置": "Set",
    "清除": "Clear",
    "开始": "Start",
    "读取": "Read",
    "写入": "Write",
    "执行": "Execute",
    "完成": "Complete",
    "等待": "Wait",
    "准备好": "Ready",
    "有效": "Valid",
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
    "增加": "Increase",
    "支持": "Support",
    "更长的": "Longer",
    "以": "to",
    "从": "from",
    "到": "to",
    "并": "and",
    "或": "or",
    "时": "when",
    "在": "in",
    "为": "for",
    "的": "",
    "了": "",
}

def translate_comment(text):
    """Translate Chinese in comment"""
    for cn, en in TRANS.items():
        text = text.replace(cn, en)
    # Remove remaining Chinese
    text = re.sub(r'[\u4e00-\u9fff]+', '', text)
    return text.strip()

def process_line(line):
    """Process a single line"""
    if not re.search(r'[\u4e00-\u9fff]', line):
        return line
    
    # Single line comment
    if '//' in line:
        parts = line.split('//', 1)
        if len(parts) == 2:
            code = parts[0]
            comment = translate_comment(parts[1])
            if comment:
                return f"{code}// {comment}\n"
            return code.rstrip() + '\n'
    
    # Multi-line comment markers
    if '/*' in line or '*/' in line or line.strip().startswith('*'):
        return '// ' + translate_comment(line) + '\n'
    
    return line

def translate_file(filepath):
    """Translate a file"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        new_lines = [process_line(line) for line in lines]
        
        if new_lines != lines:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.writelines(new_lines)
            return True
        return False
    except Exception as e:
        print(f"Error: {filepath}: {e}")
        return False

def main():
    root = Path(__file__).parent.parent
    src = root / 'src'
    
    print("🌐 Translating Scala comments...")
    
    count = 0
    for f in src.rglob('*.scala'):
        if translate_file(f):
            count += 1
            print(f"  ✅ {f.relative_to(root)}")
    
    print(f"\n✅ Translated {count} files")

if __name__ == '__main__':
    main()
