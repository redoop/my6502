// NES 系统 Verilator Testbench - 快速版本
// 优化性能，跳过不必要的周期

#include <verilated.h>
#include "VNESSystemRefactored.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <cstdint>
#include <chrono>
#include <iomanip>
#include <SDL.h>

// VCD 追踪支持
#if VM_TRACE
#include <verilated_vcd_c.h>
#endif

// 全局静默模式标志
bool g_quiet_mode = false;
bool g_trace_enabled = false;

// NES 调色板 (RGB)
const uint32_t NES_PALETTE[64] = {
    0x545454, 0x001E74, 0x081090, 0x300088, 0x440064, 0x5C0030, 0x540400, 0x3C1800,
    0x202A00, 0x083A00, 0x004000, 0x003C00, 0x00323C, 0x000000, 0x000000, 0x000000,
    0x989698, 0x084CC4, 0x3032EC, 0x5C1EE4, 0x8814B0, 0xA01464, 0x982220, 0x783C00,
    0x545A00, 0x287200, 0x087C00, 0x007628, 0x006678, 0x000000, 0x000000, 0x000000,
    0xECEEEC, 0x4C9AEC, 0x787CEC, 0xB062EC, 0xE454EC, 0xEC58B4, 0xEC6A64, 0xD48820,
    0xA0AA00, 0x74C400, 0x4CD020, 0x38CC6C, 0x38B4CC, 0x3C3C3C, 0x000000, 0x000000,
    0xECEEEC, 0xA8CCEC, 0xBCBCEC, 0xD4B2EC, 0xECAEEC, 0xECAED4, 0xECB4B0, 0xE4C490,
    0xCCD278, 0xB4DE78, 0xA8E290, 0x98E2B4, 0xA0D6E4, 0xA0A2A0, 0x000000, 0x000000
};

class NESEmulator {
public:
    VNESSystemRefactored* dut;
    uint64_t cycle_count;
    uint8_t mapper_num;
    
private:
#if VM_TRACE
    VerilatedVcdC* tfp;
#endif
    
    // ROM 数据
    std::vector<uint8_t> prg_rom;
    std::vector<uint8_t> chr_rom;
    
    // 显示
    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Texture* texture;
    uint32_t framebuffer[256 * 240];
    
    // 控制器状态
    uint8_t controller1;
    uint8_t controller2;
    
    // 性能优化：采样渲染
    int render_skip;
    
public:
    NESEmulator(VNESSystemRefactored* dut_ptr
#if VM_TRACE
                , VerilatedVcdC* tfp_ptr = nullptr
#endif
    ) : dut(dut_ptr), cycle_count(0), render_skip(0) {
#if VM_TRACE
        tfp = tfp_ptr;
#endif
        controller1 = 0;
        controller2 = 0;
        
        // 初始化 SDL
        if (SDL_Init(SDL_INIT_VIDEO) < 0) {
            std::cerr << "SDL 初始化失败: " << SDL_GetError() << std::endl;
            exit(1);
        }
        
        window = SDL_CreateWindow(
            "NES Verilator 仿真 (快速模式)",
            SDL_WINDOWPOS_CENTERED,
            SDL_WINDOWPOS_CENTERED,
            256 * 3, 240 * 3,
            SDL_WINDOW_SHOWN | SDL_WINDOW_ALLOW_HIGHDPI
        );
        
        if (!window) {
            std::cerr << "窗口创建失败: " << SDL_GetError() << std::endl;
            exit(1);
        }
        
        // macOS: 激活窗口
        SDL_RaiseWindow(window);
        
        renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
        if (!renderer) {
            std::cerr << "渲染器创建失败: " << SDL_GetError() << std::endl;
            exit(1);
        }
        
        texture = SDL_CreateTexture(
            renderer,
            SDL_PIXELFORMAT_ARGB8888,
            SDL_TEXTUREACCESS_STREAMING,
            256, 240
        );
        
        if (!texture) {
            std::cerr << "纹理创建失败: " << SDL_GetError() << std::endl;
            exit(1);
        }
        
        if (!g_quiet_mode) std::cout << "✅ SDL 初始化完成 (快速模式)" << std::endl;
    }
    
    ~NESEmulator() {
        if (texture) SDL_DestroyTexture(texture);
        if (renderer) SDL_DestroyRenderer(renderer);
        if (window) SDL_DestroyWindow(window);
        SDL_Quit();
    }
    
    bool loadROM(const char* filename) {
        std::ifstream file(filename, std::ios::binary);
        if (!file) {
            std::cerr << "无法打开 ROM 文件: " << filename << std::endl;
            return false;
        }
        
        // 读取 iNES 头
        uint8_t header[16];
        file.read(reinterpret_cast<char*>(header), 16);
        
        if (header[0] != 'N' || header[1] != 'E' || header[2] != 'S' || header[3] != 0x1A) {
            std::cerr << "无效的 NES ROM 文件" << std::endl;
            return false;
        }
        
        int prg_size = header[4] * 16384;
        int chr_size = header[5] * 8192;
        mapper_num = ((header[7] & 0xF0) | (header[6] >> 4));
        
        if (!g_quiet_mode) {
            std::cout << "📦 加载 ROM:" << std::endl;
            std::cout << "   PRG ROM: " << prg_size << " 字节" << std::endl;
            std::cout << "   CHR ROM: " << chr_size << " 字节" << std::endl;
            std::cout << "   Mapper: " << (int)mapper_num << std::endl;
        }
        
        // 读取 PRG ROM
        prg_rom.resize(prg_size);
        file.read(reinterpret_cast<char*>(prg_rom.data()), prg_size);
        
        // 读取 CHR ROM
        if (chr_size > 0) {
            chr_rom.resize(chr_size);
            file.read(reinterpret_cast<char*>(chr_rom.data()), chr_size);
        }
        
        file.close();
        
        // 加载到硬件
        loadROMToHardware();
        
        return true;
    }
    
    void loadROMToHardware() {
        if (!g_quiet_mode) std::cout << "⬆️  加载 ROM 到硬件..." << std::endl;
        
        // 加载所有 PRG ROM
        size_t prg_load_size = std::min(prg_rom.size(), (size_t)524288);
        
        // PRG ROM loading
        for (size_t i = 0; i < prg_load_size; i++) {
            dut->io_prgLoadEn = 1;
            dut->io_prgLoadAddr = i;
            dut->io_prgLoadData = prg_rom[i];
            tick();
            
            if (!g_quiet_mode && i % 16384 == 0) {
                std::cout << "\r   PRG: " << (i * 100 / prg_load_size) << "%" << std::flush;
            }
        }
        if (!g_quiet_mode) std::cout << "\r   PRG: 100%" << std::endl;
        
        // 加载 CHR ROM
        if (!chr_rom.empty()) {
            size_t chr_load_size = std::min(chr_rom.size(), (size_t)262144);
            for (size_t i = 0; i < chr_load_size; i++) {
                dut->io_chrLoadEn = 1;
                dut->io_chrLoadAddr = i;
                dut->io_chrLoadData = chr_rom[i];
                tick();
                
                if (!g_quiet_mode && i % 8192 == 0) {
                    std::cout << "\r   CHR: " << (i * 100 / chr_load_size) << "%" << std::flush;
                }
            }
            if (!g_quiet_mode) std::cout << "\r   CHR: 100%" << std::endl;
        }
        
        dut->io_prgLoadEn = 0;
        dut->io_chrLoadEn = 0;
        if (!g_quiet_mode) std::cout << "✅ ROM 加载完成" << std::endl;
    }
    
    void tick() {
        // 更新控制器状态（每个 tick 都更新）
        dut->io_controller1 = controller1;
        dut->io_controller2 = controller2;
        
        dut->clock = 0;
        dut->eval();
#if VM_TRACE
        if (tfp && g_trace_enabled) tfp->dump(cycle_count * 2);
#endif
        cycle_count++;
        
        dut->clock = 1;
        dut->eval();
#if VM_TRACE
        if (tfp && g_trace_enabled) tfp->dump(cycle_count * 2 + 1);
#endif
        
        // 监控所有内存读取 (前 100000 周期)
        if (cycle_count < 100000) {
            uint16_t memAddr = dut->io_debug_cpuMemAddr;
            uint8_t memDataIn = dut->io_debug_cpuMemDataIn;
            bool memRead = dut->io_debug_cpuMemRead;
            
            if (memRead) {
                printf("[Cycle %llu] MEM READ: Addr=0x%04X Data=0x%02X%s\n", 
                       (unsigned long long)cycle_count, memAddr, memDataIn,
                       (memAddr >= 0x2000 && memAddr < 0x4000) ? " (PPU)" : "");
            }
        }
        
        // 监控 PPUCTRL 写入 (静默模式下禁用)
        if (!g_quiet_mode) {
            static uint8_t last_ppuctrl = 0;
            uint8_t ppuctrl = dut->io_debug_ppuCtrl;
            if (ppuctrl != last_ppuctrl) {
                printf("\n🎨 PPUCTRL 变化: 0x%02X -> 0x%02X (Cycle %llu, PC=0x%04X)\n",
                       last_ppuctrl, ppuctrl, (unsigned long long)cycle_count, dut->io_debug_cpuPC);
                last_ppuctrl = ppuctrl;
            }
        }
        
        // Debug: 每 10000 个周期打印一次 CPU 状态 (静默模式下禁用)
        if (!g_quiet_mode) {
            static uint64_t last_debug_cycle = 0;
            static uint16_t last_pc = 0;
            static int stuck_count = 0;
            
            if (cycle_count - last_debug_cycle >= 10000) {
                uint16_t pc = dut->io_debug_cpuPC;
                uint8_t a = dut->io_debug_cpuA;
                uint8_t x = dut->io_debug_cpuX;
                uint8_t y = dut->io_debug_cpuY;
                bool vblank = dut->io_vblank;
                bool nmi = dut->io_debug_nmi;
                uint8_t state = dut->io_debug_cpuState;
                uint8_t cycle = dut->io_debug_cpuCycle;
                uint8_t opcode = dut->io_debug_cpuOpcode;
                uint8_t ppuctrl = dut->io_debug_ppuCtrl;
                
                const char* state_names[] = {"Reset", "Fetch", "Execute", "NMI", "Done"};
                const char* state_name = (state < 5) ? state_names[state] : "Unknown";
                
                uint16_t memAddr = dut->io_debug_cpuMemAddr;
                uint8_t memDataIn = dut->io_debug_cpuMemDataIn;
                bool memRead = dut->io_debug_cpuMemRead;
                
                printf("\n[Cycle %llu] PC=0x%04X A=0x%02X X=0x%02X Y=0x%02X State=%s(%d) Cycle=%d Opcode=0x%02X VBlank=%d NMI=%d PPUCTRL=0x%02X\n",
                       (unsigned long long)cycle_count, pc, a, x, y, state_name, state, cycle, opcode, vblank, nmi, ppuctrl);
                
                // 监控 PPU 寄存器读取
                if (memRead && memAddr >= 0x2000 && memAddr < 0x4000) {
                    printf("   [MEM READ] Addr=0x%04X Data=0x%02X (PPU Reg)\n", memAddr, memDataIn);
                }
                
                // 检测 PC 是否卡死
                if (pc == last_pc) {
                    stuck_count++;
                    
                    // 如果在等待 VBlank，允许更长时间
                    int max_stuck = (opcode == 0xF0 && pc == 0xC7A8) ? 100 : 3;
                    
                    if (stuck_count >= max_stuck) {
                        printf("⚠️  CPU 卡死！PC 没有变化 (连续 %d 次)\n", stuck_count);
                        printf("\n🔴 CPU 完全卡死在 State=%s, Cycle=%d, Opcode=0x%02X\n", state_name, cycle, opcode);
                        printf("   这可能是指令未实现或状态机错误\n");
                        exit(1);
                    }
                } else {
                    stuck_count = 0;
                }
                
                last_pc = pc;
                last_debug_cycle = cycle_count;
            }
        }
    }
    
    void handleInput() {
        SDL_Event event;
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) {
                exit(0);
            } else if (event.type == SDL_KEYDOWN || event.type == SDL_KEYUP) {
                bool pressed = (event.type == SDL_KEYDOWN);
                
                switch (event.key.keysym.sym) {
                    case SDLK_z:      // A
                        if (pressed) controller1 |= 0x01;
                        else controller1 &= ~0x01;
                        break;
                    case SDLK_x:      // B
                        if (pressed) controller1 |= 0x02;
                        else controller1 &= ~0x02;
                        break;
                    case SDLK_RETURN: // Start
                        if (pressed) controller1 |= 0x08;
                        else controller1 &= ~0x08;
                        break;
                    case SDLK_RSHIFT: // Select
                        if (pressed) controller1 |= 0x04;
                        else controller1 &= ~0x04;
                        break;
                    case SDLK_UP:
                        if (pressed) controller1 |= 0x10;
                        else controller1 &= ~0x10;
                        break;
                    case SDLK_DOWN:
                        if (pressed) controller1 |= 0x20;
                        else controller1 &= ~0x20;
                        break;
                    case SDLK_LEFT:
                        if (pressed) controller1 |= 0x40;
                        else controller1 &= ~0x40;
                        break;
                    case SDLK_RIGHT:
                        if (pressed) controller1 |= 0x80;
                        else controller1 &= ~0x80;
                        break;
                }
            }
        }
        
        dut->io_controller1 = controller1;
        dut->io_controller2 = controller2;
        
        // Debug: 显示控制器状态（当有按键时）
        static uint8_t last_controller1 = 0;
        if (controller1 != last_controller1) {
            printf("\n🎮 Controller1: 0x%02X ", controller1);
            if (controller1 & 0x01) printf("A ");
            if (controller1 & 0x02) printf("B ");
            if (controller1 & 0x04) printf("Select ");
            if (controller1 & 0x08) printf("Start ");
            if (controller1 & 0x10) printf("Up ");
            if (controller1 & 0x20) printf("Down ");
            if (controller1 & 0x40) printf("Left ");
            if (controller1 & 0x80) printf("Right ");
            printf("\n");
            last_controller1 = controller1;
        }
    }
    
    void updateDisplay() {
        // 只在可见区域采样像素
        uint16_t x = dut->io_pixelX;
        uint16_t y = dut->io_pixelY;
        
        // Debug: 监控 PPU 状态（每秒一次）
        static uint64_t last_debug_time = 0;
        static uint16_t last_pixelX = 0;
        static uint16_t last_pixelY = 0;
        
        if (cycle_count % 1000000 == 0) {
            printf("\n📺 PPU Status: pixelX=%d pixelY=%d vblank=%d\n", 
                   x, y, dut->io_vblank);
            
            // 调试：检查是否到达 scanline 241
            if (y >= 240) {
                printf("   ⚠️  Scanline %d, Pixel %d (need pixel=340 to advance)\n", y, x);
            }
            
            // 检查 PPU 是否在运行
            if (x == last_pixelX && y == last_pixelY) {
                printf("⚠️  PPU 可能没有运行！像素位置没有变化\n");
            }
            last_pixelX = x;
            last_pixelY = y;
        }
        
        if (x < 256 && y < 240) {
            uint8_t color = dut->io_pixelColor & 0x3F;
            framebuffer[y * 256 + x] = NES_PALETTE[color];
        }
        
        // VBlank 时更新显示
        static bool last_vblank = false;
        bool vblank = dut->io_vblank;
        
        if (vblank && !last_vblank) {
            SDL_UpdateTexture(texture, nullptr, framebuffer, 256 * sizeof(uint32_t));
            SDL_RenderClear(renderer);
            SDL_RenderCopy(renderer, texture, nullptr, nullptr);
            SDL_RenderPresent(renderer);
        }
        
        last_vblank = vblank;
    }
    
    void run() {
        std::cout << "🎮 开始仿真 (快速模式)..." << std::endl;
        std::cout << "   控制: 方向键移动, Z=A, X=B, Enter=Start, RShift=Select" << std::endl;
        std::cout << "   ⚡ 使用批量处理加速仿真" << std::endl;
        
        uint64_t frame_count = 0;
        auto start_time = std::chrono::high_resolution_clock::now();
        auto last_report_time = start_time;
        auto last_input_time = start_time;
        bool last_vblank = false;
        bool last_nmi = false;
        uint64_t nmi_count = 0;
        
        while (true) {
            // 每 16ms 处理一次输入（约 60Hz）
            auto now = std::chrono::high_resolution_clock::now();
            auto input_elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(now - last_input_time).count();
            
            if (input_elapsed >= 16) {
                handleInput();
                last_input_time = now;
            }
            
            // 批量执行多个周期
            for (int i = 0; i < 100; i++) {
                tick();
                updateDisplay();
                
                // 检测 VBlank 上升沿来计数帧
                bool vblank = dut->io_vblank;
                if (vblank && !last_vblank) {
                    frame_count++;
                }
                last_vblank = vblank;
                
                // 检测 NMI 上升沿
                bool nmi = dut->io_debug_nmi;
                if (nmi && !last_nmi) {
                    nmi_count++;
                    if (nmi_count <= 5) {
                        std::cout << "\n[NMI] Triggered at cycle " << cycle_count 
                                  << ", PC=0x" << std::hex << dut->io_debug_cpuPC << std::dec << std::endl;
                    }
                }
                last_nmi = nmi;
            }
            
            // 每秒报告一次状态
            auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(now - last_report_time).count();
            
            if (elapsed >= 1000) {
                double fps = static_cast<double>(frame_count) * 1000.0 / elapsed;
                uint16_t pc = dut->io_debug_cpuPC;
                uint8_t a = dut->io_debug_cpuA;
                uint8_t x = dut->io_debug_cpuX;
                uint8_t y = dut->io_debug_cpuY;
                
                std::cout << "\r帧: " << frame_count 
                          << " | FPS: " << std::fixed << std::setprecision(1) << fps 
                          << " | NMI: " << nmi_count
                          << " | PC: 0x" << std::hex << pc 
                          << " | A: 0x" << (int)a
                          << " | X: 0x" << (int)x
                          << " | Y: 0x" << (int)y << std::dec
                          << "     " << std::flush;
                
                frame_count = 0;
                nmi_count = 0;
                last_report_time = now;
            }
        }
    }
};

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "用法: " << argv[0] << " <rom文件> [--quiet] [--trace]" << std::endl;
        return 1;
    }
    
    // 检查参数
    for (int i = 2; i < argc; i++) {
        if (std::string(argv[i]) == "--quiet") {
            g_quiet_mode = true;
        }
        if (std::string(argv[i]) == "--trace") {
            g_trace_enabled = true;
        }
    }
    
    if (!g_quiet_mode) {
        std::cout << "🚀 NES Verilator 仿真器 (快速模式)" << std::endl;
        std::cout << "====================================" << std::endl;
        if (g_trace_enabled) {
            std::cout << "📊 VCD 追踪已启用" << std::endl;
        }
    }
    
    Verilated::commandArgs(argc, argv);
    
    VNESSystemRefactored* dut = new VNESSystemRefactored;
    
#if VM_TRACE
    VerilatedVcdC* tfp = nullptr;
    if (g_trace_enabled) {
        Verilated::traceEverOn(true);
        tfp = new VerilatedVcdC;
        dut->trace(tfp, 99);  // 追踪深度
        tfp->open("nes_trace.vcd");
        std::cout << "📝 VCD 文件: nes_trace.vcd" << std::endl;
    }
    NESEmulator emulator(dut, tfp);
#else
    NESEmulator emulator(dut);
#endif
    
    // 在 reset 期间加载 ROM
    std::cout << "🔄 保持 Reset 状态加载 ROM..." << std::endl;
    dut->reset = 1;
    dut->io_prgLoadEn = 0;
    dut->io_chrLoadEn = 0;
    dut->io_controller1 = 0;
    dut->io_controller2 = 0;
    
    // 加载 ROM
    if (!emulator.loadROM(argv[1])) {
        return 1;
    }
    
    // 额外的 reset 周期 - 让 ROM 数据稳定
    for (int i = 0; i < 50; i++) {
        dut->clock = 0;
        dut->eval();
        dut->clock = 1;
        dut->eval();
    }
    
    // 释放 reset
    dut->reset = 0;
    dut->io_prgLoadEn = 0;
    dut->io_chrLoadEn = 0;
    
    std::cout << "🔄 释放 Reset，CPU 启动中..." << std::endl;
    
    // CPU reset 序列 - 需要足够周期完成 Reset Vector 读取
    for (int i = 0; i < 50; i++) {
        dut->clock = 0;
        dut->eval();
        dut->clock = 1;
        dut->eval();
    }
    
    std::cout << "✅ CPU 已启动，PC = 0x" << std::hex << dut->io_debug_cpuPC << std::dec << std::endl;
    
    emulator.run();
    
#if VM_TRACE
    if (tfp) {
        tfp->close();
        delete tfp;
        std::cout << "📊 VCD 追踪已保存" << std::endl;
    }
#endif
    
    delete dut;
    return 0;
}
