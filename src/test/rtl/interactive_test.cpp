#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <termios.h>
#include <unistd.h>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;
struct termios old_tio;

void restore() { tcsetattr(0, TCSANOW, &old_tio); }
double sc_time_stamp() { return main_time; }

void tick() {
    cpu->clk = 0;
    cpu->eval();
    main_time++;
    cpu->clk = 1;
    cpu->eval();
    main_time++;
}

int main() {
    cpu = new Vcpu_6502;
    
    // Simple interactive program
    uint8_t prog[] = {
        // start at 0xC000
        0xA2, 0x00,              // ldx #0
        // banner_loop:
        0xBD, 0x1E, 0xC0,        // lda banner,x
        0xF0, 0x07,              // beq prompt
        0x8D, 0x02, 0xF0,        // sta $F002
        0xE8,                    // inx
        0x4C, 0x02, 0xC0,        // jmp banner_loop
        // prompt:
        0xA9, 0x3E,              // lda #'>'
        0x8D, 0x02, 0xF0,        // sta $F002
        0xA9, 0x20,              // lda #' '
        0x8D, 0x02, 0xF0,        // sta $F002
        // input_loop:
        0xAD, 0x00, 0xF0,        // lda $F000 (input)
        0x8D, 0x02, 0xF0,        // sta $F002 (echo)
        0xC9, 0x0D,              // cmp #13
        0xD0, 0xF6,              // bne input_loop
        0xA9, 0x0A,              // lda #10
        0x8D, 0x02, 0xF0,        // sta $F002
        0x4C, 0x0E, 0xC0,        // jmp prompt
        // banner:
        0x0D, 0x0A, 0x48, 0x61, 0x72, 0x64, 0x77, 0x61, 0x72, 0x65,
        0x20, 0x43, 0x50, 0x55, 0x0D, 0x0A, 0x00
    };
    
    for (int i = 0; i < sizeof(prog); i++) {
        mem[0xC000 + i] = prog[i];
    }
    
    mem[0xFFFC] = 0x00;
    mem[0xFFFD] = 0xC0;
    
    // Terminal setup
    tcgetattr(0, &old_tio);
    struct termios new_tio = old_tio;
    new_tio.c_lflag &= ~(ICANON | ECHO);
    new_tio.c_cc[VMIN] = 1;
    new_tio.c_cc[VTIME] = 0;
    tcsetattr(0, TCSANOW, &new_tio);
    atexit(restore);
    
    // Reset
    cpu->rst_n = 0;
    cpu->nmi = 0;
    cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    // Run
    while (true) {
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            if (addr == 0xF000) {
                cpu->data_in = getchar();
            } else {
                cpu->data_in = mem[addr];
            }
        } else {
            if (addr == 0xF002) {
                putchar(cpu->data_out);
                fflush(stdout);
            } else if (addr < 0xF000) {
                mem[addr] = cpu->data_out;
            }
        }
        
        tick();
    }
    
    delete cpu;
    return 0;
}
