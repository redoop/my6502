#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <cstring>
#include <termios.h>
#include <unistd.h>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;
struct termios old_tio;

void restore() { tcsetattr(0, TCSANOW, &old_tio); }
double sc_time_stamp() { return main_time; }
void tick() { cpu->clk = 0; cpu->eval(); main_time++; cpu->clk = 1; cpu->eval(); main_time++; }

int kbhit() {
    struct timeval tv = {0, 0};
    fd_set fds;
    FD_ZERO(&fds);
    FD_SET(0, &fds);
    return select(1, &fds, NULL, NULL, &tv) > 0;
}

int main() {
    cpu = new Vcpu_6502;
    
    // 加载 Hello Test 到 0x0300
    FILE* f = fopen("test_simple.bin", "rb");
    if (!f) { 
        f = fopen("basic/test_simple.bin", "rb");
        if (!f) { printf("Can't open test_simple.bin\n"); return 1; }
    }
    
    // 读取整个文件
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    
    // 加载到 0x0300 (代码段) 和 0xFFFC (重置向量)
    uint8_t buf[65536];
    fread(buf, 1, size, f);
    fclose(f);
    
    // 代码在 0x0300
    memcpy(&mem[0x0300], buf, size - 2);
    // 重置向量在最后 2 字节
    mem[0xFFFC] = buf[size-2];
    mem[0xFFFD] = buf[size-1];
    
    printf("Loaded Hello Test (%ld bytes at 0x0300)\n", size);
    printf("Reset vector: %02X%02X\n", mem[0xFFFD], mem[0xFFFC]);
    
    // 设置终端
    tcgetattr(0, &old_tio);
    struct termios new_tio = old_tio;
    new_tio.c_lflag &= ~(ICANON | ECHO);
    new_tio.c_cc[VMIN] = 0;
    new_tio.c_cc[VTIME] = 0;
    tcsetattr(0, TCSANOW, &new_tio);
    atexit(restore);
    
    // 复位 CPU
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    printf("Starting Hello Test (type: PRINT \"HELLO\")...\n\n");
    
    uint8_t kbd_char = 0;
    long cycle = 0;
    
    while (cycle < 100000000) {
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            if (addr == 0xF001) {  // 输入
                if (kbhit() && kbd_char == 0) {
                    kbd_char = getchar();
                    if (kbd_char == '\n') kbd_char = '\r';
                }
                cpu->data_in = kbd_char;
                if (kbd_char) kbd_char = 0;  // 读取后清除
            } else {
                cpu->data_in = mem[addr];
            }
        } else {
            if (addr == 0xF000) {  // 输出
                char c = cpu->data_out;
                if (c == '\r') c = '\n';
                putchar(c);
                fflush(stdout);
            } else if (addr < 0xF000) {
                mem[addr] = cpu->data_out;
            }
        }
        
        tick();
        cycle++;
    }
    
    printf("\n\nStopped after %ld cycles\n", cycle);
    delete cpu;
    return 0;
}
