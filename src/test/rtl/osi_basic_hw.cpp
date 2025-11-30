#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <termios.h>
#include <unistd.h>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;
struct termios old_tio;
uint8_t kbd_data = 0;

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
    
    // 加载 OSI BASIC
    FILE* f = fopen("basic/msbasic/tmp/osi.bin", "rb");
    if (!f) { printf("Can't open OSI BASIC\n"); return 1; }
    fread(&mem[0xA000], 1, 8192, f);
    fclose(f);
    printf("Loaded OSI BASIC (7.7KB)\n");
    
    // 实现 Monitor 函数 (使用跳转表)
    // MONRDKEY at 0xFFEB
    mem[0xFFEB] = 0x4C; mem[0xFFEC] = 0x00; mem[0xFFED] = 0xFE;  // JMP $FE00
    
    // MONCOUT at 0xFFEE  
    mem[0xFFEE] = 0x4C; mem[0xFFEF] = 0x10; mem[0xFFF0] = 0xFE;  // JMP $FE10
    
    // MONISCNTC at 0xFFF1
    mem[0xFFF1] = 0x4C; mem[0xFFF2] = 0x20; mem[0xFFF3] = 0xFE;  // JMP $FE20
    
    // 实际的 I/O 代码
    // MONRDKEY 实现 at 0xFE00
    mem[0xFE00] = 0xAD; mem[0xFE01] = 0x00; mem[0xFE02] = 0xF0;  // LDA $F000
    mem[0xFE03] = 0x60;  // RTS
    
    // MONCOUT 实现 at 0xFE10
    mem[0xFE10] = 0x8D; mem[0xFE11] = 0x01; mem[0xFE12] = 0xF0;  // STA $F001
    mem[0xFE13] = 0x60;  // RTS
    
    // MONISCNTC 实现 at 0xFE20
    mem[0xFE20] = 0xA9; mem[0xFE21] = 0x00;  // LDA #0
    mem[0xFE22] = 0x60;  // RTS
    
    // 设置重置向量指向 COLD_START (0xBD11)
    mem[0xFFFC] = 0x11;
    mem[0xFFFD] = 0xBD;
    
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
    
    printf("Starting OSI BASIC...\n");
    printf("Reset vector: %02X%02X\n", mem[0xFFFD], mem[0xFFFC]);
    printf("First instruction at 0xA000: %02X %02X %02X\n\n", 
           mem[0xA000], mem[0xA001], mem[0xA002]);
    
    long cycle = 0;
    uint16_t last_pc = 0;
    long stuck_count = 0;
    
    while (cycle < 100000000) {
        // 检测死循环
        if (cpu->addr == last_pc) {
            stuck_count++;
            if (stuck_count > 100000) {
                printf("\n[STUCK] PC stuck at %04X for 100K cycles\n", last_pc);
                break;
            }
        } else {
            stuck_count = 0;
            last_pc = cpu->addr;
        }
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            // 读操作
            if (addr == 0xF000) {  // 键盘输入
                if (kbhit() && kbd_data == 0) {
                    kbd_data = getchar();
                    if (kbd_data == '\n') kbd_data = '\r';
                }
                cpu->data_in = kbd_data ? kbd_data : 0;
            } else {
                cpu->data_in = mem[addr];
            }
        } else {
            // 写操作
            if (addr == 0xF001) {  // 显示输出
                char c = cpu->data_out;
                if (c == '\r') c = '\n';
                if (c >= 32 || c == '\n' || c == '\t') {
                    putchar(c);
                    fflush(stdout);
                }
            } else if (addr < 0xA000) {  // RAM
                mem[addr] = cpu->data_out;
            }
        }
        
        tick();
        cycle++;
        
        if (cycle % 10000000 == 0 && cycle > 0) {
            printf("[%ldM cycles]\n", cycle/1000000);
            fflush(stdout);
        }
    }
    
    printf("\n\nTimeout after %ld cycles\n", cycle);
    delete cpu;
    return 0;
}
