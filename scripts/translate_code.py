#!/usr/bin/env python3
"""
Translate Chinese comments in Scala code to English
翻译 Scala 代码中的中文注释为英文
"""

import re
import sys
from pathlib import Path

# Translation dictionary for common terms
TRANSLATIONS = {
    # CPU related
    "处理器": "Processor",
    "中央处理器": "CPU",
    "指令": "Instruction",
    "操作码": "Opcode",
    "寄存器": "Register",
    "累加器": "Accumulator",
    "索引寄存器": "Index Register",
    "栈指针": "Stack Pointer",
    "程序计数器": "Program Counter",
    "状态寄存器": "Status Register",
    "标志位": "Flag",
    "进位标志": "Carry Flag",
    "零标志": "Zero Flag",
    "负标志": "Negative Flag",
    "溢出标志": "Overflow Flag",
    "中断禁止": "Interrupt Disable",
    "十进制模式": "Decimal Mode",
    "断点": "Break",
    
    # State machine
    "状态机": "State Machine",
    "状态": "State",
    "周期": "Cycle",
    "时钟周期": "Clock Cycle",
    "取指": "Fetch",
    "译码": "Decode",
    "执行": "Execute",
    "完成": "Done",
    "重置": "Reset",
    
    # Memory
    "内存": "Memory",
    "地址": "Address",
    "数据": "Data",
    "读取": "Read",
    "写入": "Write",
    "地址总线": "Address Bus",
    "数据总线": "Data Bus",
    
    # Instructions
    "加法": "Addition",
    "减法": "Subtraction",
    "逻辑与": "Logical AND",
    "逻辑或": "Logical OR",
    "异或": "Exclusive OR",
    "左移": "Shift Left",
    "右移": "Shift Right",
    "循环左移": "Rotate Left",
    "循环右移": "Rotate Right",
    "比较": "Compare",
    "分支": "Branch",
    "跳转": "Jump",
    "子程序": "Subroutine",
    "返回": "Return",
    "压栈": "Push",
    "出栈": "Pop",
    "传送": "Transfer",
    "加载": "Load",
    "存储": "Store",
    "增量": "Increment",
    "减量": "Decrement",
    
    # Addressing modes
    "寻址模式": "Addressing Mode",
    "立即寻址": "Immediate",
    "零页寻址": "Zero Page",
    "绝对寻址": "Absolute",
    "索引寻址": "Indexed",
    "间接寻址": "Indirect",
    "相对寻址": "Relative",
    "隐含寻址": "Implied",
    
    # PPU related
    "图形处理单元": "Picture Processing Unit",
    "渲染": "Rendering",
    "精灵": "Sprite",
    "背景": "Background",
    "扫描线": "Scanline",
    "像素": "Pixel",
    "调色板": "Palette",
    "名称表": "Nametable",
    "图案表": "Pattern Table",
    "属性表": "Attribute Table",
    "垂直消隐": "Vertical Blank",
    "水平消隐": "Horizontal Blank",
    
    # NES related
    "游戏": "Game",
    "卡带": "Cartridge",
    "映射器": "Mapper",
    "控制器": "Controller",
    "按键": "Button",
    "方向键": "D-Pad",
    
    # Common terms
    "模块": "Module",
    "接口": "Interface",
    "信号": "Signal",
    "输入": "Input",
    "输出": "Output",
    "使能": "Enable",
    "禁用": "Disable",
    "触发": "Trigger",
    "检测": "Detect",
    "设置": "Set",
    "清除": "Clear",
    "更新": "Update",
    "初始化": "Initialize",
    "配置": "Configure",
    "默认": "Default",
    "当前": "Current",
    "下一个": "Next",
    "上一个": "Previous",
    "开始": "Start",
    "结束": "End",
    "有效": "Valid",
    "无效": "Invalid",
    "正常": "Normal",
    "错误": "Error",
    "警告": "Warning",
    "调试": "Debug",
    "测试": "Test",
    "示例": "Example",
    "注意": "Note",
    "重要": "Important",
    "待办": "TODO",
    "修复": "FIXME",
    
    # Actions
    "创建": "Create",
    "生成": "Generate",
    "计算": "Calculate",
    "检查": "Check",
    "验证": "Verify",
    "应用": "Apply",
    "保存": "Save",
    "恢复": "Restore",
    "复制": "Copy",
    "移动": "Move",
    "删除": "Delete",
    
    # Numbers and logic
    "位": "bit",
    "字节": "byte",
    "字": "word",
    "高字节": "High Byte",
    "低字节": "Low Byte",
    "最高位": "MSB",
    "最低位": "LSB",
    "真": "True",
    "假": "False",
    "是": "Yes",
    "否": "No",
    "或": "or",
    "和": "and",
    "非": "not",
    "如果": "if",
    "否则": "else",
    "当": "when",
    "直到": "until",
    "循环": "loop",
    "继续": "continue",
    "中断": "interrupt",
}

def translate_comment(comment):
    """Translate a single comment line"""
    # Remove comment markers
    cleaned = comment.strip()
    if cleaned.startswith('//'):
        cleaned = cleaned[2:].strip()
    elif cleaned.startswith('/*'):
        cleaned = cleaned[2:].strip()
    elif cleaned.startswith('*'):
        cleaned = cleaned[1:].strip()
    elif cleaned.endswith('*/'):
        cleaned = cleaned[:-2].strip()
    
    # Apply translations
    translated = cleaned
    for cn, en in TRANSLATIONS.items():
        translated = translated.replace(cn, en)
    
    return translated

def translate_file(filepath):
    """Translate Chinese comments in a Scala file"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        translated_lines = []
        in_multiline_comment = False
        modified = False
        
        for line in lines:
            # Check if line contains Chinese
            if re.search(r'[\u4e00-\u9fff]', line):
                # Single line comment
                if '//' in line:
                    code_part = line.split('//', 1)[0]
                    comment_part = '//' + line.split('//', 1)[1]
                    translated_comment = translate_comment(comment_part)
                    translated_lines.append(code_part + '// ' + translated_comment)
                    modified = True
                # Multi-line comment start
                elif '/*' in line:
                    in_multiline_comment = True
                    translated = translate_comment(line)
                    translated_lines.append('/* ' + translated + '\n')
                    modified = True
                # Multi-line comment content
                elif in_multiline_comment:
                    if '*/' in line:
                        in_multiline_comment = False
                        translated = translate_comment(line)
                        translated_lines.append(' * ' + translated + ' */\n')
                    else:
                        translated = translate_comment(line)
                        translated_lines.append(' * ' + translated + '\n')
                    modified = True
                else:
                    translated_lines.append(line)
            else:
                translated_lines.append(line)
        
        if modified:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.writelines(translated_lines)
            return True
        
        return False
        
    except Exception as e:
        print(f"Error translating {filepath}: {e}")
        return False

def main():
    """Main function"""
    project_root = Path(__file__).parent.parent
    src_dir = project_root / 'src'
    
    print("🌐 Translating Scala code comments to English...")
    print(f"Project root: {project_root}")
    print()
    
    translated_count = 0
    total_count = 0
    
    # Find all Scala files
    for scala_file in src_dir.rglob('*.scala'):
        total_count += 1
        
        if translate_file(scala_file):
            translated_count += 1
            print(f"  ✅ {scala_file.relative_to(project_root)}")
    
    print()
    print(f"✅ Translation complete!")
    print(f"   Translated: {translated_count}/{total_count} files")

if __name__ == '__main__':
    main()
