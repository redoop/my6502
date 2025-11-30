#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;

double sc_time_stamp() { return main_time; }
void tick() { cpu->clk = 0; cpu->eval(); main_time++; cpu->clk = 1; cpu->eval(); main_time++; }

int main() {
    cpu = new Vcpu_6502;
    
    // Simple: LDA #'A', STA $F002, JMP $C000
    mem[0xC000] = 0xA9; mem[0xC001] = 0x41;  // LDA #'A'
    mem[0xC002] = 0x8D; mem[0xC003] = 0x02; mem[0xC004] = 0xF0;  // STA $F002
    mem[0xC005] = 0x4C; mem[0xC006] = 0x05; mem[0xC007] = 0xC0;  // JMP $C005 (halt)
    
    mem[0xFFFC] = 0x00; mem[0xFFFD] = 0xC0;
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    printf("PC after reset: 0x%04X\n", cpu->pc_out);
    
    for (int i = 0; i < 200; i++) {
        if (cpu->rw) {
            cpu->data_in = mem[cpu->addr];
        } else {
            if (cpu->addr == 0xF002) {
                printf("Output at cycle %d: '%c' (0x%02X)\n", i, cpu->data_out, cpu->data_out);
            }
            mem[cpu->addr] = cpu->data_out;
        }
        
        if (i < 50 || (i >= 100 && i < 110)) {
            printf("Cycle %3d: PC=0x%04X addr=0x%04X rw=%d din=0x%02X dout=0x%02X\n",
                   i, cpu->pc_out, cpu->addr, cpu->rw, cpu->data_in, cpu->data_out);
        }
        
        tick();
    }
    
    delete cpu;
    return 0;
}
