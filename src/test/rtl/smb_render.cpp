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
    int mapper = ((header[6] >> 4) & 0x0F) | (header[7] & 0xF0);
    
    std::cout << "PRG ROM: " << prg_size << " bytes, CHR ROM: " << chr_size << " bytes, Mapper: " << mapper << std::endl;
    
    prg_rom.resize(prg_size > 0 ? prg_size : 16384);
    chr_rom.resize(chr_size > 0 ? chr_size : 8192);
    
    file.read((char*)prg_rom.data(), prg_size);
    if (chr_size > 0) file.read((char*)chr_rom.data(), chr_size);
    
    return true;
}

void save_ppm(const char* filename, uint8_t* framebuffer, int width, int height) {
    std::ofstream file(filename, std::ios::binary);
    file << "P6\n" << width << " " << height << "\n255\n";
    file.write((char*)framebuffer, width * height * 3);
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
    
    uint8_t framebuffer[256 * 240 * 3];
    uint64_t cycles = 0;
    int frames = 0;
    bool last_vsync = false;
    int pixel_x = 0, pixel_y = 0;
    
    std::cout << "Running..." << std::endl;
    
    // Run for 600 frames (10 seconds)
    while (cycles < 21477272 * 10 && !Verilated::gotFinish()) {
        dut->clk = !dut->clk;
        
        if (dut->clk) {
            // Simulate START button press at frame 60-120
            if (frames >= 60 && frames < 120) {
                dut->controller1 = 0x08;  // START button
            } else {
                dut->controller1 = 0x00;
            }
            
            uint32_t prg_addr = dut->prg_rom_addr % prg_rom.size();
            dut->prg_rom_data = prg_rom[prg_addr];
            
            uint32_t chr_addr = dut->chr_rom_addr % chr_rom.size();
            dut->chr_rom_data = chr_rom[chr_addr];
            
            // Capture video output
            if (dut->video_de) {
                int idx = (pixel_y * 256 + pixel_x) * 3;
                if (idx >= 0 && idx < 256 * 240 * 3) {
                    framebuffer[idx + 0] = dut->video_r;
                    framebuffer[idx + 1] = dut->video_g;
                    framebuffer[idx + 2] = dut->video_b;
                }
                pixel_x++;
                if (pixel_x >= 256) {
                    pixel_x = 0;
                    pixel_y++;
                }
            }
            
            if (!dut->video_vsync && last_vsync) {
                frames++;
                pixel_x = 0;
                pixel_y = 0;
                
                if (frames == 60 || frames == 180 || frames == 360 || frames == 600) {
                    char filename[64];
                    sprintf(filename, "smb_frame_%04d.ppm", frames);
                    save_ppm(filename, framebuffer, 256, 240);
                    std::cout << "Frame " << frames << " saved to " << filename << std::endl;
                }
            }
            last_vsync = dut->video_vsync;
            cycles++;
        }
        
        dut->eval();
    }
    
    std::cout << "Total frames: " << frames << std::endl;
    delete dut;
    return 0;
}
