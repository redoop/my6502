#!/usr/bin/env python3
"""
分析 NES ROM 中使用的所有 opcode，并对比已实现的指令
"""

import sys
from collections import Counter

# 6502 指令集完整列表
OPCODE_NAMES = {
    # ADC
    0x69: "ADC #imm", 0x65: "ADC zp", 0x75: "ADC zp,X", 0x6D: "ADC abs", 
    0x7D: "ADC abs,X", 0x79: "ADC abs,Y", 0x61: "ADC (ind,X)", 0x71: "ADC (ind),Y",
    
    # AND
    0x29: "AND #imm", 0x25: "AND zp", 0x35: "AND zp,X", 0x2D: "AND abs",
    0x3D: "AND abs,X", 0x39: "AND abs,Y", 0x21: "AND (ind,X)", 0x31: "AND (ind),Y",
    
    # ASL
    0x0A: "ASL A", 0x06: "ASL zp", 0x16: "ASL zp,X", 0x0E: "ASL abs", 0x1E: "ASL abs,X",
    
    # BIT
    0x24: "BIT zp", 0x2C: "BIT abs",
    
    # Branch
    0x10: "BPL", 0x30: "BMI", 0x50: "BVC", 0x70: "BVS",
    0x90: "BCC", 0xB0: "BCS", 0xD0: "BNE", 0xF0: "BEQ",
    
    # BRK
    0x00: "BRK",
    
    # CMP
    0xC9: "CMP #imm", 0xC5: "CMP zp", 0xD5: "CMP zp,X", 0xCD: "CMP abs",
    0xDD: "CMP abs,X", 0xD9: "CMP abs,Y", 0xC1: "CMP (ind,X)", 0xD1: "CMP (ind),Y",
    
    # CPX
    0xE0: "CPX #imm", 0xE4: "CPX zp", 0xEC: "CPX abs",
    
    # CPY
    0xC0: "CPY #imm", 0xC4: "CPY zp", 0xCC: "CPY abs",
    
    # DEC
    0xC6: "DEC zp", 0xD6: "DEC zp,X", 0xCE: "DEC abs", 0xDE: "DEC abs,X",
    
    # EOR
    0x49: "EOR #imm", 0x45: "EOR zp", 0x55: "EOR zp,X", 0x4D: "EOR abs",
    0x5D: "EOR abs,X", 0x59: "EOR abs,Y", 0x41: "EOR (ind,X)", 0x51: "EOR (ind),Y",
    
    # Flag
    0x18: "CLC", 0x38: "SEC", 0x58: "CLI", 0x78: "SEI",
    0xB8: "CLV", 0xD8: "CLD", 0xF8: "SED",
    
    # INC
    0xE6: "INC zp", 0xF6: "INC zp,X", 0xEE: "INC abs", 0xFE: "INC abs,X",
    
    # JMP
    0x4C: "JMP abs", 0x6C: "JMP ind",
    
    # JSR
    0x20: "JSR abs",
    
    # LDA
    0xA9: "LDA #imm", 0xA5: "LDA zp", 0xB5: "LDA zp,X", 0xAD: "LDA abs",
    0xBD: "LDA abs,X", 0xB9: "LDA abs,Y", 0xA1: "LDA (ind,X)", 0xB1: "LDA (ind),Y",
    
    # LDX
    0xA2: "LDX #imm", 0xA6: "LDX zp", 0xB6: "LDX zp,Y", 0xAE: "LDX abs", 0xBE: "LDX abs,Y",
    
    # LDY
    0xA0: "LDY #imm", 0xA4: "LDY zp", 0xB4: "LDY zp,X", 0xAC: "LDY abs", 0xBC: "LDY abs,X",
    
    # LSR
    0x4A: "LSR A", 0x46: "LSR zp", 0x56: "LSR zp,X", 0x4E: "LSR abs", 0x5E: "LSR abs,X",
    
    # NOP
    0xEA: "NOP",
    
    # ORA
    0x09: "ORA #imm", 0x05: "ORA zp", 0x15: "ORA zp,X", 0x0D: "ORA abs",
    0x1D: "ORA abs,X", 0x19: "ORA abs,Y", 0x01: "ORA (ind,X)", 0x11: "ORA (ind),Y",
    
    # Register
    0xAA: "TAX", 0x8A: "TXA", 0xCA: "DEX", 0xE8: "INX",
    0xA8: "TAY", 0x98: "TYA", 0x88: "DEY", 0xC8: "INY",
    
    # ROL
    0x2A: "ROL A", 0x26: "ROL zp", 0x36: "ROL zp,X", 0x2E: "ROL abs", 0x3E: "ROL abs,X",
    
    # ROR
    0x6A: "ROR A", 0x66: "ROR zp", 0x76: "ROR zp,X", 0x6E: "ROR abs", 0x7E: "ROR abs,X",
    
    # RTI
    0x40: "RTI",
    
    # RTS
    0x60: "RTS",
    
    # SBC
    0xE9: "SBC #imm", 0xE5: "SBC zp", 0xF5: "SBC zp,X", 0xED: "SBC abs",
    0xFD: "SBC abs,X", 0xF9: "SBC abs,Y", 0xE1: "SBC (ind,X)", 0xF1: "SBC (ind),Y",
    
    # STA
    0x85: "STA zp", 0x95: "STA zp,X", 0x8D: "STA abs",
    0x9D: "STA abs,X", 0x99: "STA abs,Y", 0x81: "STA (ind,X)", 0x91: "STA (ind),Y",
    
    # Stack
    0x9A: "TXS", 0xBA: "TSX", 0x48: "PHA", 0x68: "PLA", 0x08: "PHP", 0x28: "PLP",
    
    # STX
    0x86: "STX zp", 0x96: "STX zp,Y", 0x8E: "STX abs",
    
    # STY
    0x84: "STY zp", 0x94: "STY zp,X", 0x8C: "STY abs",
}

# 从 CPU6502Core.scala 中提取已实现的指令
IMPLEMENTED_OPCODES = {
    # Flag
    0x18, 0x38, 0xD8, 0xF8, 0x58, 0x78, 0xB8, 0xEA,
    # Transfer
    0xAA, 0xA8, 0x8A, 0x98, 0xBA, 0x9A,
    # Arithmetic implied
    0xE8, 0xC8, 0xCA, 0x88, 0x1A, 0x3A,
    # Arithmetic immediate
    0x69, 0xE9,
    # ADC/SBC zero page
    0x65, 0xE5,
    # ADC/SBC zero page X
    0x75, 0xF5,
    # ADC/SBC absolute
    0x6D, 0xED,
    # ADC/SBC indirect X
    0x61, 0xE1,
    # ADC/SBC indirect Y
    0x71, 0xF1,
    # INC/DEC zero page
    0xE6, 0xC6,
    # INC/DEC zero page X
    0xF6, 0xD6,
    # INC/DEC absolute
    0xEE, 0xCE,
    # INC/DEC absolute X
    0xFE, 0xDE,
    # ADC/SBC absolute indexed
    0x79, 0xF9, 0x7D, 0xFD,
    # Logic immediate
    0x29, 0x09, 0x49,
    # Logic zero page
    0x24, 0x25, 0x05, 0x45,
    # Logic zero page X
    0x35, 0x15, 0x55,
    # Logic absolute
    0x2C, 0x2D, 0x0D, 0x4D,
    # Logic absolute X/Y
    0x3D, 0x1D, 0x5D, 0x39, 0x19, 0x59,
    # Logic indirect X
    0x21, 0x01, 0x41,
    # Logic indirect Y
    0x31, 0x11, 0x51,
    # Shift accumulator
    0x0A, 0x4A, 0x2A, 0x6A,
    # Shift zero page
    0x06, 0x46, 0x26, 0x66,
    # Shift zero page X
    0x16, 0x56, 0x36, 0x76,
    # Shift absolute
    0x0E, 0x4E, 0x2E, 0x6E,
    # Shift absolute X
    0x1E, 0x5E, 0x3E, 0x7E,
    # Compare immediate
    0xC9, 0xE0, 0xC0,
    # Compare zero page
    0xC5, 0xE4, 0xC4,
    # Compare zero page X
    0xD5,
    # Compare absolute
    0xCD, 0xEC, 0xCC,
    # Compare absolute indexed
    0xDD, 0xD9,
    # Compare indirect X
    0xC1,
    # Compare indirect Y
    0xD1,
    # Compare indirect (65C02)
    0xD2,
    # Branch
    0xF0, 0xD0, 0xB0, 0x90, 0x30, 0x10, 0x50, 0x70,
    # LoadStore immediate
    0xA9, 0xA2, 0xA0,
    # LoadStore zero page
    0xA5, 0x85, 0x86, 0x84, 0xA6, 0xA4,
    # LoadStore zero page X
    0xB5, 0x95, 0xB4, 0x94,
    # LoadStore zero page Y
    0xB6, 0x96,
    # LoadStore absolute
    0xAD, 0x8D, 0x8E, 0x8C, 0xAE, 0xAC,
    # LoadStore absolute indexed
    0xBD, 0xB9, 0xBC, 0xBE, 0x9D, 0x99,
    # LoadStore indirect X
    0xA1, 0x81,
    # LoadStore indirect Y
    0x91, 0xB1,
    # Stack
    0x48, 0x08, 0x68, 0x28,
    # Jump
    0x4C, 0x6C, 0x20, 0x60, 0x00, 0x40,
}

def analyze_rom(filename):
    """分析 ROM 文件中的所有 opcode"""
    with open(filename, 'rb') as f:
        # 跳过 iNES 头 (16 字节)
        header = f.read(16)
        if header[:4] != b'NES\x1a':
            print("❌ 不是有效的 NES ROM 文件")
            return
        
        prg_size = header[4] * 16384
        chr_size = header[5] * 8192
        
        print(f"📦 ROM 信息:")
        print(f"   PRG ROM: {prg_size} 字节")
        print(f"   CHR ROM: {chr_size} 字节")
        print()
        
        # 读取 PRG ROM
        prg_rom = f.read(prg_size)
        
        # 统计所有字节（作为潜在的 opcode）
        opcodes = Counter(prg_rom)
        
        # 过滤出有效的 opcode
        valid_opcodes = {op: count for op, count in opcodes.items() if op in OPCODE_NAMES}
        
        print(f"🔍 发现 {len(valid_opcodes)} 种不同的指令")
        print()
        
        # 分类
        implemented = []
        not_implemented = []
        
        for opcode in sorted(valid_opcodes.keys()):
            name = OPCODE_NAMES.get(opcode, f"Unknown 0x{opcode:02X}")
            count = valid_opcodes[opcode]
            
            if opcode in IMPLEMENTED_OPCODES:
                implemented.append((opcode, name, count))
            else:
                not_implemented.append((opcode, name, count))
        
        print(f"✅ 已实现: {len(implemented)} 种指令")
        for opcode, name, count in implemented[:10]:
            print(f"   0x{opcode:02X} {name:20s} (出现 {count} 次)")
        if len(implemented) > 10:
            print(f"   ... 还有 {len(implemented) - 10} 种")
        print()
        
        print(f"❌ 未实现: {len(not_implemented)} 种指令")
        for opcode, name, count in sorted(not_implemented, key=lambda x: -x[2]):
            print(f"   0x{opcode:02X} {name:20s} (出现 {count} 次)")
        print()
        
        # 按类别统计未实现的指令
        if not_implemented:
            print("📊 未实现指令按类别:")
            categories = {}
            for opcode, name, count in not_implemented:
                category = name.split()[0]
                if category not in categories:
                    categories[category] = []
                categories[category].append((opcode, name, count))
            
            for category in sorted(categories.keys()):
                opcodes_in_cat = categories[category]
                total_count = sum(c for _, _, c in opcodes_in_cat)
                print(f"\n   {category}: {len(opcodes_in_cat)} 种指令，共出现 {total_count} 次")
                for opcode, name, count in opcodes_in_cat:
                    print(f"      0x{opcode:02X} {name:20s} ({count} 次)")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法: python3 analyze_opcodes.py <rom文件>")
        sys.exit(1)
    
    analyze_rom(sys.argv[1])
