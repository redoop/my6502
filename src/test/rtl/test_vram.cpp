#include <verilated.h>
#include "Vnes_system.h"
#include <iostream>

int main() {
    Vnes_system* dut = new Vnes_system;
    
    dut->clk = 0;
    dut->rst_n = 0;
    dut->prg_rom_data = 0;
    dut->chr_rom_data = 0;
    dut->controller1 = 0;
    dut->controller2 = 0;
    
    // Reset
    for (int i = 0; i < 10; i++) {
        dut->clk = !dut->clk;
        dut->eval();
    }
    dut->rst_n = 1;
    
    std::cout << "Testing VRAM write..." << std::endl;
    
    // Run for 1 second
    for (uint64_t cycles = 0; cycles < 21477272; cycles++) {
        dut->clk = !dut->clk;
        dut->eval();
    }
    
    std::cout << "VRAM write count: " << dut->vram_write_count << std::endl;
    std::cout << "NMI trigger count: " << dut->nmi_trigger_count << std::endl;
    
    delete dut;
    return 0;
}
