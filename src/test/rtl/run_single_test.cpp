#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <cstring>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;

double sc_time_stamp() { return main_time; }
void tick() { cpu->clk = 0; cpu->eval(); main_time++; cpu->clk = 1; cpu->eval(); main_time++; }

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Usage: %s <test.bin>\n", argv[0]);
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
    
    printf("Testing: %s\n", argv[1]);
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    char output[256];
    int output_len = 0;
    uint16_t last_pc = 0xFFFF;
    
    for (int cycle = 0; cycle < 100000; cycle++) {
        uint16_t addr = cpu->addr;
        uint16_t pc = cpu->pc_out;
        
        if (pc != last_pc && cycle < 200) {
            printf("[%04X] %02X", pc, mem[pc]);
            if (pc == 0x0384) printf(" <- FAIL");
            printf("\n");
            last_pc = pc;
        }
        
        if (cpu->rw) {
            cpu->data_in = mem[addr];
        } else {
            mem[addr] = cpu->data_out;
            if (addr == 0xF000 && output_len < 255) {
                output[output_len++] = cpu->data_out;
                printf("%c", cpu->data_out);
                fflush(stdout);
            }
        }
        
        // Stop if we have enough output
        if (output_len >= 50) {
            break;
        }
        
        tick();
    }
    
    output[output_len] = '\0';
    printf("\n\nOutput: '%s'\n", output);
    
    if (strstr(output, "OK")) {
        printf("✓ PASS\n");
        delete cpu;
        return 0;
    } else if (strstr(output, "FAIL")) {
        printf("✗ FAIL\n");
        delete cpu;
        return 1;
    } else {
        printf("? Unknown\n");
        delete cpu;
        return 1;
    }
}
