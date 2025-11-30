#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <cstdlib>
#include <termios.h>
#include <unistd.h>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;
struct termios old_tio;

void restore_terminal() {
    tcsetattr(STDIN_FILENO, TCSANOW, &old_tio);
}

double sc_time_stamp() { return main_time; }

void tick() {
    cpu->clk = 0;
    cpu->eval();
    main_time++;
    
    cpu->clk = 1;
    cpu->eval();
    main_time++;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    cpu = new Vcpu_6502;
    
    // Load AppleSoft ROM
    FILE* f = fopen("../../../basic/msbasic/tmp/applesoft.bin", "rb");
    if (!f) {
        printf("Can't open applesoft.bin\n");
        return 1;
    }
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    fread(&mem[0x0800], 1, size, f);
    fclose(f);
    
    printf("Loaded %ld bytes at 0x0800\n", size);
    
    // Setup Monitor ROM stubs at 0xF000
    // MONRDKEY at 0xFD0C - return 'C' for cold start
    mem[0xFD0C] = 0xA9;  // LDA #'C'
    mem[0xFD0D] = 0xC3;
    mem[0xFD0E] = 0x60;  // RTS
    
    // MONCOUT at 0xFDED - output character
    mem[0xFDED] = 0x8D;  // STA $F002
    mem[0xFDEE] = 0x02;
    mem[0xFDEF] = 0xF0;
    mem[0xFDF0] = 0x60;  // RTS
    
    // Reset vector points to COLD_START
    mem[0xFFFC] = 0x55;
    mem[0xFFFD] = 0x27;  // 0x2755
    
    // Setup terminal
    tcgetattr(STDIN_FILENO, &old_tio);
    struct termios new_tio = old_tio;
    new_tio.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &new_tio);
    atexit(restore_terminal);
    
    // Reset CPU
    cpu->rst_n = 0;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    printf("Starting AppleSoft BASIC...\n\n");
    
    // Run
    for (int i = 0; i < 1000000; i++) {
        // Memory read
        if (cpu->rw) {
            uint16_t addr = cpu->addr;
            if (addr == 0xF000) {
                // Keyboard input
                cpu->data_in = getchar() | 0x80;
            } else if (addr == 0xC000) {
                // Keyboard ready
                cpu->data_in = 0x80;
            } else {
                cpu->data_in = mem[addr];
            }
        } else {
            // Memory write
            uint16_t addr = cpu->addr;
            uint8_t data = cpu->data_out;
            
            if (addr == 0xF002) {
                // Output
                putchar(data & 0x7F);
                fflush(stdout);
            } else if (addr < 0xF000) {
                mem[addr] = data;
            }
        }
        
        tick();
        
        if (i % 100000 == 0) {
            printf(".");
            fflush(stdout);
        }
    }
    
    printf("\n\nDone\n");
    delete cpu;
    return 0;
}
