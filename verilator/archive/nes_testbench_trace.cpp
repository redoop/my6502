// NES Testbench with VCD Waveform Tracing
// 用于生成波形文件进行调试

#include <verilated.h>
#include <verilated_vcd_c.h>
#include "VNESSystem.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <cstdint>

class NESEmulatorTrace {
private:
    VNESSystem* dut;
    VerilatedVcdC* tfp;
    uint64_t cycle_count;
    std::vector<uint8_t> prg_rom;
    std::vector<uint8_t> chr_rom;
    
public:
    NESEmulatorTrace(VNESSystem* dut_ptr, VerilatedVcdC* trace_ptr) 
        : dut(dut_ptr), tfp(trace_ptr), cycle_count(0) {}
    
    bool loadROM(const char* filename) {
        std::ifstream file(filename, std::ios::binary);
        if (!file) {
            std::cerr << "无法打开 ROM 文件: " << filename << std::endl;
            return false;
        }
        
        // 读取 iNES 头
        uint8_t header[16];
        file.read(reinterpret_cast<char*>(header), 16);
        
        if (header[0] != 'N' || header[1] != 'E' || header[2] != 'S' || header[3] != 0x1A) {
            std::cerr << "无效的 NES ROM 文件" << std::endl;
            return false;
        }
        
        int prg_size = header[4] * 16384;
        int chr_size = header[5] * 8192;
        
        std::cout << "📦 ROM 信息:" << std::endl;
        std::cout << "   PRG ROM: " << prg_size << " 字节" << std::endl;
        std::cout << "   CHR ROM: " << chr_size << " 字节" << std::endl;
        
        // 读取 PRG ROM
        prg_rom.resize(prg_size);
        file.read(reinterpret_cast<char*>(prg_rom.data()), prg_size);
        
        // 读取 CHR ROM
        if (chr_size > 0) {
            chr_rom.resize(chr_size);
            file.read(reinterpret_cast<char*>(chr_rom.data()), chr_size);
        }
        
        file.close();
        loadROMToHardware();
        return true;
    }
    
    void loadROMToHardware() {
        std::cout << "⬆️  加载 ROM 到硬件..." << std::endl;
        
        // 加载 PRG ROM
        dut->io_romLoadPRG = 1;
        for (size_t i = 0; i < prg_rom.size() && i < 32768; i++) {
            dut->io_romLoadEn = 1;
            dut->io_romLoadAddr = i;
            dut->io_romLoadData = prg_rom[i];
            tick();
        }
        std::cout << "   PRG: 100%" << std::endl;
        
        // 加载 CHR ROM
        if (!chr_rom.empty()) {
            dut->io_romLoadPRG = 0;
            for (size_t i = 0; i < chr_rom.size() && i < 8192; i++) {
                dut->io_romLoadEn = 1;
                dut->io_romLoadAddr = i;
                dut->io_romLoadData = chr_rom[i];
                tick();
            }
            std::cout << "   CHR: 100%" << std::endl;
        }
        
        dut->io_romLoadEn = 0;
        std::cout << "✅ ROM 加载完成" << std::endl;
    }
    
    void tick() {
        dut->clock = 0;
        dut->eval();
        tfp->dump(cycle_count * 2);
        cycle_count++;
        
        dut->clock = 1;
        dut->eval();
        tfp->dump(cycle_count * 2 + 1);
    }
    
    void run(uint64_t max_cycles) {
        std::cout << "🎮 开始仿真 (最多 " << max_cycles << " 周期)..." << std::endl;
        std::cout << "   生成波形文件: nes_trace.vcd" << std::endl;
        
        dut->io_controller1 = 0;
        dut->io_controller2 = 0;
        
        uint64_t last_report = 0;
        
        for (uint64_t i = 0; i < max_cycles; i++) {
            tick();
            
            // 每 10K 周期报告一次
            if (cycle_count - last_report >= 10000) {
                uint16_t pc = dut->io_debug_regPC;
                uint8_t a = dut->io_debug_regA;
                
                std::cout << "周期: " << cycle_count 
                          << " | PC: 0x" << std::hex << pc
                          << " | A: 0x" << (int)a
                          << std::dec << std::endl;
                
                last_report = cycle_count;
            }
            
            // 检测 VBlank
            static bool last_vblank = false;
            if (dut->io_vblank && !last_vblank) {
                std::cout << "📺 VBlank (帧完成)" << std::endl;
            }
            last_vblank = dut->io_vblank;
        }
        
        tfp->flush();
        std::cout << "✅ 仿真完成" << std::endl;
        std::cout << "   总周期数: " << cycle_count << std::endl;
        std::cout << "   波形文件: nes_trace.vcd" << std::endl;
        std::cout << "" << std::endl;
        std::cout << "使用 GTKWave 查看波形:" << std::endl;
        std::cout << "   gtkwave nes_trace.vcd" << std::endl;
    }
};

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "用法: " << argv[0] << " <rom文件> [周期数]" << std::endl;
        return 1;
    }
    
    uint64_t max_cycles = 100000;  // 默认 10 万周期（波形文件会很大）
    if (argc >= 3) {
        max_cycles = std::stoull(argv[2]);
    }
    
    std::cout << "🚀 NES Verilator 波形追踪仿真器" << std::endl;
    std::cout << "================================" << std::endl;
    
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);
    
    VNESSystem* dut = new VNESSystem;
    VerilatedVcdC* tfp = new VerilatedVcdC;
    
    dut->trace(tfp, 99);  // 追踪深度 99
    tfp->open("nes_trace.vcd");
    
    NESEmulatorTrace emulator(dut, tfp);
    
    // 在 reset 期间加载 ROM
    std::cout << "🔄 保持 Reset 状态..." << std::endl;
    dut->reset = 1;
    
    if (!emulator.loadROM(argv[1])) {
        return 1;
    }
    
    // 额外的 reset 周期
    std::cout << "🔄 复位 CPU..." << std::endl;
    for (int i = 0; i < 10; i++) {
        dut->clock = 0;
        dut->eval();
        tfp->dump(i * 2);
        dut->clock = 1;
        dut->eval();
        tfp->dump(i * 2 + 1);
    }
    dut->reset = 0;
    
    // 等待 CPU 完成 Reset 序列
    std::cout << "⏳ 等待 CPU Reset 序列..." << std::endl;
    for (int i = 0; i < 20; i++) {
        dut->clock = 0;
        dut->eval();
        tfp->dump((i + 10) * 2);
        dut->clock = 1;
        dut->eval();
        tfp->dump((i + 10) * 2 + 1);
    }
    
    emulator.run(max_cycles);
    
    tfp->close();
    delete tfp;
    delete dut;
    return 0;
}
