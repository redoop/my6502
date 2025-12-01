#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <cstring>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;

// 预设输入
const char* preset_input = "PRINT \"HELLO\"\r";
int input_index = 0;

double sc_time_stamp() { return main_time; }
void tick() { cpu->clk = 0; cpu->eval(); main_time++; cpu->clk = 1; cpu->eval(); main_time++; }

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
    
    printf("Mini BASIC - Preset Input Test\n");
    printf("Input: %s\n\n", preset_input);
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    uint8_t last_output = 0;
    bool output_written = false;
    int read_count = 0;
    bool char_consumed = false;  // 字符是否已被消费
    
    for (int cycle = 0; cycle < 1000000; cycle++) {
        uint16_t addr = cpu->addr;
        
        if (cpu->rw) {
            if (addr == 0xF001) {
                // 输入端口 - 返回当前字符直到被读取
                if (preset_input[input_index] != '\0') {
                    cpu->data_in = preset_input[input_index];
                    if (!char_consumed) {
                        char_consumed = true;  // 标记为已读
                        read_count++;
                    }
                } else {
                    cpu->data_in = 0;  // 输入结束
                }
            } else {
                cpu->data_in = mem[addr];
                // 如果读取的不是输入端口，准备下一个字符
                if (char_consumed && addr != 0xF001) {
                    input_index++;
                    char_consumed = false;
                }
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
        
        // 输入完成后再运行一段时间
        if (input_index > strlen(preset_input) && read_count > 100) break;
    }
    
    printf("\n\nTest complete. Input chars read: %d\n", read_count);
    delete cpu;
    return 0;
}
