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
    
    // Output "Hardware CPU\n> " then halt
    mem[0xC000] = 0xA9; mem[0xC001] = 0x48;  // LDA #'H'
    mem[0xC002] = 0x8D; mem[0xC003] = 0x02; mem[0xC004] = 0xF0;
    mem[0xC005] = 0xA9; mem[0xC006] = 0x57;  // LDA #'W'
    mem[0xC007] = 0x8D; mem[0xC008] = 0x02; mem[0xC009] = 0xF0;
    mem[0xC00A] = 0xA9; mem[0xC00B] = 0x20;  // LDA #' '
    mem[0xC00C] = 0x8D; mem[0xC00D] = 0x02; mem[0xC00E] = 0xF0;
    mem[0xC00F] = 0xA9; mem[0xC010] = 0x43;  // LDA #'C'
    mem[0xC011] = 0x8D; mem[0xC012] = 0x02; mem[0xC013] = 0xF0;
    mem[0xC014] = 0xA9; mem[0xC015] = 0x50;  // LDA #'P'
    mem[0xC016] = 0x8D; mem[0xC017] = 0x02; mem[0xC018] = 0xF0;
    mem[0xC019] = 0xA9; mem[0xC01A] = 0x55;  // LDA #'U'
    mem[0xC01B] = 0x8D; mem[0xC01C] = 0x02; mem[0xC01D] = 0xF0;
    mem[0xC01E] = 0xA9; mem[0xC01F] = 0x0A;  // LDA #10
    mem[0xC020] = 0x8D; mem[0xC021] = 0x02; mem[0xC022] = 0xF0;
    mem[0xC023] = 0xA9; mem[0xC024] = 0x3E;  // LDA #'>'
    mem[0xC025] = 0x8D; mem[0xC026] = 0x02; mem[0xC027] = 0xF0;
    mem[0xC028] = 0xA9; mem[0xC029] = 0x20;  // LDA #' '
    mem[0xC02A] = 0x8D; mem[0xC02B] = 0x02; mem[0xC02C] = 0xF0;
    mem[0xC02D] = 0xEA;  // NOP (halt here)
    mem[0xC02E] = 0xEA;
    mem[0xC02F] = 0xEA;
    
    mem[0xFFFC] = 0x00; mem[0xFFFD] = 0xC0;
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    printf("Hardware 6502 CPU Demo\n");
    printf("======================\n\n");
    
    for (int i = 0; i < 1000; i++) {
        if (cpu->rw) {
            cpu->data_in = mem[cpu->addr];
        } else {
            if (cpu->addr == 0xF002) {
                putchar(cpu->data_out);
                fflush(stdout);
            } else {
                mem[cpu->addr] = cpu->data_out;
            }
        }
        tick();
    }
    
    printf("\n\nDone!\n");
    delete cpu;
    return 0;
}
