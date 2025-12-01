#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <cstring>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;
uint8_t input_char = 0;
bool input_ready = false;

double sc_time_stamp() { return main_time; }
void tick() { 
    cpu->clk = 0; cpu->eval(); main_time++; 
    cpu->clk = 1; cpu->eval(); main_time++; 
}

int kbhit() {
    struct termios oldt, newt;
    int ch, oldf;
    
    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;
    newt.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &newt);
    oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
    fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);
    
    ch = getchar();
    
    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
    fcntl(STDIN_FILENO, F_SETFL, oldf);
    
    if(ch != EOF) {
        ungetc(ch, stdin);
        return 1;
    }
    return 0;
}

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Usage: %s <program.bin>\n", argv[0]);
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
    
    memcpy(&mem[0x0300], buf, size - 2);
    mem[0xFFFC] = buf[size-2];
    mem[0xFFFD] = buf[size-1];
    
    // Reset
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    // Main loop
    for (int cycle = 0; cycle < 10000000; cycle++) {
        if (kbhit()) {
            input_char = getchar();
            input_ready = true;
        }
        
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            if (addr == 0xF001) {
                cpu->data_in = input_ready ? input_char : 0;
                if (input_ready) input_ready = false;
            } else {
                cpu->data_in = mem[addr];
            }
        } else {
            mem[addr] = cpu->data_out;
            if (addr == 0xF000) {
                printf("%c", cpu->data_out);
                fflush(stdout);
            }
        }
        
        tick();
    }
    
    delete cpu;
    return 0;
}
