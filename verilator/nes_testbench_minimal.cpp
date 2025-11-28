// 最小化 NES Testbench - 用于调试 CPU 执行问题
#include <verilated.h>
#include "VNESSystem.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <cstdint>
#include <iomanip>

class MinimalNES {
private:
    VNESSystem* dut;
    std::vector<uint8_t> prg_rom;
    std::vector<uint8_t> chr_rom;
    uint64_t cycle_count;
    
    // 追踪最近的指令
    struct InstructionTrace {
        uint16_t pc;
        uint8_t opcode;
        uint8_t a, x, y, sp;
        uint8_t flags;
    };
    std::vector<InstructionTrace> trace_history;
    const int MAX_TRACE = 100;
    
    uint16_t last_pc;
    uint8_t last_state;
    bool in_vector_area;
    int vector_access_count;
    
public:
    MinimalNES(VNESSystem* dut_ptr) : dut(dut_ptr), cycle_count(0), 
        last_pc(0), last_state(0), in_vector_area(false), vector_access_count(0) {
    }
    
    bool loadROM(const char* filename) {
        std::ifstream file(filename, std::ios::binary);
        if (!file) {
            std::cerr << "❌ 无法打开 ROM: " << filename << std::endl;
            return false;
        }
        
        // 读取 iNES 头
        uint8_t header[16];
        file.read((char*)header, 16);
        
        if (header[0] != 'N' || header[1] != 'E' || header[2] != 'S' || header[3] != 0x1A) {
            std::cerr << "❌ 无效的 iNES 文件" << std::endl;
            return false;
        }
        
        int prg_size = header[4] * 16384;
        int chr_size = header[5] * 8192;
        
        prg_rom.resize(prg_size);
        chr_rom.resize(chr_size);
        
        file.read((char*)prg_rom.data(), prg_size);
        file.read((char*)chr_rom.data(), chr_size);
        
        std::cout << "✅ ROM 加载成功" << std::endl;
        std::cout << "   PRG ROM: " << prg_size << " bytes" << std::endl;
        std::cout << "   CHR ROM: " << chr_size << " bytes" << std::endl;
        
        // 显示 Reset Vector
        uint16_t reset_vector = prg_rom[prg_size - 4] | (prg_rom[prg_size - 3] << 8);
        std::cout << "   Reset Vector: 0x" << std::hex << std::setw(4) << std::setfill('0') 
                  << reset_vector << std::dec << std::endl;
        
        return true;
    }
    
    void loadROMIntoSystem() {
        std::cout << "📝 加载 ROM 到系统..." << std::endl;
        
        // 加载 PRG ROM
        dut->io_romLoadEn = 1;
        dut->io_romLoadPRG = 1;
        for (size_t i = 0; i < prg_rom.size(); i++) {
            dut->io_romLoadAddr = i;
            dut->io_romLoadData = prg_rom[i];
            tick();
        }
        
        // 加载 CHR ROM
        dut->io_romLoadPRG = 0;
        for (size_t i = 0; i < chr_rom.size(); i++) {
            dut->io_romLoadAddr = i;
            dut->io_romLoadData = chr_rom[i];
            tick();
        }
        
        dut->io_romLoadEn = 0;
        std::cout << "✅ ROM 加载完成" << std::endl;
    }
    
    void tick() {
        // 时钟上升沿
        dut->clock = 1;
        dut->eval();
        
        // 时钟下降沿
        dut->clock = 0;
        dut->eval();
        
        cycle_count++;
    }
    
    void printState() {
        uint16_t pc = dut->io_debug_regPC;
        uint8_t state = dut->io_debug_state;
        uint8_t opcode = dut->io_debug_opcode;
        uint8_t a = dut->io_debug_regA;
        uint8_t x = dut->io_debug_regX;
        uint8_t y = dut->io_debug_regY;
        uint8_t sp = dut->io_debug_regSP;
        uint8_t cycle = dut->io_debug_cycle;
        
        // 检测状态变化
        if (state != last_state || pc != last_pc) {
            // 检查是否在向量表区域
            bool now_in_vector = (pc >= 0xFFF0);
            
            if (now_in_vector && !in_vector_area) {
                std::cout << "\n⚠️  进入向量表区域! PC=0x" << std::hex << pc << std::dec << std::endl;
                std::cout << "最近的指令历史:" << std::endl;
                int start = std::max(0, (int)trace_history.size() - 10);
                for (int i = start; i < trace_history.size(); i++) {
                    auto& t = trace_history[i];
                    std::cout << "  PC:0x" << std::hex << std::setw(4) << std::setfill('0') << t.pc
                              << " Op:0x" << std::setw(2) << (int)t.opcode
                              << " A:0x" << std::setw(2) << (int)t.a
                              << " X:0x" << std::setw(2) << (int)t.x
                              << " Y:0x" << std::setw(2) << (int)t.y
                              << " SP:0x" << std::setw(2) << (int)t.sp
                              << std::dec << std::endl;
                }
            }
            
            in_vector_area = now_in_vector;
            if (in_vector_area) {
                vector_access_count++;
                if (vector_access_count > 100) {
                    std::cout << "\n🚨 错误: 在向量表区域循环超过 100 次!" << std::endl;
                    exit(1);
                }
            }
            
            // 记录指令历史
            if (state == 2) {  // Execute state
                InstructionTrace t;
                t.pc = pc;
                t.opcode = opcode;
                t.a = a;
                t.x = x;
                t.y = y;
                t.sp = sp;
                t.flags = 0;
                
                trace_history.push_back(t);
                if (trace_history.size() > MAX_TRACE) {
                    trace_history.erase(trace_history.begin());
                }
            }
            
            // 打印状态
            const char* state_names[] = {"Reset", "Fetch", "Execute", "NMI", "Done"};
            
            // 获取 PPU 状态
            uint8_t ppu_status = dut->io_ppuDebug_ppuStatus;
            uint16_t scanline_x = dut->io_pixelX;
            uint16_t scanline_y = dut->io_pixelY;
            bool vblank = dut->io_vblank;
            bool palette_init = dut->io_ppuDebug_paletteInitDone;
            
            std::cout << "Cy:" << std::setw(8) << cycle_count 
                      << " St:" << state_names[state]
                      << " PC:0x" << std::hex << std::setw(4) << std::setfill('0') << pc
                      << " Op:0x" << std::setw(2) << (int)opcode
                      << " A:0x" << std::setw(2) << (int)a
                      << " X:0x" << std::setw(2) << (int)x
                      << " Y:0x" << std::setw(2) << (int)y
                      << " SP:0x" << std::setw(2) << (int)sp
                      << " Cyc:" << std::dec << (int)cycle
                      << " PPU:" << std::hex << (int)ppu_status
                      << " SL:" << std::dec << scanline_x << "," << scanline_y
                      << (vblank ? " [VB]" : "")
                      << (palette_init ? "" : " [PI]")
                      << std::endl;
            
            last_pc = pc;
            last_state = state;
        }
    }
    
    void run(int max_cycles) {
        std::cout << "\n🎮 开始仿真 (最多 " << max_cycles << " 周期)" << std::endl;
        std::cout << "========================================" << std::endl;
        
        // 初始化
        dut->io_romLoadEn = 0;
        dut->io_controller1 = 0;
        dut->io_controller2 = 0;
        
        // Reset
        dut->reset = 1;
        for (int i = 0; i < 10; i++) tick();
        dut->reset = 0;
        
        // 加载 ROM
        loadROMIntoSystem();
        
        // Reset 再次
        dut->reset = 1;
        for (int i = 0; i < 10; i++) tick();
        dut->reset = 0;
        
        std::cout << "\n🎮 开始执行..." << std::endl;
        
        // 运行
        for (int i = 0; i < max_cycles; i++) {
            tick();
            printState();
            
            // 每 1000 周期打印进度
            if (i % 1000 == 0 && i > 0) {
                std::cout << "\n--- 进度: " << i << " / " << max_cycles << " 周期 ---\n" << std::endl;
            }
        }
        
        std::cout << "\n✅ 仿真完成" << std::endl;
        std::cout << "总周期数: " << cycle_count << std::endl;
    }
};

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "用法: " << argv[0] << " <rom_file> [max_cycles]" << std::endl;
        return 1;
    }
    
    int max_cycles = 10000;
    if (argc >= 3) {
        max_cycles = std::atoi(argv[2]);
    }
    
    Verilated::commandArgs(argc, argv);
    VNESSystem* dut = new VNESSystem;
    
    MinimalNES nes(dut);
    
    if (!nes.loadROM(argv[1])) {
        return 1;
    }
    
    nes.run(max_cycles);
    
    delete dut;
    return 0;
}
