#!/usr/bin/env python3
"""
分析 CPU 执行日志，找出问题
"""

import sys
import re
from collections import defaultdict, deque

def parse_log_line(line):
    """解析日志行"""
    # 匹配格式: PC: 0xXXXX | A: 0xXX | X: 0xXX | Y: 0xXX | SP: 0xXX
    match = re.search(r'PC: 0x([0-9a-f]+).*SP: 0x([0-9a-f]+)', line, re.IGNORECASE)
    if match:
        pc = int(match.group(1), 16)
        sp = int(match.group(2), 16)
        return {'pc': pc, 'sp': sp}
    return None

def analyze_execution(log_file):
    """分析执行日志"""
    print("🔍 分析执行日志...")
    print("=" * 60)
    
    pc_history = deque(maxlen=100)
    sp_history = deque(maxlen=100)
    pc_frequency = defaultdict(int)
    
    vector_accesses = []
    sp_jumps = []
    
    with open(log_file, 'r') as f:
        for line_num, line in enumerate(f, 1):
            data = parse_log_line(line)
            if not data:
                continue
            
            pc = data['pc']
            sp = data['sp']
            
            # 记录历史
            pc_history.append(pc)
            sp_history.append(sp)
            pc_frequency[pc] += 1
            
            # 检测向量表访问
            if 0xFFF0 <= pc <= 0xFFFF:
                vector_accesses.append({
                    'line': line_num,
                    'pc': pc,
                    'sp': sp,
                    'history': list(pc_history)[-10:]
                })
            
            # 检测 SP 异常跳变
            if len(sp_history) >= 2:
                sp_change = abs(sp - sp_history[-2])
                if sp_change > 10:
                    sp_jumps.append({
                        'line': line_num,
                        'old_sp': sp_history[-2],
                        'new_sp': sp,
                        'change': sp_change,
                        'pc': pc
                    })
    
    # 报告结果
    print(f"\n📊 统计信息:")
    print(f"   总执行行数: {line_num}")
    print(f"   不同 PC 地址: {len(pc_frequency)}")
    
    # 最频繁的 PC
    print(f"\n🔥 最频繁的 PC 地址 (前 10):")
    sorted_pc = sorted(pc_frequency.items(), key=lambda x: x[1], reverse=True)
    for i, (pc, count) in enumerate(sorted_pc[:10], 1):
        print(f"   {i}. 0x{pc:04X}: {count} 次")
    
    # 向量表访问
    if vector_accesses:
        print(f"\n⚠️  向量表访问 ({len(vector_accesses)} 次):")
        for i, access in enumerate(vector_accesses[:10], 1):
            print(f"   {i}. 行 {access['line']}: PC=0x{access['pc']:04X}, SP=0x{access['sp']:02X}")
            print(f"      前 10 个 PC: {[f'0x{p:04X}' for p in access['history']]}")
    
    # SP 异常跳变
    if sp_jumps:
        print(f"\n⚠️  SP 异常跳变 ({len(sp_jumps)} 次):")
        for i, jump in enumerate(sp_jumps[:10], 1):
            print(f"   {i}. 行 {jump['line']}: 0x{jump['old_sp']:02X} -> 0x{jump['new_sp']:02X} "
                  f"(变化 {jump['change']}), PC=0x{jump['pc']:04X}")
    
    # 检测循环
    if len(pc_history) >= 10:
        recent_pc = list(pc_history)[-10:]
        if len(set(recent_pc)) <= 3:
            print(f"\n⚠️  可能陷入循环:")
            print(f"   最近 10 个 PC: {[f'0x{p:04X}' for p in recent_pc]}")
    
    print("\n" + "=" * 60)

def main():
    if len(sys.argv) < 2:
        print("用法: python3 analyze_execution.py <log_file>")
        print("示例: ./scripts/verilator_run.sh games/Donkey-Kong.nes 2>&1 | tee execution.log")
        print("      python3 scripts/analyze_execution.py execution.log")
        return 1
    
    log_file = sys.argv[1]
    analyze_execution(log_file)
    return 0

if __name__ == "__main__":
    sys.exit(main())
