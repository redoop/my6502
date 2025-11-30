#include <verilated.h>
#include "Vnes_system.h"
#include <iostream>
#include <fstream>
#include <vector>

bool load_rom(const char* f, std::vector<uint8_t>& p, std::vector<uint8_t>& c) {
    std::ifstream file(f, std::ios::binary);
    if (!file) return false;
    uint8_t h[16];
    file.read((char*)h, 16);
    if (h[0] != 'N' || h[1] != 'E' || h[2] != 'S' || h[3] != 0x1A) return false;
    int ps = h[4] * 16384, cs = h[5] * 8192;
    p.resize(ps > 0 ? ps : 16384);
    c.resize(cs > 0 ? cs : 8192);
    file.read((char*)p.data(), ps);
    if (cs > 0) file.read((char*)c.data(), cs);
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
    
    uint8_t last_ppumask = 0;
    
    for (int cycles = 0; cycles < 500000; cycles++) {
        dut->clk = !dut->clk;
        if (dut->clk) {
            dut->prg_rom_data = prg[dut->prg_rom_addr % prg.size()];
            dut->chr_rom_data = chr[dut->chr_rom_addr % chr.size()];
            
            // Monitor PPUMASK changes
            if (dut->rootp->nes_system__DOT__ppumask != last_ppumask) {
                printf("PPUMASK changed: $%02x (bg=%d, spr=%d)\n", 
                    dut->rootp->nes_system__DOT__ppumask,
                    (dut->rootp->nes_system__DOT__ppumask >> 3) & 1,
                    (dut->rootp->nes_system__DOT__ppumask >> 4) & 1);
                last_ppumask = dut->rootp->nes_system__DOT__ppumask;
            }
        }
        dut->eval();
    }
    
    printf("\nFinal PPUMASK: $%02x\n", dut->rootp->nes_system__DOT__ppumask);
    
    delete dut;
    return 0;
}
