#include <verilated.h>
#include "Vnes_system.h"
#include <fstream>
#include <iostream>
#include <sys/stat.h>

#define FRAME_WIDTH 256
#define FRAME_HEIGHT 240

class FrameCapture {
    uint8_t framebuffer[FRAME_HEIGHT][FRAME_WIDTH][3];
    int pixel_x, pixel_y;
    int frame_count;
    int capture_interval;
    std::string output_dir;
    bool last_vsync;
    
public:
    FrameCapture(const std::string& dir, int interval = 60) 
        : pixel_x(0), pixel_y(0), frame_count(0), capture_interval(interval), 
          output_dir(dir), last_vsync(false) {
        mkdir(dir.c_str(), 0755);
        memset(framebuffer, 0, sizeof(framebuffer));
    }
    
    void update(uint8_t r, uint8_t g, uint8_t b, bool de, bool vsync) {
        // Capture pixel
        if (de && pixel_y < FRAME_HEIGHT && pixel_x < FRAME_WIDTH) {
            framebuffer[pixel_y][pixel_x][0] = r;
            framebuffer[pixel_y][pixel_x][1] = g;
            framebuffer[pixel_y][pixel_x][2] = b;
        }
        
        // Track position
        if (de) {
            pixel_x++;
            if (pixel_x >= FRAME_WIDTH) {
                pixel_x = 0;
                pixel_y++;
            }
        }
        
        // Frame complete on vsync rising edge
        if (vsync && !last_vsync) {
            if (frame_count % capture_interval == 0) {
                save_ppm();
            }
            frame_count++;
            pixel_x = 0;
            pixel_y = 0;
        }
        last_vsync = vsync;
    }
    
    void save_ppm() {
        char filename[256];
        snprintf(filename, sizeof(filename), "%s/frame_%04d.ppm", 
                 output_dir.c_str(), frame_count);
        std::ofstream file(filename, std::ios::binary);
        if (!file) {
            std::cerr << "Failed to create: " << filename << std::endl;
            return;
        }
        file << "P6\n" << FRAME_WIDTH << " " << FRAME_HEIGHT << "\n255\n";
        file.write((char*)framebuffer, FRAME_WIDTH * FRAME_HEIGHT * 3);
        std::cout << "Frame " << frame_count << " saved" << std::endl;
    }
    
    int get_frame_count() { return frame_count; }
};

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <rom_file> [output_dir] [interval]" << std::endl;
        return 1;
    }
    
    std::string rom_file = argv[1];
    std::string output_dir = argc > 2 ? argv[2] : "frames";
    int interval = argc > 3 ? atoi(argv[3]) : 60;
    
    Verilated::commandArgs(argc, argv);
    Vnes_system* dut = new Vnes_system;
    FrameCapture capture(output_dir, interval);
    
    // Load ROM
    std::ifstream rom(rom_file, std::ios::binary);
    if (!rom) {
        std::cerr << "Cannot open ROM: " << rom_file << std::endl;
        return 1;
    }
    
    uint8_t header[16];
    rom.read((char*)header, 16);
    
    int prg_size = header[4] * 16384;
    int chr_size = header[5] * 8192;
    
    uint8_t* prg_rom = new uint8_t[prg_size];
    uint8_t* chr_rom = new uint8_t[chr_size];
    
    rom.read((char*)prg_rom, prg_size);
    rom.read((char*)chr_rom, chr_size);
    rom.close();
    
    std::cout << "ROM: PRG=" << prg_size << " CHR=" << chr_size << std::endl;
    std::cout << "Output: " << output_dir << " (every " << interval << " frames)" << std::endl;
    
    // Reset
    dut->clk = 0;
    dut->rst_n = 0;
    for (int i = 0; i < 10; i++) {
        dut->clk = !dut->clk;
        dut->eval();
    }
    dut->rst_n = 1;
    
    // Run
    const int MAX_FRAMES = 600;
    
    while (!Verilated::gotFinish() && capture.get_frame_count() < MAX_FRAMES) {
        dut->clk = !dut->clk;
        
        if (dut->clk) {
            if (dut->prg_rom_addr < prg_size) {
                dut->prg_rom_data = prg_rom[dut->prg_rom_addr];
            }
            if (dut->chr_rom_addr < chr_size) {
                dut->chr_rom_data = chr_rom[dut->chr_rom_addr];
            }
            
            capture.update(dut->video_r, dut->video_g, dut->video_b, 
                          dut->video_de, dut->video_vsync);
        }
        
        dut->eval();
    }
    
    std::cout << "Complete: " << capture.get_frame_count() << " frames" << std::endl;
    
    delete[] prg_rom;
    delete[] chr_rom;
    delete dut;
    return 0;
}
