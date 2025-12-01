#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <cstring>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;

double sc_time_stamp() { return main_time; }
void tick() { cpu->clk = 0; cpu->eval(); main_time++; cpu->clk = 1; cpu->eval(); main_time++; }

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Usage: %s <bin_file>\n", argv[0]);
        return 1;
    }
    
    cpu = new Vcpu_6502;
    memset(mem, 0, sizeof(mem));
    
    FILE* f = fopen(argv[1], "rb");
    if (!f) {
        printf("Can't open %s\n", argv[1]);
        return 1;
    }
    
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    
    uint8_t buf[65536];
    fread(buf, 1, size, f);
    fclose(f);
    
    memcpy(&mem[0x0200], buf, size - 2);
    mem[0xFFFC] = buf[size-2];
    mem[0xFFFD] = buf[size-1];
    
    printf("Running %s\n\n", argv[1]);
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    uint8_t last_out = 0;
    bool out_written = false;
    
    for (int cycle = 0; cycle < 10000; cycle++) {
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            cpu->data_in = mem[addr];
        } else {
            mem[addr] = cpu->data_out;
            if (addr == 0xF000) {
                if (!out_written || cpu->data_out != last_out) {
                    printf("%c", cpu->data_out);
                    fflush(stdout);
                    last_out = cpu->data_out;
                    out_written = true;
                }
            } else if (addr != 0xF000) {
                out_written = false;
            }
        }
        
        tick();
    }
    
    printf("\n");
    delete cpu;
    return 0;
}
