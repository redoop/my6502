#include <verilated.h>
#include "Vnes_system.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <cstdint>

bool load_rom(const char* filename, std::vector<uint8_t>& prg_rom, std::vector<uint8_t>& chr_rom) {
    std::ifstream file(filename, std::ios::binary);
    if (!file) {
        std::cerr << "Failed to open ROM: " << filename << std::endl;
        return false;
    }
    
    uint8_t header[16];
    file.read((char*)header, 16);
    
    if (header[0] != 'N' || header[1] != 'E' || header[2] != 'S' || header[3] != 0x1A) {
        std::cerr << "Invalid iNES header" << std::endl;
        return false;
    }
    
    int prg_size = header[4] * 16384;
    int chr_size = header[5] * 8192;
    
    std::cout << "PRG ROM: " << prg_size << " bytes" << std::endl;
    std::cout << "CHR ROM: " << chr_size << " bytes" << std::endl;
    
    prg_rom.resize(prg_size > 0 ? prg_size : 16384);
    chr_rom.resize(chr_size > 0 ? chr_size : 8192);
    
    file.read((char*)prg_rom.data(), prg_size);
    if (chr_size > 0) file.read((char*)chr_rom.data(), chr_size);
    
    return true;
}

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <rom.nes>" << std::endl;
        return 1;
    }
    
    Verilated::commandArgs(argc, argv);
    Vnes_system* dut = new Vnes_system;
    
    std::vector<uint8_t> prg_rom, chr_rom;
    if (!load_rom(argv[1], prg_rom, chr_rom)) return 1;
    
    dut->clk = 0;
    dut->rst_n = 0;
    dut->controller1 = 0;
    dut->controller2 = 0;
    
    for (int i = 0; i < 10; i++) {
        dut->clk = !dut->clk;
        dut->eval();
    }
    dut->rst_n = 1;
    
    std::cout << "\nRunning..." << std::endl;
    
    uint64_t cycles = 0, frames = 0;
    bool last_vsync = false;
    
    while (cycles < 21477272 * 10 && !Verilated::gotFinish()) {
        dut->clk = !dut->clk;
        
        if (dut->clk) {
            uint32_t prg_addr = dut->prg_rom_addr % prg_rom.size();
            dut->prg_rom_data = prg_rom[prg_addr];
            
            uint32_t chr_addr = dut->chr_rom_addr % chr_rom.size();
            dut->chr_rom_data = chr_rom[chr_addr];
            
            if (!dut->video_vsync && last_vsync) {
                frames++;
                if (frames % 60 == 0) {
                    std::cout << "Frame " << frames << std::endl;
                }
            }
            last_vsync = dut->video_vsync;
            cycles++;
        }
        
        dut->eval();
    }
    
    std::cout << "\nTotal frames: " << frames << std::endl;
    std::cout << "Status: " << (frames > 0 ? "SUCCESS" : "FAILED") << std::endl;
    
    delete dut;
    return frames > 0 ? 0 : 1;
}
