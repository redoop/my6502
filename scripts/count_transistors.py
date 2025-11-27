#!/usr/bin/env python3
"""
6502 CPU 晶体管数量估算工具

分析生成的 Verilog 文件，估算所需的晶体管数量。
"""

import re
import sys
from pathlib import Path


def analyze_verilog(filepath):
    """分析 Verilog 文件并统计资源使用"""
    
    with open(filepath, 'r') as f:
        content = f.read()
    
    # 统计寄存器位数
    reg_bits = 0
    reg_details = []
    
    # 多位寄存器
    for match in re.finditer(r'reg\s+\[(\d+):(\d+)\]\s+(\w+);', content):
        high = int(match.group(1))
        low = int(match.group(2))
        name = match.group(3)
        bits = high - low + 1
        reg_bits += bits
        reg_details.append((name, bits))
    
    # 单比特寄存器
    single_bit_regs = []
    for match in re.finditer(r'reg\s+(\w+);', content):
        name = match.group(1)
        reg_bits += 1
        single_bit_regs.append(name)
    
    # 统计组合逻辑（wire）
    wire_count = len(re.findall(r'wire\s+', content))
    
    # 统计模块
    modules = re.findall(r'^module\s+(\w+)', content, re.MULTILINE)
    
    return {
        'reg_bits': reg_bits,
        'reg_details': reg_details,
        'single_bit_regs': single_bit_regs,
        'wire_count': wire_count,
        'modules': modules,
        'file_size': len(content),
        'line_count': content.count('\n')
    }


def estimate_transistors(stats):
    """估算晶体管数量"""
    
    # 每个寄存器位需要约 6 个晶体管 (D触发器)
    TRANSISTORS_PER_REG_BIT = 6
    
    # 每个 wire 平均需要约 4 个晶体管 (组合逻辑门)
    TRANSISTORS_PER_WIRE = 4
    
    reg_transistors = stats['reg_bits'] * TRANSISTORS_PER_REG_BIT
    logic_transistors = stats['wire_count'] * TRANSISTORS_PER_WIRE
    total_transistors = reg_transistors + logic_transistors
    
    return {
        'reg_transistors': reg_transistors,
        'logic_transistors': logic_transistors,
        'total_transistors': total_transistors
    }


def print_report(filepath, stats, transistors):
    """打印详细报告"""
    
    print("=" * 70)
    print(f"6502 CPU 晶体管数量分析报告")
    print("=" * 70)
    print(f"\n文件: {filepath}")
    print(f"大小: {stats['file_size']:,} 字节")
    print(f"行数: {stats['line_count']:,} 行")
    print(f"模块: {', '.join(stats['modules'])}")
    
    print(f"\n{'寄存器统计':=^70}")
    print(f"总位数: {stats['reg_bits']} bits")
    print(f"\n多位寄存器:")
    for name, bits in stats['reg_details']:
        print(f"  {name:20s} {bits:3d} bits  ({bits * 6:4d} 晶体管)")
    
    if stats['single_bit_regs']:
        print(f"\n单比特寄存器: {len(stats['single_bit_regs'])} 个")
        for name in stats['single_bit_regs'][:10]:  # 只显示前10个
            print(f"  {name}")
        if len(stats['single_bit_regs']) > 10:
            print(f"  ... 还有 {len(stats['single_bit_regs']) - 10} 个")
    
    print(f"\n{'组合逻辑统计':=^70}")
    print(f"Wire 数量: {stats['wire_count']}")
    
    print(f"\n{'晶体管估算':=^70}")
    print(f"寄存器 ({stats['reg_bits']} bits × 6):     {transistors['reg_transistors']:>8,} 个晶体管")
    print(f"组合逻辑 ({stats['wire_count']} wires × 4):  {transistors['logic_transistors']:>8,} 个晶体管")
    print(f"{'-' * 70}")
    print(f"总计:                          {transistors['total_transistors']:>8,} 个晶体管")
    
    print(f"\n{'与原版 6502 对比':=^70}")
    original_6502 = 3510
    difference = transistors['total_transistors'] - original_6502
    percentage = (difference / original_6502) * 100
    
    print(f"原版 MOS 6502 (1975):          {original_6502:>8,} 个晶体管")
    print(f"本项目实现:                    {transistors['total_transistors']:>8,} 个晶体管")
    print(f"差异:                          {difference:>+8,} 个晶体管 ({percentage:+.1f}%)")
    
    print(f"\n{'等效门数估算':=^70}")
    # 一个 NAND 门约等于 2 个晶体管
    gates = transistors['total_transistors'] / 2
    print(f"等效 NAND 门数:                {gates:>8,.0f} 个门")
    
    print(f"\n{'FPGA 资源估算':=^70}")
    # 一个 LUT 约等于 4-6 个门
    luts = gates / 5
    # 寄存器直接对应 FF
    ffs = stats['reg_bits']
    print(f"估算 LUT 数量:                 {luts:>8,.0f}")
    print(f"估算 FF 数量:                  {ffs:>8,}")
    
    print("\n" + "=" * 70)


def compare_implementations():
    """对比两个实现"""
    
    files = {
        'CPU6502 (原版)': 'generated/cpu6502/CPU6502.v',
        'CPU6502Refactored (重构版)': 'generated/cpu6502_refactored/CPU6502Refactored.v'
    }
    
    results = {}
    
    for name, filepath in files.items():
        path = Path(filepath)
        if not path.exists():
            print(f"警告: 文件不存在 - {filepath}")
            continue
        
        stats = analyze_verilog(path)
        transistors = estimate_transistors(stats)
        results[name] = (stats, transistors)
    
    if len(results) == 2:
        print("\n" + "=" * 70)
        print("两个实现对比")
        print("=" * 70)
        
        names = list(results.keys())
        stats1, trans1 = results[names[0]]
        stats2, trans2 = results[names[1]]
        
        print(f"\n{'指标':<30} {names[0]:>18} {names[1]:>18}")
        print("-" * 70)
        print(f"{'寄存器位数':<30} {stats1['reg_bits']:>18,} {stats2['reg_bits']:>18,}")
        print(f"{'Wire 数量':<30} {stats1['wire_count']:>18,} {stats2['wire_count']:>18,}")
        print(f"{'晶体管总数':<30} {trans1['total_transistors']:>18,} {trans2['total_transistors']:>18,}")
        print(f"{'Verilog 行数':<30} {stats1['line_count']:>18,} {stats2['line_count']:>18,}")
        
        diff = trans2['total_transistors'] - trans1['total_transistors']
        pct = (diff / trans1['total_transistors']) * 100
        print(f"\n差异: {diff:+,} 个晶体管 ({pct:+.1f}%)")


def main():
    """主函数"""
    
    if len(sys.argv) > 1:
        # 分析指定文件
        filepath = sys.argv[1]
        if not Path(filepath).exists():
            print(f"错误: 文件不存在 - {filepath}")
            sys.exit(1)
        
        stats = analyze_verilog(filepath)
        transistors = estimate_transistors(stats)
        print_report(filepath, stats, transistors)
    else:
        # 对比两个实现
        print("分析 CPU6502 实现...")
        print()
        
        # 分析重构版
        refactored_path = Path('generated/cpu6502_refactored/CPU6502Refactored.v')
        if refactored_path.exists():
            stats = analyze_verilog(refactored_path)
            transistors = estimate_transistors(stats)
            print_report(refactored_path, stats, transistors)
        
        # 对比
        compare_implementations()


if __name__ == '__main__':
    main()
