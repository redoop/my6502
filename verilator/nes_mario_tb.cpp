#include <verilated.h>
#include "Vnes_system.h"
#include <iostream>
#include <fstream>
#include <vector>

// iNES ROM structure
struct iNESHeader {
    char magic[4];      // "NES\x1A"
    uint8_t prg_rom_size;  // 16KB units
    uint8_t chr_rom_size;  // 8KB units
    uint8_t flags6;
    uint8_t flags7;
    uint8_t prg_ram_size;
    uint8_t flags9;
    uint8_t flags10;
    uint8_t padding[5];
};

std::vector<uint8_t> prg_rom;
std::vector<uint8_t> chr_rom;

bool load_rom(const char* filename) {
    std::ifstream file(filename, std::ios::binary);
    if (!file) {
        std::cerr << "Failed to open: " << filename << std::endl;
        return false;
    }
    
    iNESHeader header;
    file.read((char*)&header, sizeof(header));
    
    if (header.magic[0] != 'N' || header.magic[1] != 'E' || 
        header.magic[2] != 'S' || header.magic[3] != 0x1A) {
        std::cerr << "Invalid iNES header" << std::endl;
        return false;
    }
    
    std::cout << "ROM Info:" << std::endl;
    std::cout << "  PRG ROM: " << (int)header.prg_rom_size * 16 << " KB" << std::endl;
    std::cout << "  CHR ROM: " << (int)header.chr_rom_size * 8 << " KB" << std::endl;
    std::cout << "  Mapper: " << (int)((header.flags6 >> 4) | (header.flags7 & 0xF0)) << std::endl;
    
    // Load PRG ROM
    prg_rom.resize(header.prg_rom_size * 16384);
    file.read((char*)prg_rom.data(), prg_rom.size());
    
    // Load CHR ROM
    chr_rom.resize(header.chr_rom_size * 8192);
    file.read((char*)chr_rom.data(), chr_rom.size());
    
    std::cout << "ROM loaded successfully" << std::endl;
    return true;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    
    const char* rom_file = argc > 1 ? argv[1] : "../games/Super-Mario-Bros.nes";
    
    if (!load_rom(rom_file)) {
        return 1;
    }
    
    Vnes_system* top = new Vnes_system;
    
    // Reset
    top->clk = 0;
    top->rst_n = 0;
    top->controller1 = 0;
    top->controller2 = 0;
    
    uint64_t cycle = 0;
    uint64_t frame = 0;
    bool prev_vsync = false;
    
    std::cout << "\nStarting simulation..." << std::endl;
    
    // Run simulation
    for (int i = 0; i < 1000000; i++) {
        // Release reset
        if (i == 10) top->rst_n = 1;
        
        // Provide ROM data
        if (top->prg_rom_addr < prg_rom.size()) {
            top->prg_rom_data = prg_rom[top->prg_rom_addr];
        } else {
            top->prg_rom_data = 0xFF;
        }
        
        if (top->chr_rom_addr < chr_rom.size()) {
            top->chr_rom_data = chr_rom[top->chr_rom_addr];
        } else {
            top->chr_rom_data = 0;
        }
        
        // Clock
        top->clk = 0;
        top->eval();
        top->clk = 1;
        top->eval();
        
        cycle++;
        
        // Detect frame
        if (top->video_vsync && !prev_vsync) {
            frame++;
            std::cout << "Frame " << frame 
                      << " Cycle " << cycle
                      << " PRG_ADDR=0x" << std::hex << top->prg_rom_addr
                      << " CHR_ADDR=0x" << top->chr_rom_addr
                      << std::dec << std::endl;
        }
        prev_vsync = top->video_vsync;
        
        // Print status every 100k cycles
        if (cycle % 100000 == 0) {
            std::cout << "Cycle " << cycle 
                      << " Frames " << frame
                      << " HSYNC=" << (int)top->video_hsync
                      << " VSYNC=" << (int)top->video_vsync
                      << " DE=" << (int)top->video_de
                      << std::endl;
        }
    }
    
    std::cout << "\nSimulation complete:" << std::endl;
    std::cout << "  Total cycles: " << cycle << std::endl;
    std::cout << "  Total frames: " << frame << std::endl;
    std::cout << "  FPS: " << (float)frame / (cycle / 1789773.0) << std::endl;
    
    delete top;
    return 0;
}
