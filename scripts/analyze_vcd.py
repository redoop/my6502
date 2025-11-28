#!/usr/bin/env python3
"""
分析 VCD 波形文件，提取 CPU 执行流程
"""

import sys
import re

def parse_vcd(filename):
    """解析 VCD 文件，提取关键信号"""
    
    signals = {}
    signal_map = {}
    current_time = 0
    events = []
    
    with open(filename, 'r') as f:
        in_definitions = True
        
        for line in f:
            line = line.strip()
            
            # 解析信号定义
            if in_definitions:
                if line.startswith('$var'):
                    # $var wire 16 ! io_debug_pc [15:0] $end
                    parts = line.split()
                    if len(parts) >= 5:
                        signal_id = parts[3]
                        signal_name = parts[4]
                        signal_map[signal_id] = signal_name
                        
                elif line.startswith('$enddefinitions'):
                    in_definitions = False
                    
            else:
                # 解析时间戳
                if line.startswith('#'):
                    current_time = int(line[1:])
                    
                # 解析信号变化
                elif line:
                    # 二进制值: b1010 !
                    # 单bit值: 0! 或 1!
                    if line.startswith('b'):
                        match = re.match(r'b([01x]+)\s+(.+)', line)
                        if match:
                            value = match.group(1)
                            sig_id = match.group(2)
                            if sig_id in signal_map:
                                sig_name = signal_map[sig_id]
                                # 转换为十六进制
                                try:
                                    int_val = int(value.replace('x', '0'), 2)
                                    events.append((current_time, sig_name, int_val))
                                except:
                                    pass
                    else:
                        # 单bit信号
                        if len(line) >= 2:
                            value = line[0]
                            sig_id = line[1:]
                            if sig_id in signal_map:
                                sig_name = signal_map[sig_id]
                                events.append((current_time, sig_name, int(value) if value in '01' else 0))
    
    return events

def analyze_cpu_execution(events):
    """分析 CPU 执行流程"""
    
    # 按时间组织事件
    time_events = {}
    for time, signal, value in events:
        if time not in time_events:
            time_events[time] = {}
        time_events[time][signal] = value
    
    # 提取 CPU 状态
    cpu_states = []
    last_state = {}
    
    for time in sorted(time_events.keys()):
        state = time_events[time]
        
        # 更新当前状态
        for sig, val in state.items():
            last_state[sig] = val
        
        # 如果有关键信号变化，记录
        if 'io_debug_regPC' in state or 'io_debug_state' in state:
            cpu_states.append((time, dict(last_state)))
    
    return cpu_states

def print_cpu_trace(cpu_states):
    """打印 CPU 执行轨迹"""
    
    print("=" * 80)
    print("CPU 执行轨迹分析")
    print("=" * 80)
    print()
    
    state_names = {
        0: "Reset",
        1: "Fetch",
        2: "Execute",
        3: "NMI",
        4: "Done"
    }
    
    last_pc = None
    last_state = None
    pc_changes = []
    
    for i, (time, state) in enumerate(cpu_states[:200]):  # 只显示前200个状态
        pc = state.get('io_debug_regPC', 0)
        cpu_state = state.get('io_debug_state', 0)
        cycle = state.get('io_debug_cycle', 0)
        opcode = state.get('io_debug_opcode', 0)
        a = state.get('io_debug_regA', 0)
        x = state.get('io_debug_regX', 0)
        y = state.get('io_debug_regY', 0)
        sp = state.get('io_debug_regSP', 0)
        
        # 只在 PC 或状态变化时打印
        if pc != last_pc or cpu_state != last_state:
            state_name = state_names.get(cpu_state, f"Unknown({cpu_state})")
            
            print(f"时间 {time:6d}: PC=0x{pc:04X} State={state_name:8s} "
                  f"Cycle={cycle} Op=0x{opcode:02X} "
                  f"A=0x{a:02X} X=0x{x:02X} Y=0x{y:02X} SP=0x{sp:02X}")
            
            if pc != last_pc:
                pc_changes.append((time, pc, cpu_state))
            
            last_pc = pc
            last_state = cpu_state
    
    print()
    print("=" * 80)
    print("PC 变化统计")
    print("=" * 80)
    
    # 统计 PC 访问频率
    pc_freq = {}
    for _, pc, _ in pc_changes:
        pc_freq[pc] = pc_freq.get(pc, 0) + 1
    
    print("\n最频繁访问的 PC 地址:")
    for pc, count in sorted(pc_freq.items(), key=lambda x: x[1], reverse=True)[:20]:
        print(f"  0x{pc:04X}: {count} 次")
    
    # 检查是否卡在向量表
    vector_table_accesses = [pc for pc in pc_freq.keys() if 0xFFF0 <= pc <= 0xFFFF]
    if vector_table_accesses:
        print(f"\n⚠️  检测到向量表访问: {len(vector_table_accesses)} 个不同地址")
        for pc in sorted(vector_table_accesses):
            print(f"  0x{pc:04X}: {pc_freq[pc]} 次")

def main():
    if len(sys.argv) < 2:
        print("用法: python3 analyze_vcd.py <vcd文件>")
        sys.exit(1)
    
    vcd_file = sys.argv[1]
    
    print(f"📊 分析 VCD 文件: {vcd_file}")
    print()
    
    events = parse_vcd(vcd_file)
    print(f"✅ 解析完成，共 {len(events)} 个事件")
    print()
    
    cpu_states = analyze_cpu_execution(events)
    print(f"✅ 提取了 {len(cpu_states)} 个 CPU 状态")
    print()
    
    print_cpu_trace(cpu_states)

if __name__ == '__main__':
    main()
