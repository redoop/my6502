#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <cstring>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;

double sc_time_stamp() { return main_time; }
void tick() { cpu->clk = 0; cpu->eval(); main_time++; cpu->clk = 1; cpu->eval(); main_time++; }

int main() {
    cpu = new Vcpu_6502;
    
    FILE* f = fopen("hello.bin", "rb");
    if (!f) { 
        f = fopen("basic/hello.bin", "rb");
        if (!f) { printf("Can't open hello.bin\n"); return 1; }
    }
    
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    
    uint8_t buf[65536];
    fread(buf, 1, size, f);
    fclose(f);
    
    memcpy(&mem[0x0300], buf, size - 2);
    mem[0xFFFC] = buf[size-2];
    mem[0xFFFD] = buf[size-1];
    
    printf("Loaded Hello Test (%ld bytes at 0x0300)\n", size);
    printf("Reset vector: %02X%02X\n", mem[0xFFFD], mem[0xFFFC]);
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    printf("Starting...\n\n");
    
    long cycle = 0;
    int instr_count = 0;
    
    while (cycle < 1000 && instr_count < 50) {
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            cpu->data_in = mem[addr];
        } else {
            if (addr == 0xF000) {
                printf("[OUT] '%c' (0x%02X)\n", cpu->data_out, cpu->data_out);
                instr_count++;
            }
            mem[addr] = cpu->data_out;
        }
        
        tick();
        cycle++;
    }
    
    printf("\nDone after %ld cycles, %d outputs\n", cycle, instr_count);
    delete cpu;
    return 0;
}
