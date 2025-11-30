#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;

double sc_time_stamp() { return main_time; }

void tick() {
    cpu->clk = 0; cpu->eval(); main_time++;
    cpu->clk = 1; cpu->eval(); main_time++;
}

int main() {
    cpu = new Vcpu_6502;
    
    // Simple: output "OK\n"
    uint8_t prog[] = {
        0xA9, 0x4F,              // lda #'O'
        0x8D, 0x02, 0xF0,        // sta $F002
        0xA9, 0x4B,              // lda #'K'
        0x8D, 0x02, 0xF0,        // sta $F002
        0xA9, 0x0A,              // lda #10
        0x8D, 0x02, 0xF0,        // sta $F002
        0x4C, 0x00, 0xC0,        // jmp $C000
    };
    
    for (int i = 0; i < sizeof(prog); i++) mem[0xC000 + i] = prog[i];
    mem[0xFFFC] = 0x00;
    mem[0xFFFD] = 0xC0;
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    printf("Starting...\n");
    
    for (int i = 0; i < 1000; i++) {
        if (cpu->rw) {
            cpu->data_in = mem[cpu->addr];
        } else {
            if (cpu->addr == 0xF002) {
                printf("%c", cpu->data_out);
                fflush(stdout);
            }
            mem[cpu->addr] = cpu->data_out;
        }
        tick();
    }
    
    printf("\nDone\n");
    delete cpu;
    return 0;
}
