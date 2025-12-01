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
uint8_t input_buffer = 0;
bool input_ready = false;

double sc_time_stamp() { return main_time; }
void tick() { cpu->clk = 0; cpu->eval(); main_time++; cpu->clk = 1; cpu->eval(); main_time++; }

void set_nonblocking(bool enable) {
    static struct termios oldt, newt;
    if (enable) {
        tcgetattr(STDIN_FILENO, &oldt);
        newt = oldt;
        newt.c_lflag &= ~(ICANON | ECHO);
        tcsetattr(STDIN_FILENO, TCSANOW, &newt);
        fcntl(STDIN_FILENO, F_SETFL, O_NONBLOCK);
    } else {
        tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
        fcntl(STDIN_FILENO, F_SETFL, 0);
    }
}

bool check_input() {
    if (input_ready) return true;
    char c;
    if (read(STDIN_FILENO, &c, 1) == 1) {
        input_buffer = c;
        input_ready = true;
        return true;
    }
    return false;
}

int main() {
    cpu = new Vcpu_6502;
    memset(mem, 0, sizeof(mem));
    
    FILE* f = fopen("basic/mini_basic.bin", "rb");
    if (!f) {
        printf("Can't open mini_basic.bin\n");
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
    
    printf("\n=================================\n");
    printf("   Mini BASIC Interactive\n");
    printf("=================================\n");
    printf("Commands:\n");
    printf("  PRINT \"text\"  - Display text\n");
    printf("  Ctrl+C        - Exit\n");
    printf("=================================\n\n");
    
    set_nonblocking(true);
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    uint8_t last_output = 0;
    bool output_written = false;
    
    for (int cycle = 0; cycle < 10000000; cycle++) {
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            if (addr == 0xF001) {
                if (check_input()) {
                    cpu->data_in = input_buffer;
                    input_ready = false;
                } else {
                    cpu->data_in = 0;
                }
            } else {
                cpu->data_in = mem[addr];
            }
        } else {
            mem[addr] = cpu->data_out;
            if (addr == 0xF000) {
                if (!output_written || cpu->data_out != last_output) {
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
    }
    
    set_nonblocking(false);
    delete cpu;
    return 0;
}
