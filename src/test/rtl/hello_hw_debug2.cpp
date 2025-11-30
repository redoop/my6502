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
    
    printf("Code at 0x0300:\n");
    for (int i = 0; i < 20; i++) {
        printf("%02X ", mem[0x0300 + i]);
    }
    printf("\n\n");
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    long cycle = 0;
    uint16_t last_pc = 0xFFFF;
    
    while (cycle < 500) {
        uint16_t addr = cpu->addr;
        uint16_t pc = cpu->pc_out;
        uint8_t a = cpu->A;
        uint8_t x = cpu->X;
        
        if (pc != last_pc) {
            printf("[PC=%04X] opcode=%02X A=%02X X=%02X\n", pc, mem[pc], a, x);
            last_pc = pc;
        }
        
        if (cpu->rw) {
            cpu->data_in = mem[addr];
        } else {
            if (addr == 0xF000) {
                printf("[OUT @PC=%04X] '%c' (0x%02X)\n", pc, cpu->data_out, cpu->data_out);
            }
            mem[addr] = cpu->data_out;
        }
        
        tick();
        cycle++;
    }
    
    delete cpu;
    return 0;
}
