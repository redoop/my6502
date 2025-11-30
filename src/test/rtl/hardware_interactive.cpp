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
int input_ready = 0;
int input_char = 0;

void restore() { tcsetattr(0, TCSANOW, &old_tio); }
double sc_time_stamp() { return main_time; }

void tick() {
    cpu->clk = 0; cpu->eval(); main_time++;
    cpu->clk = 1; cpu->eval(); main_time++;
}

int kbhit() {
    struct timeval tv = {0, 0};
    fd_set fds;
    FD_ZERO(&fds);
    FD_SET(0, &fds);
    return select(1, &fds, NULL, NULL, &tv) > 0;
}

int main() {
    cpu = new Vcpu_6502;
    
    // Interactive program
    uint8_t prog[] = {
        // 0xC000: start
        0xA2, 0x00,              // ldx #0
        // banner_loop:
        0xBD, 0x1E, 0xC0,        // lda banner,x
        0xF0, 0x07,              // beq prompt
        0x8D, 0x02, 0xF0,        // sta $F002
        0xE8,                    // inx
        0x4C, 0x02, 0xC0,        // jmp banner_loop
        // prompt: 0xC00E
        0xA9, 0x3E,              // lda #'>'
        0x8D, 0x02, 0xF0,        // sta $F002
        0xA9, 0x20,              // lda #' '
        0x8D, 0x02, 0xF0,        // sta $F002
        // input_loop: 0xC018
        0xAD, 0x01, 0xF0,        // lda $F001 (status)
        0xF0, 0xFA,              // beq input_loop (wait)
        0xAD, 0x00, 0xF0,        // lda $F000 (data)
        0x8D, 0x02, 0xF0,        // sta $F002 (echo)
        0xC9, 0x0D,              // cmp #13
        0xD0, 0xF0,              // bne input_loop
        0xA9, 0x0A,              // lda #10
        0x8D, 0x02, 0xF0,        // sta $F002
        0x4C, 0x0E, 0xC0,        // jmp prompt
        // banner: 0xC01E
        0x0D, 0x0A,
        0x48, 0x61, 0x72, 0x64, 0x77, 0x61, 0x72, 0x65, 0x20,  // "Hardware "
        0x36, 0x35, 0x30, 0x32, 0x20, 0x43, 0x50, 0x55,        // "6502 CPU"
        0x0D, 0x0A, 0x00
    };
    
    for (int i = 0; i < sizeof(prog); i++) mem[0xC000 + i] = prog[i];
    mem[0xFFFC] = 0x00;
    mem[0xFFFD] = 0xC0;
    
    // Terminal setup
    tcgetattr(0, &old_tio);
    struct termios new_tio = old_tio;
    new_tio.c_lflag &= ~(ICANON | ECHO);
    new_tio.c_cc[VMIN] = 0;
    new_tio.c_cc[VTIME] = 0;
    tcsetattr(0, TCSANOW, &new_tio);
    atexit(restore);
    
    // Reset
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    // Run
    while (true) {
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            if (addr == 0xF001) {
                // Input status
                if (kbhit()) {
                    input_char = getchar();
                    input_ready = 1;
                }
                cpu->data_in = input_ready ? 1 : 0;
            } else if (addr == 0xF000) {
                // Input data
                cpu->data_in = input_char;
                input_ready = 0;
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
