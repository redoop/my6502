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

int kbhit() {
    struct timeval tv = {0, 0};
    fd_set fds;
    FD_ZERO(&fds);
    FD_SET(0, &fds);
    return select(1, &fds, NULL, NULL, &tv) > 0;
}

int main() {
    cpu = new Vcpu_6502;
    
    // 加载 Tiny BASIC (0x0200-0x13FF)
    FILE* f = fopen("basic/6502-Tiny-BASIC/tinybasic.bin", "rb");
    if (!f) { printf("Can't open Tiny BASIC\n"); return 1; }
    fread(&mem[0x0200], 1, 4608, f);
    fclose(f);
    printf("Loaded Tiny BASIC (4.5KB at 0x0200)\n");
    
    // Tiny BASIC 需要的 Monitor 函数
    // OUTCH at 0x1EA0 - 输出 A 中的字符
    mem[0x1EA0] = 0x8D; mem[0x1EA1] = 0x00; mem[0x1EA2] = 0xE0;  // STA $E000
    mem[0x1EA3] = 0x60;  // RTS
    
    // GETCH at 0x1E5A - 读取字符到 A (阻塞)
    mem[0x1E5A] = 0xAD; mem[0x1E5B] = 0x01; mem[0x1E5C] = 0xE0;  // LDA $E001
    mem[0x1E5D] = 0xF0; mem[0x1E5E] = 0xFB;  // BEQ -5 (等待)
    mem[0x1E5F] = 0x60;  // RTS
    
    // CRLF at 0x1E2F - 输出回车换行
    mem[0x1E2F] = 0xA9; mem[0x1E30] = 0x0D;  // LDA #$0D
    mem[0x1E31] = 0x20; mem[0x1E32] = 0xA0; mem[0x1E33] = 0x1E;  // JSR $1EA0
    mem[0x1E34] = 0xA9; mem[0x1E35] = 0x0A;  // LDA #$0A
    mem[0x1E36] = 0x20; mem[0x1E37] = 0xA0; mem[0x1E38] = 0x1E;  // JSR $1EA0
    mem[0x1E39] = 0x60;  // RTS
    
    // OUTHEX at 0x1E3B - 输出 A 为十六进制 (简化实现)
    mem[0x1E3B] = 0x60;  // RTS (暂时跳过)
    
    // MONITOR at 0x1C4F - 返回 Monitor (退出)
    mem[0x1C4F] = 0x00;  // BRK (停止)
    
    // 设置重置向量指向 0x0200
    mem[0xFFFC] = 0x00;
    mem[0xFFFD] = 0x02;
    
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
    
    printf("Starting Tiny BASIC...\n\n");
    
    long cycle = 0;
    while (cycle < 100000000) {
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            // 读操作
            if (addr == 0xE001) {  // 输入字符 (GETCH)
                if (kbhit()) {
                    uint8_t c = getchar();
                    if (c == '\n') c = '\r';
                    cpu->data_in = c;
                } else {
                    cpu->data_in = 0;  // 没有字符
                }
            } else {
                cpu->data_in = mem[addr];
            }
        } else {
            // 写操作
            if (addr == 0xE000) {  // 输出字符 (OUTCH)
                char c = cpu->data_out;
                if (c == '\r') c = '\n';
                putchar(c);
                fflush(stdout);
            } else if (addr < 0x1400) {  // RAM
                mem[addr] = cpu->data_out;
            }
        }
        
        tick();
        cycle++;
        
        if (cycle % 10000000 == 0) {
            printf("[%ldM cycles]\n", cycle/1000000);
            fflush(stdout);
        }
    }
    
    printf("\n\nTimeout after %ld cycles\n", cycle);
    delete cpu;
    return 0;
}
