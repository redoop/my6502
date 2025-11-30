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
    
    FILE* f = fopen("basic/test_jmp.bin", "rb");
    if (!f) { printf("Can't open test_jmp.bin\n"); return 1; }
    
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    
    uint8_t buf[65536];
    fread(buf, 1, size, f);
    fclose(f);
    
    memcpy(&mem[0x0300], buf, size - 2);
    mem[0xFFFC] = buf[size-2];
    mem[0xFFFD] = buf[size-1];
    
    printf("Test: JMP instruction\n");
    printf("Expected: Output 'H' then 'I'\n\n");
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    uint16_t last_pc = 0xFFFF;
    
    for (int cycle = 0; cycle < 200; cycle++) {
        uint16_t addr = cpu->addr;
        uint16_t pc = cpu->pc_out;
        
        if (pc != last_pc && pc >= 0x0300 && pc < 0x0320) {
            printf("[PC=%04X] %02X\n", pc, mem[pc]);
            last_pc = pc;
        }
        
        if (cpu->rw) {
            cpu->data_in = mem[addr];
        } else {
            mem[addr] = cpu->data_out;
            if (addr == 0xF000) {
                printf("OUTPUT: '%c' (0x%02X)\n", cpu->data_out, cpu->data_out);
            }
        }
        
        if (mem[pc] == 0x00 && pc == 0x0310) {
            printf("\nBRK at PC=%04X - Test complete\n", pc);
            break;
        }
        
        tick();
    }
    
    delete cpu;
    return 0;
}
