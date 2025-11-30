#include <verilated.h>
#include "Vnes_system.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <cstdint>

bool load_rom(const char* filename, std::vector<uint8_t>& prg_rom, std::vector<uint8_t>& chr_rom, int& mapper) {
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
    mapper = ((header[6] >> 4) & 0x0F) | (header[7] & 0xF0);
    
    std::cout << "PRG ROM: " << prg_size << " bytes" << std::endl;
    std::cout << "CHR ROM: " << chr_size << " bytes" << std::endl;
    std::cout << "Mapper: " << mapper << std::endl;
    
    prg_rom.resize(prg_size > 0 ? prg_size : 16384);
    chr_rom.resize(chr_size > 0 ? chr_size : 8192);
    
    file.read((char*)prg_rom.data(), prg_size);
    if (chr_size > 0) file.read((char*)chr_rom.data(), chr_size);
    
    // 验证 Reset Vector (at end of PRG ROM)
    int reset_vec_addr = prg_rom.size() - 4;
    uint16_t reset_vector = prg_rom[reset_vec_addr] | (prg_rom[reset_vec_addr + 1] << 8);
    std::cout << "Reset Vector at ROM offset " << std::hex << reset_vec_addr 
              << ": $" << reset_vector << std::dec << std::endl;
    
    // 验证 CHR ROM 数据
    std::cout << "First 16 bytes of CHR ROM: ";
    for (int i = 0; i < 16 && i < chr_rom.size(); i++) {
        printf("%02X ", chr_rom[i]);
    }
    std::cout << std::endl;
    
    // 检查中间和末尾
    std::cout << "CHR ROM at 0x100: ";
    for (int i = 0x100; i < 0x110 && i < chr_rom.size(); i++) {
        printf("%02X ", chr_rom[i]);
    }
    std::cout << std::endl;
    
    std::cout << "CHR ROM at 0x1000: ";
    for (int i = 0x1000; i < 0x1010 && i < chr_rom.size(); i++) {
        printf("%02X ", chr_rom[i]);
    }
    std::cout << std::endl;
    
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
    int mapper = 0;
    if (!load_rom(argv[1], prg_rom, chr_rom, mapper)) return 1;
    
    if (mapper != 0 && mapper != 4) {
        std::cerr << "Unsupported mapper: " << mapper << std::endl;
        std::cerr << "Only Mapper 0 (NROM) and Mapper 4 (MMC3) are supported" << std::endl;
        return 1;
    }
    
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
    uint32_t last_chr_addr = 0xFFFFFFFF;
    int chr_changes = 0;
    bool nmi_handler_seen = false;
    
    while (cycles < 21477272 * 10 && !Verilated::gotFinish()) {
        dut->clk = !dut->clk;
        
        if (dut->clk) {
            uint32_t prg_addr = dut->prg_rom_addr % prg_rom.size();
            dut->prg_rom_data = prg_rom[prg_addr];
            
            uint32_t chr_addr = dut->chr_rom_addr % chr_rom.size();
            dut->chr_rom_data = chr_rom[chr_addr];
            
            // 记录地址变化
            if (chr_addr != last_chr_addr && chr_changes < 100) {
                printf("Cycle %lu: CHR addr changed %04X -> %04X (data=%02X)\n", 
                       cycles, last_chr_addr, chr_addr, chr_rom[chr_addr]);
                last_chr_addr = chr_addr;
                chr_changes++;
            }
            
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
