// NES 系统 Verilator Testbench - 快速版本
// 优化性能，跳过不必要的周期

#include <verilated.h>
#include "VNESSystem.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <cstdint>
#include <chrono>
#include <iomanip>
#include <SDL.h>

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
private:
    VNESSystem* dut;
    uint64_t cycle_count;
    
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
    NESEmulator(VNESSystem* dut_ptr) : dut(dut_ptr), cycle_count(0), render_skip(0) {
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
            SDL_WINDOW_SHOWN
        );
        
        if (!window) {
            std::cerr << "窗口创建失败: " << SDL_GetError() << std::endl;
            exit(1);
        }
        
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
        
        std::cout << "✅ SDL 初始化完成 (快速模式)" << std::endl;
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
        
        std::cout << "📦 加载 ROM:" << std::endl;
        std::cout << "   PRG ROM: " << prg_size << " 字节" << std::endl;
        std::cout << "   CHR ROM: " << chr_size << " 字节" << std::endl;
        
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
        std::cout << "⬆️  加载 ROM 到硬件..." << std::endl;
        
        // 加载 PRG ROM
        size_t prg_offset = 0;
        if (prg_rom.size() > 32768) {
            prg_offset = prg_rom.size() - 32768;
        }
        
        dut->io_romLoadPRG = 1;
        for (size_t i = 0; i < 32768 && (prg_offset + i) < prg_rom.size(); i++) {
            dut->io_romLoadEn = 1;
            dut->io_romLoadAddr = i;
            dut->io_romLoadData = prg_rom[prg_offset + i];
            tick();
            
            if (i % 4096 == 0) {
                std::cout << "\r   PRG: " << (i * 100 / 32768) << "%" << std::flush;
            }
        }
        std::cout << "\r   PRG: 100%" << std::endl;
        
        // 加载 CHR ROM
        if (!chr_rom.empty()) {
            dut->io_romLoadPRG = 0;
            for (size_t i = 0; i < chr_rom.size() && i < 8192; i++) {
                dut->io_romLoadEn = 1;
                dut->io_romLoadAddr = i;
                dut->io_romLoadData = chr_rom[i];
                tick();
                
                if (i % 2048 == 0) {
                    std::cout << "\r   CHR: " << (i * 100 / std::min(chr_rom.size(), (size_t)8192)) << "%" << std::flush;
                }
            }
            std::cout << "\r   CHR: 100%" << std::endl;
        }
        
        dut->io_romLoadEn = 0;
        std::cout << "✅ ROM 加载完成" << std::endl;
    }
    
    void tick() {
        dut->clock = 0;
        dut->eval();
        cycle_count++;
        
        dut->clock = 1;
        dut->eval();
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
    }
    
    void updateDisplay() {
        // 只在可见区域采样像素
        uint16_t x = dut->io_pixelX;
        uint16_t y = dut->io_pixelY;
        
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
            }
            
            // 每秒报告一次状态
            auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(now - last_report_time).count();
            
            if (elapsed >= 1000) {
                double fps = static_cast<double>(frame_count) * 1000.0 / elapsed;
                uint16_t pc = dut->io_debug_regPC;
                uint8_t a = dut->io_debug_regA;
                uint8_t x = dut->io_debug_regX;
                uint8_t y = dut->io_debug_regY;
                uint8_t sp = dut->io_debug_regSP;
                
                std::cout << "\r帧: " << frame_count 
                          << " | FPS: " << std::fixed << std::setprecision(1) << fps 
                          << " | PC: 0x" << std::hex << pc 
                          << " | A: 0x" << (int)a
                          << " | X: 0x" << (int)x
                          << " | Y: 0x" << (int)y
                          << " | SP: 0x" << (int)sp << std::dec
                          << "     " << std::flush;
                
                frame_count = 0;
                last_report_time = now;
            }
        }
    }
};

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "用法: " << argv[0] << " <rom文件>" << std::endl;
        return 1;
    }
    
    std::cout << "🚀 NES Verilator 仿真器 (快速模式)" << std::endl;
    std::cout << "====================================" << std::endl;
    
    Verilated::commandArgs(argc, argv);
    
    VNESSystem* dut = new VNESSystem;
    NESEmulator emulator(dut);
    
    // 在 reset 期间加载 ROM
    std::cout << "🔄 保持 Reset 状态加载 ROM..." << std::endl;
    dut->reset = 1;
    dut->io_romLoadEn = 0;
    dut->io_controller1 = 0;
    dut->io_controller2 = 0;
    
    // 加载 ROM
    if (!emulator.loadROM(argv[1])) {
        return 1;
    }
    
    // 额外的 reset 周期
    for (int i = 0; i < 10; i++) {
        dut->clock = 0;
        dut->eval();
        dut->clock = 1;
        dut->eval();
    }
    
    // 释放 reset
    dut->reset = 0;
    dut->io_romLoadEn = 0;
    
    std::cout << "🔄 释放 Reset，CPU 启动中..." << std::endl;
    
    // CPU reset 序列
    for (int i = 0; i < 20; i++) {
        dut->clock = 0;
        dut->eval();
        dut->clock = 1;
        dut->eval();
    }
    
    std::cout << "✅ CPU 已启动，PC = 0x" << std::hex << dut->io_debug_regPC << std::dec << std::endl;
    
    emulator.run();
    
    delete dut;
    return 0;
}
