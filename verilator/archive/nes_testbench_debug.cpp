// NES 系统 Verilator Testbench - 调试版本
// 添加详细的 PC 追踪和指令执行日志

#include <verilated.h>
#include "VNESSystem.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <cstdint>
#include <iomanip>
#include <map>
#include <deque>

// 指令名称映射
std::map<uint8_t, std::string> opcode_names = {
    {0x00, "BRK"}, {0x20, "JSR"}, {0x40, "RTI"}, {0x60, "RTS"},
    {0x4C, "JMP abs"}, {0x6C, "JMP ind"},
    {0x69, "ADC #"}, {0x65, "ADC zp"}, {0x75, "ADC zp,X"}, {0x6D, "ADC abs"},
    {0xE9, "SBC #"}, {0xE5, "SBC zp"}, {0xF5, "SBC zp,X"}, {0xED, "SBC abs"},
    {0xE1, "SBC (ind,X)"}, {0xF1, "SBC (ind),Y"},
    {0xA9, "LDA #"}, {0xA5, "LDA zp"}, {0xB5, "LDA zp,X"}, {0xAD, "LDA abs"},
    {0x85, "STA zp"}, {0x95, "STA zp,X"}, {0x8D, "STA abs"},
    {0xA2, "LDX #"}, {0xA6, "LDX zp"}, {0xAE, "LDX abs"},
    {0xA0, "LDY #"}, {0xA4, "LDY zp"}, {0xAC, "LDY abs"},
    {0xE8, "INX"}, {0xC8, "INY"}, {0xCA, "DEX"}, {0x88, "DEY"},
    {0xE6, "INC zp"}, {0xF6, "INC zp,X"}, {0xEE, "INC abs"}, {0xFE, "INC abs,X"},
    {0xC6, "DEC zp"}, {0xD6, "DEC zp,X"}, {0xCE, "DEC abs"}, {0xDE, "DEC abs,X"},
    {0x0A, "ASL A"}, {0x06, "ASL zp"}, {0x16, "ASL zp,X"}, {0x0E, "ASL abs"}, {0x1E, "ASL abs,X"},
    {0x4A, "LSR A"}, {0x46, "LSR zp"}, {0x56, "LSR zp,X"}, {0x4E, "LSR abs"}, {0x5E, "LSR abs,X"},
    {0x2A, "ROL A"}, {0x26, "ROL zp"}, {0x36, "ROL zp,X"}, {0x2E, "ROL abs"}, {0x3E, "ROL abs,X"},
    {0x6A, "ROR A"}, {0x66, "ROR zp"}, {0x76, "ROR zp,X"}, {0x6E, "ROR abs"}, {0x7E, "ROR abs,X"},
    {0x48, "PHA"}, {0x68, "PLA"}, {0x08, "PHP"}, {0x28, "PLP"},
    {0x18, "CLC"}, {0x38, "SEC"}, {0x58, "CLI"}, {0x78, "SEI"},
    {0xD8, "CLD"}, {0xF8, "SED"}, {0xB8, "CLV"},
    {0x90, "BCC"}, {0xB0, "BCS"}, {0xF0, "BEQ"}, {0xD0, "BNE"},
    {0x30, "BMI"}, {0x10, "BPL"}, {0x50, "BVC"}, {0x70, "BVS"},
    {0xEA, "NOP"}
};

struct CPUState {
    uint16_t pc;
    uint8_t a, x, y, sp;
    uint8_t opcode;
    uint8_t state;
    uint8_t cycle;
    bool flagC, flagZ, flagN, flagV;
};

class DebugTracer {
private:
    std::deque<CPUState> history;
    const size_t MAX_HISTORY = 100;
    uint16_t last_pc = 0;
    uint64_t instruction_count = 0;
    std::map<uint16_t, uint64_t> pc_frequency;
    
    // 检测可疑行为
    int stuck_count = 0;
    int vector_access_count = 0;
    
public:
    void recordState(const CPUState& state) {
        history.push_back(state);
        if (history.size() > MAX_HISTORY) {
            history.pop_front();
        }
        
        // 统计 PC 频率
        pc_frequency[state.pc]++;
        
        // 检测 PC 变化
        if (state.state == 1 && state.pc != last_pc) {  // Fetch 状态
            instruction_count++;
            last_pc = state.pc;
            stuck_count = 0;
            
            // 检测向量表访问
            if (state.pc >= 0xFFF0) {
                vector_access_count++;
                if (vector_access_count > 5) {
                    std::cout << "\n⚠️  警告: 频繁访问向量表区域!" << std::endl;
                    printRecentHistory(20);
                    vector_access_count = 0;
                }
            } else {
                vector_access_count = 0;
            }
        } else if (state.state == 1) {
            stuck_count++;
            if (stuck_count > 100) {
                std::cout << "\n⚠️  警告: PC 长时间未变化!" << std::endl;
                printRecentHistory(10);
                stuck_count = 0;
            }
        }
    }
    
    void printRecentHistory(size_t count = 10) {
        std::cout << "\n=== 最近 " << count << " 条指令历史 ===" << std::endl;
        size_t start = history.size() > count ? history.size() - count : 0;
        
        for (size_t i = start; i < history.size(); i++) {
            const auto& s = history[i];
            std::cout << std::hex << std::setfill('0');
            std::cout << "PC:0x" << std::setw(4) << s.pc;
            std::cout << " Op:0x" << std::setw(2) << (int)s.opcode;
            
            auto it = opcode_names.find(s.opcode);
            if (it != opcode_names.end()) {
                std::cout << " (" << std::setw(12) << std::left << it->second << ")";
            } else {
                std::cout << " (Unknown    )";
            }
            std::cout << std::right;
            
            std::cout << " A:0x" << std::setw(2) << (int)s.a;
            std::cout << " X:0x" << std::setw(2) << (int)s.x;
            std::cout << " Y:0x" << std::setw(2) << (int)s.y;
            std::cout << " SP:0x" << std::setw(2) << (int)s.sp;
            std::cout << " St:" << (int)s.state;
            std::cout << " Cy:" << (int)s.cycle;
            
            // 标志位
            std::cout << " [";
            std::cout << (s.flagN ? "N" : "-");
            std::cout << (s.flagV ? "V" : "-");
            std::cout << (s.flagZ ? "Z" : "-");
            std::cout << (s.flagC ? "C" : "-");
            std::cout << "]";
            
            std::cout << std::dec << std::endl;
        }
        std::cout << "===================" << std::endl;
    }
    
    void printStatistics() {
        std::cout << "\n=== 执行统计 ===" << std::endl;
        std::cout << "总指令数: " << instruction_count << std::endl;
        
        // 找出最频繁的 PC
        std::vector<std::pair<uint16_t, uint64_t>> sorted_pc;
        for (const auto& p : pc_frequency) {
            sorted_pc.push_back(p);
        }
        std::sort(sorted_pc.begin(), sorted_pc.end(),
                  [](const auto& a, const auto& b) { return a.second > b.second; });
        
        std::cout << "\n最频繁的 PC 地址 (前 10):" << std::endl;
        for (size_t i = 0; i < std::min(size_t(10), sorted_pc.size()); i++) {
            std::cout << "  0x" << std::hex << std::setw(4) << std::setfill('0')
                      << sorted_pc[i].first << ": " << std::dec
                      << sorted_pc[i].second << " 次" << std::endl;
        }
    }
    
    void checkForProblems(const CPUState& state) {
        // 检查 SP 异常
        static uint8_t last_sp = 0xFD;
        int sp_change = (int)state.sp - (int)last_sp;
        if (abs(sp_change) > 10) {
            std::cout << "\n⚠️  警告: SP 变化异常 (0x" << std::hex
                      << (int)last_sp << " -> 0x" << (int)state.sp << ")" << std::dec << std::endl;
            printRecentHistory(10);
        }
        last_sp = state.sp;
        
        // 检查 JSR/RTS
        if (state.opcode == 0x20) {  // JSR
            std::cout << "\n📍 JSR 调用: PC=0x" << std::hex << state.pc
                      << " SP=0x" << (int)state.sp << std::dec << std::endl;
        } else if (state.opcode == 0x60) {  // RTS
            std::cout << "\n📍 RTS 返回: PC=0x" << std::hex << state.pc
                      << " SP=0x" << (int)state.sp << std::dec << std::endl;
        }
    }
};

bool loadROM(const char* filename, std::vector<uint8_t>& prg_rom, std::vector<uint8_t>& chr_rom) {
    std::ifstream file(filename, std::ios::binary);
    if (!file) {
        std::cerr << "❌ 无法打开 ROM 文件: " << filename << std::endl;
        return false;
    }
    
    // 读取 iNES 头
    uint8_t header[16];
    file.read(reinterpret_cast<char*>(header), 16);
    
    if (header[0] != 'N' || header[1] != 'E' || header[2] != 'S' || header[3] != 0x1A) {
        std::cerr << "❌ 不是有效的 NES ROM 文件" << std::endl;
        return false;
    }
    
    size_t prg_size = header[4] * 16384;
    size_t chr_size = header[5] * 8192;
    
    std::cout << "📦 加载 ROM:" << std::endl;
    std::cout << "   PRG ROM: " << prg_size << " 字节" << std::endl;
    std::cout << "   CHR ROM: " << chr_size << " 字节" << std::endl;
    
    // 读取 PRG ROM
    prg_rom.resize(prg_size);
    file.read(reinterpret_cast<char*>(prg_rom.data()), prg_size);
    
    // 读取 CHR ROM
    chr_rom.resize(chr_size);
    file.read(reinterpret_cast<char*>(chr_rom.data()), chr_size);
    
    return true;
}

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "用法: " << argv[0] << " <rom文件> [max_cycles]" << std::endl;
        return 1;
    }
    
    uint64_t max_cycles = 1000000;  // 默认 100 万周期
    if (argc >= 3) {
        max_cycles = std::stoull(argv[2]);
    }
    
    std::cout << "🚀 NES Verilator 调试模式" << std::endl;
    std::cout << "========================" << std::endl;
    
    // 加载 ROM
    std::vector<uint8_t> prg_rom, chr_rom;
    if (!loadROM(argv[1], prg_rom, chr_rom)) {
        return 1;
    }
    
    // 创建 DUT
    VNESSystem* dut = new VNESSystem;
    
    // 初始化
    dut->clock = 0;
    dut->reset = 1;
    dut->nmi = 0;
    dut->eval();
    
    // 加载 ROM 到硬件
    std::cout << "⬆️  加载 ROM 到硬件..." << std::endl;
    for (size_t i = 0; i < prg_rom.size(); i++) {
        dut->io_romData = prg_rom[i];
        dut->io_romAddr = i;
        dut->io_romWrite = 1;
        dut->clock = 1;
        dut->eval();
        dut->clock = 0;
        dut->eval();
    }
    dut->io_romWrite = 0;
    
    // 检查 ROM 内容
    std::cout << "   检查 ROM 内容:" << std::endl;
    std::cout << "   NMI 向量 (0xFFFA-0xFFFB) = 0x" << std::hex
              << (int)prg_rom[0x3FFB] << std::setw(2) << std::setfill('0')
              << (int)prg_rom[0x3FFA] << std::dec << std::endl;
    std::cout << "   Reset 向量 (0xFFFC-0xFFFD) = 0x" << std::hex
              << (int)prg_rom[0x3FFD] << std::setw(2) << std::setfill('0')
              << (int)prg_rom[0x3FFC] << std::dec << std::endl;
    
    // 释放 Reset
    std::cout << "🔄 释放 Reset，CPU 启动中..." << std::endl;
    dut->reset = 0;
    
    // 等待 CPU 完成 reset 序列
    std::cout << "   等待 CPU 完成 reset 序列..." << std::endl;
    for (int i = 0; i < 15; i++) {
        dut->clock = 1;
        dut->eval();
        dut->clock = 0;
        dut->eval();
        
        if (i < 10) {
            std::cout << "   周期 " << i
                      << ": state=" << (int)dut->io_debug_state
                      << " cycle=" << (int)dut->io_debug_cycle
                      << " PC=0x" << std::hex << dut->io_debug_regPC << std::dec
                      << std::endl;
        }
    }
    
    std::cout << "✅ CPU 已启动，PC = 0x" << std::hex << dut->io_debug_regPC << std::dec << std::endl;
    std::cout << "\n🔍 开始详细追踪..." << std::endl;
    std::cout << "   最大周期数: " << max_cycles << std::endl;
    std::cout << "===================" << std::endl;
    
    // 创建追踪器
    DebugTracer tracer;
    
    // 主循环
    uint64_t cycle_count = 0;
    uint64_t last_report = 0;
    
    while (cycle_count < max_cycles) {
        // 时钟上升沿
        dut->clock = 1;
        dut->eval();
        
        // 记录状态
        CPUState state;
        state.pc = dut->io_debug_regPC;
        state.a = dut->io_debug_regA;
        state.x = dut->io_debug_regX;
        state.y = dut->io_debug_regY;
        state.sp = dut->io_debug_regSP;
        state.opcode = dut->io_debug_opcode;
        state.state = dut->io_debug_state;
        state.cycle = dut->io_debug_cycle;
        state.flagC = dut->io_debug_flagC;
        state.flagZ = dut->io_debug_flagZ;
        state.flagN = dut->io_debug_flagN;
        state.flagV = dut->io_debug_flagV;
        
        tracer.recordState(state);
        tracer.checkForProblems(state);
        
        // 时钟下降沿
        dut->clock = 0;
        dut->eval();
        
        cycle_count++;
        
        // 定期报告
        if (cycle_count - last_report >= 10000) {
            std::cout << "\n📊 周期: " << cycle_count
                      << " PC: 0x" << std::hex << state.pc << std::dec
                      << " SP: 0x" << std::hex << (int)state.sp << std::dec
                      << std::endl;
            last_report = cycle_count;
        }
        
        // 检测问题
        if (state.pc >= 0xFFF0 && state.pc <= 0xFFFF && state.state == 2) {
            std::cout << "\n🚨 错误: CPU 在向量表区域执行代码!" << std::endl;
            std::cout << "   PC: 0x" << std::hex << state.pc << std::dec << std::endl;
            std::cout << "   Opcode: 0x" << std::hex << (int)state.opcode << std::dec << std::endl;
            tracer.printRecentHistory(30);
            break;
        }
    }
    
    // 打印统计
    tracer.printStatistics();
    tracer.printRecentHistory(20);
    
    delete dut;
    return 0;
}
