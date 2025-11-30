#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;
struct termios old_tio;

void restore() { tcsetattr(0, TCSANOW, &old_tio); }
double sc_time_stamp() { return main_time; }

void tick() {
    cpu->clk = 0; cpu->eval(); main_time++;
    cpu->clk = 1; cpu->eval(); main_time++;
}

int main() {
    cpu = new Vcpu_6502;
    
    // Simple program: output banner then prompt
    uint8_t prog[] = {
        // 0xC000
        0xA2, 0x00,              // ldx #0
        // loop:
        0xBD, 0x1A, 0xC0,        // lda msg,x
        0xF0, 0x07,              // beq prompt
        0x8D, 0x02, 0xF0,        // sta $F002
        0xE8,                    // inx
        0x4C, 0x02, 0xC0,        // jmp loop
        // prompt:
        0xA9, 0x3E,              // lda #'>'
        0x8D, 0x02, 0xF0,        // sta $F002
        0xA9, 0x20,              // lda #' '
        0x8D, 0x02, 0xF0,        // sta $F002
        // wait:
        0x4C, 0x14, 0xC0,        // jmp wait (infinite loop)
        // msg:
        0x0D, 0x0A, 0x48, 0x57, 0x20, 0x43, 0x50, 0x55, 0x0D, 0x0A, 0x00
    };
    
    for (int i = 0; i < sizeof(prog); i++) mem[0xC000 + i] = prog[i];
    mem[0xFFFC] = 0x00;
    mem[0xFFFD] = 0xC0;
    
    // Reset
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    printf("Hardware 6502 CPU Test\n");
    printf("======================\n\n");
    
    // Run for limited cycles
    for (int i = 0; i < 10000; i++) {
        if (cpu->rw) {
            cpu->data_in = mem[cpu->addr];
        } else {
            if (cpu->addr == 0xF002) {
                putchar(cpu->data_out);
                fflush(stdout);
            } else if (cpu->addr < 0xF000) {
                mem[cpu->addr] = cpu->data_out;
            }
        }
        tick();
    }
    
    printf("\n\nProgram completed\n");
    delete cpu;
    return 0;
}
