// NES Game Testbench - Run NES ROMs with Verilator

#include <verilated.h>
#include "Vnes_system.h"
#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

// ROM data
vector<uint8_t> prg_rom;
vector<uint8_t> chr_rom;

// Load NES ROM
bool load_rom(const char* filename) {
    ifstream file(filename, ios::binary);
    if (!file) {
        cerr << "Failed to open ROM: " << filename << endl;
        return false;
    }
    
    // Read header
    uint8_t header[16];
    file.read((char*)header, 16);
    
    if (header[0] != 'N' || header[1] != 'E' || header[2] != 'S' || header[3] != 0x1A) {
        cerr << "Invalid NES ROM format" << endl;
        return false;
    }
    
    int prg_size = header[4] * 16384;  // 16KB units
    int chr_size = header[5] * 8192;   // 8KB units
    
    cout << "Loading ROM: " << filename << endl;
    cout << "  PRG ROM: " << prg_size << " bytes" << endl;
    cout << "  CHR ROM: " << chr_size << " bytes" << endl;
    
    // Read PRG ROM
    prg_rom.resize(prg_size);
    file.read((char*)prg_rom.data(), prg_size);
    
    // Read CHR ROM
    if (chr_size > 0) {
        chr_rom.resize(chr_size);
        file.read((char*)chr_rom.data(), chr_size);
    }
    
    return true;
}

// Verilator main (for --binary mode)
double sc_time_stamp() { return 0; }

int main(int argc, char** argv, char** env) {
    if (argc < 2) {
        cerr << "Usage: " << argv[0] << " <rom_file.nes> [cycles]" << endl;
        return 1;
    }
    
    // Load ROM
    if (!load_rom(argv[1])) {
        return 1;
    }
    
    int max_cycles = (argc > 2) ? atoi(argv[2]) : 1000000;
    
    const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
    contextp->commandArgs(argc, argv);
    
    const std::unique_ptr<Vnes_system> top{new Vnes_system{contextp.get()}};
    
    // Reset
    top->clk = 0;
    top->rst_n = 0;
    top->controller1 = 0;
    top->controller2 = 0;
    
    for (int i = 0; i < 10; i++) {
        top->clk = !top->clk;
        top->eval();
    }
    
    top->rst_n = 1;
    
    // Run simulation
    cout << "Running simulation for " << max_cycles << " cycles..." << endl;
    
    for (int cycle = 0; cycle < max_cycles && !contextp->gotFinish(); cycle++) {
        // Clock
        top->clk = 0;
        top->eval();
        
        // PRG ROM access
        if (top->prg_rom_addr < prg_rom.size()) {
            top->prg_rom_data = prg_rom[top->prg_rom_addr];
        } else {
            top->prg_rom_data = 0;
        }
        
        // CHR ROM access
        if (top->chr_rom_addr < chr_rom.size()) {
            top->chr_rom_data = chr_rom[top->chr_rom_addr];
        } else {
            top->chr_rom_data = 0;
        }
        
        top->clk = 1;
        top->eval();
        
        // Progress indicator
        if (cycle % 100000 == 0) {
            cout << "  Cycle: " << cycle 
                 << " VRAM writes: " << (int)top->vram_write_count
                 << " NMI triggers: " << (int)top->nmi_trigger_count << endl;
        }
    }
    
    cout << "Simulation complete!" << endl;
    cout << "  Total VRAM writes: " << (int)top->vram_write_count << endl;
    cout << "  Total NMI triggers: " << (int)top->nmi_trigger_count << endl;
    
    top->final();
    return 0;
}
