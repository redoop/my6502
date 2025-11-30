#include <verilated.h>
#include "Vcpu_6502.h"
#include <cstdio>
#include <cstring>

uint8_t mem[65536];
Vcpu_6502* cpu;
vluint64_t main_time = 0;

double sc_time_stamp() { return main_time; }
void tick() { cpu->clk = 0; cpu->eval(); main_time++; cpu->clk = 1; cpu->eval(); main_time++; }

bool run_test(const char* filename) {
    memset(mem, 0, sizeof(mem));
    
    FILE* f = fopen(filename, "rb");
    if (!f) {
        printf("  ✗ Can't open %s\n", filename);
        return false;
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
    
    cpu->rst_n = 0; cpu->nmi = 0; cpu->irq = 1;
    for (int i = 0; i < 10; i++) tick();
    cpu->rst_n = 1;
    
    char output[256];
    int output_len = 0;
    uint16_t last_pc = 0xFFFF;
    
    for (int cycle = 0; cycle < 100000; cycle++) {
        uint16_t addr = cpu->addr;
        uint16_t pc = cpu->pc_out;
        
        if (pc != last_pc && pc >= 0x0300 && pc < 0x0320 && cycle < 100) {
            printf("    [PC=%04X] %02X\n", pc, mem[pc]);
            last_pc = pc;
        }
        
        if (cpu->rw) {
            cpu->data_in = mem[addr];
        } else {
            mem[addr] = cpu->data_out;
            if (addr == 0xF000 && output_len < 255) {
                output[output_len++] = cpu->data_out;
                printf("    [OUT] '%c'\n", cpu->data_out);
            }
        }
        
        // Check for BRK (opcode 0x00) after getting some output
        if (mem[pc] == 0x00 && pc >= 0x0300 && output_len >= 2) {
            break;
        }
        
        // Timeout if stuck
        if (cycle > 1000 && output_len == 0) {
            break;
        }
        
        tick();
    }
    
    output[output_len] = '\0';
    
    if (output_len == 0) {
        printf("  ✗ No output\n");
        return false;
    }
    
    printf("  Output: %s\n", output);
    
    // Check if output contains "OK" or starts with test numbers
    if (strstr(output, "OK") || strstr(output, " OK")) {
        printf("  ✓ PASS\n");
        return true;
    } else if (strstr(output, "FAIL")) {
        printf("  ✗ FAIL\n");
        return false;
    } else {
        printf("  ? Unknown result\n");
        return false;
    }
}

int main() {
    cpu = new Vcpu_6502;
    
    const char* tests[] = {
        "basic/test_suite/01_basic/test_lda_sta.bin",
        "basic/test_suite/01_basic/test_math.bin",
        "basic/test_suite/02_control/test_branch.bin",
        "basic/test_suite/05_integration/test_fibonacci.bin"
    };
    
    int passed = 0;
    int total = sizeof(tests) / sizeof(tests[0]);
    
    printf("\n=== Running 6502 CPU Test Suite ===\n\n");
    
    for (int i = 0; i < total; i++) {
        printf("Test %d: %s\n", i+1, tests[i]);
        if (run_test(tests[i])) {
            passed++;
        }
    }
    
    printf("\n=== Results ===\n");
    printf("Passed: %d/%d\n", passed, total);
    
    if (passed == total) {
        printf("✓ All tests passed!\n");
    } else {
        printf("✗ %d test(s) failed\n", total - passed);
    }
    
    delete cpu;
    return (passed == total) ? 0 : 1;
}
