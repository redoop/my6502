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
    memset(mem, 0, sizeof(mem));
    
    FILE* f = fopen("basic/tinybasic_my6502.bin", "rb");
    if (!f) {
        printf("Can't open tinybasic_my6502.bin\n");
        return 1;
    }
    
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    
    uint8_t buf[65536];
    fread(buf, 1, size, f);
    fclose(f);
    
    // Load at 0x0200
    memcpy(&mem[0x0200], buf, size - 2);
    // Reset vector
    mem[0xFFFC] = buf[size-2];
    mem[0xFFFD] = buf[size-1];
    
    printf("Testing Tiny BASIC for my6502\n\n");
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    char output[1024];
    int output_len = 0;
    uint8_t last_output = 0;
    bool output_written = false;
    
    for (int cycle = 0; cycle < 50000; cycle++) {
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            cpu->data_in = mem[addr];
        } else {
            mem[addr] = cpu->data_out;
            if (addr == 0xF000 && output_len < 1023) {
                if (!output_written || cpu->data_out != last_output) {
                    output[output_len++] = cpu->data_out;
                    printf("%c", cpu->data_out);
                    fflush(stdout);
                    last_output = cpu->data_out;
                    output_written = true;
                }
            } else if (addr != 0xF000) {
                output_written = false;
            }
        }
        
        tick();
        
        if (output_len > 50) break;
    }
    
    output[output_len] = '\0';
    printf("\n\nOutput: %s\n", output);
    
    delete cpu;
    return 0;
}
