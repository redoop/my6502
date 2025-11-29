#include <verilated.h>
#include "Vnes_system.h"
#include <iostream>

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Vnes_system* top = new Vnes_system;
    
    // Reset
    top->clk = 0;
    top->rst_n = 0;
    top->controller1 = 0;
    top->controller2 = 0;
    top->prg_rom_data = 0xEA; // NOP
    top->chr_rom_data = 0;
    
    // Run for a few cycles
    for (int i = 0; i < 100; i++) {
        // Release reset after 10 cycles
        if (i == 10) top->rst_n = 1;
        
        // Clock
        top->clk = 0;
        top->eval();
        top->clk = 1;
        top->eval();
        
        // Print status every 10 cycles
        if (i % 10 == 0) {
            std::cout << "Cycle " << i 
                      << " HSYNC=" << (int)top->video_hsync
                      << " VSYNC=" << (int)top->video_vsync
                      << " DE=" << (int)top->video_de
                      << std::endl;
        }
    }
    
    delete top;
    return 0;
}
