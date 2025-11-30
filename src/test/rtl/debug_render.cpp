#include <verilated.h>
#include "Vnes_system.h"
#include <iostream>
#include <fstream>
#include <vector>

bool load_rom(const char* filename, std::vector<uint8_t>& prg, std::vector<uint8_t>& chr) {
    std::ifstream f(filename, std::ios::binary);
    if (!f) return false;
    uint8_t h[16];
    f.read((char*)h, 16);
    if (h[0] != 'N' || h[1] != 'E' || h[2] != 'S' || h[3] != 0x1A) return false;
    int ps = h[4] * 16384, cs = h[5] * 8192;
    prg.resize(ps > 0 ? ps : 16384);
    chr.resize(cs > 0 ? cs : 8192);
    f.read((char*)prg.data(), ps);
    if (cs > 0) f.read((char*)chr.data(), cs);
    return true;
}

int main(int argc, char** argv) {
    if (argc < 2) return 1;
    
    Vnes_system* dut = new Vnes_system;
    std::vector<uint8_t> prg, chr;
    if (!load_rom(argv[1], prg, chr)) return 1;
    
    dut->clk = 0; dut->rst_n = 0; dut->controller1 = 0; dut->controller2 = 0;
    for (int i = 0; i < 10; i++) { dut->clk = !dut->clk; dut->eval(); }
    dut->rst_n = 1;
    
    int frames = 0, pixels_seen = 0;
    bool last_vsync = false;
    
    for (int cycles = 0; cycles < 1000000 && frames < 5; cycles++) {
        dut->clk = !dut->clk;
        if (dut->clk) {
            dut->prg_rom_data = prg[dut->prg_rom_addr % prg.size()];
            dut->chr_rom_data = chr[dut->chr_rom_addr % chr.size()];
            
            if (dut->video_de) {
                pixels_seen++;
                if (pixels_seen <= 10) {
                    printf("Pixel: R=%02x G=%02x B=%02x\n", dut->video_r, dut->video_g, dut->video_b);
                }
            }
            
            if (!dut->video_vsync && last_vsync) {
                frames++;
                printf("Frame %d: %d pixels\n", frames, pixels_seen);
                pixels_seen = 0;
            }
            last_vsync = dut->video_vsync;
        }
        dut->eval();
    }
    
    delete dut;
    return 0;
}
