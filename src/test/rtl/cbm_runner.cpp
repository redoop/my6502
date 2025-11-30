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
void tick() { cpu->clk = 0; cpu->eval(); main_time++; cpu->clk = 1; cpu->eval(); main_time++; }

int main() {
    cpu = new Vcpu_6502;
    
    // Load Commodore BASIC 1
    FILE* f = fopen("../../../basic/msbasic/tmp/cbmbasic1.bin", "rb");
    if (!f) { printf("Can't open cbmbasic1.bin\n"); return 1; }
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    fread(&mem[0xC000], 1, size, f);
    fclose(f);
    
    printf("Loaded Commodore BASIC: %ld bytes\n", size);
    
    // Commodore BASIC starts at 0xC000
    mem[0xFFFC] = 0x00;
    mem[0xFFFD] = 0xC0;
    
    // Terminal
    tcgetattr(0, &old_tio);
    struct termios new_tio = old_tio;
    new_tio.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(0, TCSANOW, &new_tio);
    atexit(restore);
    
    // Reset
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    printf("Starting Commodore BASIC...\n\n");
    
    // Run
    for (int i = 0; i < 100000; i++) {
        if (cpu->rw) {
            if (cpu->addr >= 0xF000 && cpu->addr <= 0xFFFF) {
                cpu->data_in = getchar();
            } else {
                cpu->data_in = mem[cpu->addr];
            }
        } else {
            if (cpu->addr >= 0xF000 && cpu->addr <= 0xFFFF) {
                putchar(cpu->data_out);
                fflush(stdout);
            } else {
                mem[cpu->addr] = cpu->data_out;
            }
        }
        tick();
        
        if (i % 10000 == 0) {
            printf(".");
            fflush(stdout);
        }
    }
    
    printf("\n\nTimeout\n");
    delete cpu;
    return 0;
}
