#!/usr/bin/env python3
import sys

def parse_vcd(filename, max_time=1000):
    """Parse VCD file and extract key signals"""
    signals = {}
    signal_names = {}
    current_time = 0
    
    with open(filename, 'r') as f:
        in_definitions = True
        for line in f:
            line = line.strip()
            
            # Parse signal definitions
            if in_definitions:
                if line.startswith('$var'):
                    parts = line.split()
                    if len(parts) >= 5:
                        sig_id = parts[3]
                        sig_name = parts[4]
                        signal_names[sig_id] = sig_name
                elif line.startswith('$enddefinitions'):
                    in_definitions = False
                continue
            
            # Parse time
            if line.startswith('#'):
                current_time = int(line[1:])
                if current_time > max_time:
                    break
                continue
            
            # Parse signal values
            if line and current_time <= max_time:
                if line[0] in '01':
                    # Single bit: 0id or 1id
                    value = line[0]
                    sig_id = line[1:]
                elif line[0] == 'b':
                    # Multi-bit: bXXXX id
                    parts = line.split()
                    if len(parts) == 2:
                        value = parts[0][1:]  # Remove 'b'
                        sig_id = parts[1]
                else:
                    continue
                
                if sig_id in signal_names:
                    sig_name = signal_names[sig_id]
                    if current_time not in signals:
                        signals[current_time] = {}
                    signals[current_time][sig_name] = value
    
    return signals, signal_names

def print_signals(signals, interesting_signals):
    """Print signal values over time"""
    times = sorted(signals.keys())
    
    print(f"{'Time':<8} ", end='')
    for sig in interesting_signals:
        print(f"{sig:<20} ", end='')
    print()
    print("-" * (8 + 20 * len(interesting_signals)))
    
    last_values = {}
    for t in times:
        changed = False
        current_values = {}
        
        for sig in interesting_signals:
            if sig in signals[t]:
                current_values[sig] = signals[t][sig]
            elif sig in last_values:
                current_values[sig] = last_values[sig]
            else:
                current_values[sig] = '?'
            
            if sig not in last_values or last_values[sig] != current_values[sig]:
                changed = True
        
        if changed:
            print(f"{t:<8} ", end='')
            for sig in interesting_signals:
                val = current_values.get(sig, '?')
                # Convert binary to hex for readability
                if val.startswith('0') or val.startswith('1'):
                    val_str = val
                else:
                    try:
                        val_int = int(val, 2)
                        val_str = f"0x{val_int:x}"
                    except:
                        val_str = val
                print(f"{val_str:<20} ", end='')
            print()
        
        last_values = current_values

if __name__ == '__main__':
    filename = sys.argv[1] if len(sys.argv) > 1 else 'nes_trace.vcd'
    max_time = int(sys.argv[2]) if len(sys.argv) > 2 else 1000
    
    print(f"Analyzing {filename} (max time: {max_time})...")
    signals, signal_names = parse_vcd(filename, max_time)
    
    print(f"\nFound {len(signal_names)} signals")
    print(f"Time range: 0 to {max(signals.keys()) if signals else 0}")
    
    # Interesting signals for reset debugging
    interesting = [
        'reset',
        'cpu_io_debug_state',
        'cpu_io_debug_cycle',
        'cpu_io_memAddr',
        'cpu_io_memDataIn',
        'cpu_io_memRead',
    ]
    
    print(f"\n=== Key Signals ===")
    print_signals(signals, interesting)
