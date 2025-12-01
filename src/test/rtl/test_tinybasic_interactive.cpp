#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <cstring>
#include <queue>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;
std::queue<uint8_t> input_queue;

double sc_time_stamp() { return main_time; }
void tick() { cpu->clk = 0; cpu->eval(); main_time++; cpu->clk = 1; cpu->eval(); main_time++; }

void send_line(const char* line) {
    while (*line) {
        input_queue.push(*line++);
    }
    input_queue.push('\r');
}

int main() {
    cpu = new Vcpu_6502;
    memset(mem, 0, sizeof(mem));
    
    FILE* f = fopen("basic/tinybasic_interactive.bin", "rb");
    if (!f) {
        printf("Can't open tinybasic_interactive.bin\n");
        return 1;
    }
    
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    
    uint8_t buf[65536];
    fread(buf, 1, size, f);
    fclose(f);
    
    memcpy(&mem[0x0200], buf, size - 2);
    mem[0xFFFC] = buf[size-2];
    mem[0xFFFD] = buf[size-1];
    
    printf("Tiny BASIC Interactive Test\n\n");
    
    // Queue test commands
    send_line("PRINT \"HELLO WORLD\"");
    send_line("PRINT 123");
    send_line("PRINT \"TEST\"");
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    uint8_t last_out = 0;
    bool out_written = false;
    
    for (int cycle = 0; cycle < 100000; cycle++) {
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            if (addr == 0xF001) {
                // Input port
                if (!input_queue.empty()) {
                    cpu->data_in = input_queue.front();
                    input_queue.pop();
                } else {
                    cpu->data_in = 0;
                }
            } else {
                cpu->data_in = mem[addr];
            }
        } else {
            mem[addr] = cpu->data_out;
            if (addr == 0xF000) {
                if (!out_written || cpu->data_out != last_out) {
                    printf("%c", cpu->data_out);
                    fflush(stdout);
                    last_out = cpu->data_out;
                    out_written = true;
                }
            } else if (addr != 0xF000) {
                out_written = false;
            }
        }
        
        tick();
        
        // Stop if input queue empty and idle
        if (input_queue.empty() && cycle > 50000) break;
    }
    
    printf("\n");
    delete cpu;
    return 0;
}
