#!/usr/bin/env python3
"""分析 NES ROM 中使用的 6502 指令"""

import sys
from collections import Counter

# 6502 指令集 - 只列出常用的
OPCODES = {
    # Load/Store
    0xA9: "LDA #imm", 0xA5: "LDA zp", 0xB5: "LDA zp,X", 0xAD: "LDA abs", 0xBD: "LDA abs,X", 0xB9: "LDA abs,Y",
    0xA1: "LDA (ind,X)", 0xB1: "LDA (ind),Y",
    0xA2: "LDX #imm", 0xA6: "LDX zp", 0xB6: "LDX zp,Y", 0xAE: "LDX abs", 0xBE: "LDX abs,Y",
    0xA0: "LDY #imm", 0xA4: "LDY zp", 0xB4: "LDY zp,X", 0xAC: "LDY abs", 0xBC: "LDY abs,X",
    0x85: "STA zp", 0x95: "STA zp,X", 0x8D: "STA abs", 0x9D: "STA abs,X", 0x99: "STA abs,Y",
    0x81: "STA (ind,X)", 0x91: "STA (ind),Y",
    0x86: "STX zp", 0x96: "STX zp,Y", 0x8E: "STX abs",
    0x84: "STY zp", 0x94: "STY zp,X", 0x8C: "STY abs",
    
    # Arithmetic
    0x69: "ADC #imm", 0x65: "ADC zp", 0x75: "ADC zp,X", 0x6D: "ADC abs", 0x7D: "ADC abs,X", 0x79: "ADC abs,Y",
    0x61: "ADC (ind,X)", 0x71: "ADC (ind),Y",
    0xE9: "SBC #imm", 0xE5: "SBC zp", 0xF5: "SBC zp,X", 0xED: "SBC abs", 0xFD: "SBC abs,X", 0xF9: "SBC abs,Y",
    0xE1: "SBC (ind,X)", 0xF1: "SBC (ind),Y",
    
    # Logic
    0x29: "AND #imm", 0x25: "AND zp", 0x35: "AND zp,X", 0x2D: "AND abs", 0x3D: "AND abs,X", 0x39: "AND abs,Y",
    0x21: "AND (ind,X)", 0x31: "AND (ind),Y",
    0x09: "ORA #imm", 0x05: "ORA zp", 0x15: "ORA zp,X", 0x0D: "ORA abs", 0x1D: "ORA abs,X", 0x19: "ORA abs,Y",
    0x01: "ORA (ind,X)", 0x11: "ORA (ind),Y",
    0x49: "EOR #imm", 0x45: "EOR zp", 0x55: "EOR zp,X", 0x4D: "EOR abs", 0x5D: "EOR abs,X", 0x59: "EOR abs,Y",
    0x41: "EOR (ind,X)", 0x51: "EOR (ind),Y",
    0x24: "BIT zp", 0x2C: "BIT abs",
    
    # Shift/Rotate
    0x0A: "ASL A", 0x06: "ASL zp", 0x16: "ASL zp,X", 0x0E: "ASL abs", 0x1E: "ASL abs,X",
    0x4A: "LSR A", 0x46: "LSR zp", 0x56: "LSR zp,X", 0x4E: "LSR abs", 0x5E: "LSR abs,X",
    0x2A: "ROL A", 0x26: "ROL zp", 0x36: "ROL zp,X", 0x2E: "ROL abs", 0x3E: "ROL abs,X",
    0x6A: "ROR A", 0x66: "ROR zp", 0x76: "ROR zp,X", 0x6E: "ROR abs", 0x7E: "ROR abs,X",
    
    # Inc/Dec
    0xE6: "INC zp", 0xF6: "INC zp,X", 0xEE: "INC abs", 0xFE: "INC abs,X",
    0xC6: "DEC zp", 0xD6: "DEC zp,X", 0xCE: "DEC abs", 0xDE: "DEC abs,X",
    0xE8: "INX", 0xC8: "INY", 0xCA: "DEX", 0x88: "DEY",
    
    # Compare
    0xC9: "CMP #imm", 0xC5: "CMP zp", 0xD5: "CMP zp,X", 0xCD: "CMP abs", 0xDD: "CMP abs,X", 0xD9: "CMP abs,Y",
    0xC1: "CMP (ind,X)", 0xD1: "CMP (ind),Y",
    0xE0: "CPX #imm", 0xE4: "CPX zp", 0xEC: "CPX abs",
    0xC0: "CPY #imm", 0xC4: "CPY zp", 0xCC: "CPY abs",
    
    # Branch
    0x10: "BPL", 0x30: "BMI", 0x50: "BVC", 0x70: "BVS",
    0x90: "BCC", 0xB0: "BCS", 0xD0: "BNE", 0xF0: "BEQ",
    
    # Jump/Call
    0x4C: "JMP abs", 0x6C: "JMP ind",
    0x20: "JSR", 0x60: "RTS",
    0x00: "BRK", 0x40: "RTI",
    
    # Stack
    0x48: "PHA", 0x68: "PLA", 0x08: "PHP", 0x28: "PLP",
    
    # Transfer
    0xAA: "TAX", 0xA8: "TAY", 0x8A: "TXA", 0x98: "TYA",
    0xBA: "TSX", 0x9A: "TXS",
    
    # Flags
    0x18: "CLC", 0x38: "SEC", 0x58: "CLI", 0x78: "SEI",
    0xD8: "CLD", 0xF8: "SED", 0xB8: "CLV",
    
    # Other
    0xEA: "NOP",
}

def analyze_rom(filename):
    """分析 ROM 文件中的指令"""
    with open(filename, 'rb') as f:
        data = f.read()
    
    # 跳过 iNES 头 (16 bytes)
    header = data[:16]
    prg_size = header[4] * 16384  # PRG ROM size
    
    prg_rom = data[16:16+prg_size]
    
    # 统计指令
    opcode_count = Counter()
    for byte in prg_rom:
        opcode_count[byte] += 1
    
    # 按使用频率排序
    print(f"\n=== {filename} 指令使用统计 ===\n")
    print(f"PRG ROM 大小: {prg_size} bytes ({prg_size//1024}KB)")
    print(f"\n最常用的 50 个指令:\n")
    
    implemented = []
    missing = []
    
    for opcode, count in opcode_count.most_common(50):
        name = OPCODES.get(opcode, f"??? (${opcode:02X})")
        pct = count * 100.0 / len(prg_rom)
        
        # 检查是否实现
        is_impl = opcode in [
            # Load/Store
            0xA9, 0xA5, 0xB5, 0xAD, 0xBD, 0xB9, 0xA1, 0xB1,  # LDA
            0xA2, 0xA6, 0xB6, 0xAE,        # LDX
            0xA0, 0xA4, 0xB4,              # LDY
            0x85, 0x95, 0x8D, 0x9D, 0x81, 0x91,  # STA
            0x86, 0x96,                    # STX
            0x84, 0x94,                    # STY
            # Arithmetic
            0x69, 0x65, 0x75, 0x6D, 0x7D, 0x79,  # ADC
            0xE9, 0xE5, 0xF5, 0xED, 0xFD, 0xF9,  # SBC
            # Logic
            0x29, 0x25, 0x35, 0x2D, 0x3D, 0x21,  # AND
            0x09, 0x05, 0x15, 0x0D, 0x1D, 0x01,  # ORA
            0x49, 0x45, 0x55, 0x4D, 0x5D,  # EOR
            0x24,              # BIT
            # Shift
            0x0A, 0x06,        # ASL
            0x4A,              # LSR
            0x2A,              # ROL
            0x6A,              # ROR
            # Compare
            0xC9, 0xC5,        # CMP
            0xE0,              # CPX
            0xC0, 0xC4,        # CPY
            # Inc/Dec
            0xE6,              # INC
            0xC6,              # DEC
            0xE8, 0xC8, 0xCA, 0x88,  # INX, INY, DEX, DEY
            # Transfer
            0xAA, 0xA8, 0x8A, 0x98,  # TAX, TAY, TXA, TYA
            0xBA, 0x9A,        # TSX, TXS
            # Stack
            0x48, 0x68, 0x08, 0x28,  # PHA, PLA, PHP, PLP
            # Jump/Call
            0x4C, 0x6C,        # JMP
            0x20, 0x60,        # JSR, RTS
            0x00, 0x40,        # BRK, RTI
            # Branch
            0x10, 0x30, 0x50, 0x70,  # BPL, BMI, BVC, BVS
            0x90, 0xB0, 0xD0, 0xF0,  # BCC, BCS, BNE, BEQ
            # Flags
            0x18, 0x38, 0x58, 0x78,  # CLC, SEC, CLI, SEI
            0xD8, 0xF8, 0xB8,  # CLD, SED, CLV
            # Other
            0xEA,              # NOP
        ]
        
        status = "✅" if is_impl else "❌"
        print(f"{status} ${opcode:02X} {name:20s} : {count:5d} ({pct:5.2f}%)")
        
        if is_impl:
            implemented.append((opcode, name, count))
        else:
            missing.append((opcode, name, count))
    
    print(f"\n=== 总结 ===")
    print(f"已实现: {len(implemented)} 个指令")
    print(f"缺失: {len(missing)} 个指令")
    
    if missing:
        print(f"\n=== 缺失的关键指令 ===")
        for opcode, name, count in missing[:20]:
            pct = count * 100.0 / len(prg_rom)
            print(f"  ${opcode:02X} {name:20s} : {count:5d} ({pct:5.2f}%)")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 analyze_opcodes.py <rom_file>")
        sys.exit(1)
    
    analyze_rom(sys.argv[1])
