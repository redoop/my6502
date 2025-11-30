#!/usr/bin/env python3
"""分析 VBlank 信号链路"""

import sys

def parse_vcd(filename):
    """解析 VCD 文件，提取关键信号"""
    
    # 信号映射
    signals = {}
    signal_names = {
        'debug_vblank': None,
        'debug_vblank_sync1': None,
        'debug_vblank_sync2': None,
        'debug_ppustatus': None,
        'debug_nmi': None,
        'debug_ppuctrl': None,
        'debug_cpu_addr': None,
        'debug_cpu_rw': None,
        'cpu_clk': None,
        'ppu_clk': None,
    }
    
    # 当前值
    current_values = {}
    
    # 读取 VCD
    with open(filename, 'r') as f:
        in_definitions = True
        
        for line in f:
            line = line.strip()
            
            # 解析变量定义
            if in_definitions:
                if line.startswith('$var'):
                    parts = line.split()
                    if len(parts) >= 5:
                        var_name = parts[4]
                        var_id = parts[3]
                        
                        # 精确匹配信号名
                        if var_name in signal_names:
                            signal_names[var_name] = var_id
                            current_values[var_id] = '0'
                                
                elif line.startswith('$enddefinitions'):
                    in_definitions = False
                    print("找到的信号:")
                    for name, vid in signal_names.items():
                        if vid:
                            print(f"  {name}: {vid}")
                    print()
                    
            # 解析值变化
            else:
                if line.startswith('#'):
                    # 时间戳
                    timestamp = int(line[1:])
                    
                elif line and not line.startswith('$'):
                    # 值变化
                    if line[0] in '01xz':
                        value = line[0]
                        var_id = line[1:]
                    elif line[0] == 'b':
                        # 多位值 b10101010 identifier
                        parts = line.split()
                        value = parts[0][1:]  # 去掉 'b'
                        var_id = parts[1] if len(parts) > 1 else ''
                    else:
                        continue
                    
                    if var_id in current_values:
                        old_value = current_values[var_id]
                        current_values[var_id] = value
                        
                        # 检测关键变化
                        # VBlank 上升沿
                        if var_id == signal_names['debug_vblank'] and old_value == '0' and value == '1':
                            print(f"[{timestamp:8d}] PPU VBlank 上升沿: 0 -> 1")
                            print_state(timestamp, signal_names, current_values)
                            
                        # VBlank sync1 变化
                        if var_id == signal_names['debug_vblank_sync1']:
                            print(f"[{timestamp:8d}] vblank_sync1: {old_value} -> {value}")
                            
                        # VBlank sync2 变化
                        if var_id == signal_names['debug_vblank_sync2']:
                            print(f"[{timestamp:8d}] vblank_sync2: {old_value} -> {value}")
                            print_state(timestamp, signal_names, current_values)
                            
                        # ppustatus[7] 变化
                        if var_id == signal_names['debug_ppustatus']:
                            old_bit7 = int(old_value, 2) >> 7 if old_value != 'x' else 0
                            new_bit7 = int(value, 2) >> 7 if value != 'x' else 0
                            if old_bit7 != new_bit7:
                                print(f"[{timestamp:8d}] ppustatus[7]: {old_bit7} -> {new_bit7}")
                                print_state(timestamp, signal_names, current_values)
                        
                        # CPU 地址变化 - 检测访问 $2002
                        if var_id == signal_names['debug_cpu_addr']:
                            addr = int(value, 2) if value != 'x' else 0
                            if addr == 0x2002:
                                rw = current_values.get(signal_names['debug_cpu_rw'], '0')
                                ppustatus = current_values.get(signal_names['debug_ppustatus'], '0')
                                ppustatus_val = int(ppustatus, 2) if ppustatus != 'x' else 0
                                print(f"[{timestamp:8d}] CPU 访问 $2002, rw={rw}, ppustatus=0x{ppustatus_val:02x}")
                                if rw == '1':
                                    print_state(timestamp, signal_names, current_values)

def print_state(timestamp, signal_names, current_values):
    """打印当前状态"""
    vblank = current_values.get(signal_names['debug_vblank'], 'x')
    sync1 = current_values.get(signal_names['debug_vblank_sync1'], 'x')
    sync2 = current_values.get(signal_names['debug_vblank_sync2'], 'x')
    ppustatus = current_values.get(signal_names['debug_ppustatus'], 'x')
    ppuctrl = current_values.get(signal_names['debug_ppuctrl'], 'x')
    nmi = current_values.get(signal_names['debug_nmi'], 'x')
    
    ppustatus_val = int(ppustatus, 2) if ppustatus != 'x' else 0
    ppuctrl_val = int(ppuctrl, 2) if ppuctrl != 'x' else 0
    
    print(f"         状态: vblank={vblank} sync1={sync1} sync2={sync2} " +
          f"ppustatus=0x{ppustatus_val:02x} ppuctrl=0x{ppuctrl_val:02x} nmi={nmi}")
    print()

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("用法: python3 analyze_vblank.py <vcd_file>")
        sys.exit(1)
    
    parse_vcd(sys.argv[1])
