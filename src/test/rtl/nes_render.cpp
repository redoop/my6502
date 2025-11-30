#include <verilated.h>
#include "Vnes_system.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <cstdint>

bool load_rom(const char* filename, std::vector<uint8_t>& prg_rom, std::vector<uint8_t>& chr_rom) {
    std::ifstream file(filename, std::ios::binary);
    if (!file) return false;
    
    uint8_t header[16];
    file.read((char*)header, 16);
    if (header[0] != 'N' || header[1] != 'E' || header[2] != 'S' || header[3] != 0x1A) return false;
    
    int prg_size = header[4] * 16384;
    int chr_size = header[5] * 8192;
    
    std::cout << "PRG: " << prg_size << " bytes, CHR: " << chr_size << " bytes" << std::endl;
    
    prg_rom.resize(prg_size > 0 ? prg_size : 16384);
    chr_rom.resize(chr_size > 0 ? chr_size : 8192);
    
    file.read((char*)prg_rom.data(), prg_size);
    if (chr_size > 0) file.read((char*)chr_rom.data(), chr_size);
    
    return true;
}

void save_frame(const char* filename, uint8_t* framebuffer) {
    std::ofstream file(filename, std::ios::binary);
    file << "P6\n256 240\n255\n";
    file.write((char*)framebuffer, 256 * 240 * 3);
    std::cout << "Saved: " << filename << std::endl;
}

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <rom.nes> [frames]" << std::endl;
        return 1;
    }
    
    int target_frames = argc > 2 ? atoi(argv[2]) : 10;
    
    Verilated::commandArgs(argc, argv);
    Vnes_system* dut = new Vnes_system;
    
    std::vector<uint8_t> prg_rom, chr_rom;
    if (!load_rom(argv[1], prg_rom, chr_rom)) return 1;
    
    // Reset
    dut->clk = 0;
    dut->rst_n = 0;
    dut->controller1 = 0;
    dut->controller2 = 0;
    
    for (int i = 0; i < 10; i++) {
        dut->clk = !dut->clk;
        dut->eval();
    }
    dut->rst_n = 1;
    
    std::cout << "Rendering " << target_frames << " frames..." << std::endl;
    
    uint8_t framebuffer[256 * 240 * 3];
    int frame_count = 0;
    bool last_vsync = false;
    int pixel_x = 0, pixel_y = 0;
    
    while (frame_count < target_frames && !Verilated::gotFinish()) {
        dut->clk = !dut->clk;
        
        if (dut->clk) {
            // ROM access
            uint32_t prg_addr = dut->prg_rom_addr % prg_rom.size();
            dut->prg_rom_data = prg_rom[prg_addr];
            
            uint32_t chr_addr = dut->chr_rom_addr % chr_rom.size();
            dut->chr_rom_data = chr_rom[chr_addr];
            
            // Capture pixels
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
                    if (pixel_y >= 240) pixel_y = 0;
                }
            }
            
            // Frame complete
            if (!dut->video_vsync && last_vsync) {
                frame_count++;
                
                // Save every 60 frames
                if (frame_count % 60 == 0) {
                    char filename[64];
                    snprintf(filename, sizeof(filename), "frame_%03d.ppm", frame_count);
                    save_frame(filename, framebuffer);
                }
                
                pixel_x = 0;
                pixel_y = 0;
            }
            last_vsync = dut->video_vsync;
        }
        
        dut->eval();
    }
    
    // Save final frame
    save_frame("frame_final.ppm", framebuffer);
    
    std::cout << "\nTotal frames: " << frame_count << std::endl;
    
    delete dut;
    return 0;
}
