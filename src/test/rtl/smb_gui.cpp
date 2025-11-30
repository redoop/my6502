#include <verilated.h>
#include "Vnes_system.h"
#include <SDL.h>
#include <iostream>
#include <fstream>
#include <vector>

bool load_rom(const char* filename, std::vector<uint8_t>& prg_rom, std::vector<uint8_t>& chr_rom) {
    std::ifstream file(filename, std::ios::binary);
    if (!file) {
        std::cerr << "Failed to open ROM: " << filename << std::endl;
        return false;
    }
    
    uint8_t header[16];
    file.read((char*)header, 16);
    
    if (header[0] != 'N' || header[1] != 'E' || header[2] != 'S' || header[3] != 0x1A) {
        std::cerr << "Invalid iNES header" << std::endl;
        return false;
    }
    
    int prg_size = header[4] * 16384;
    int chr_size = header[5] * 8192;
    int mapper = ((header[6] >> 4) & 0x0F) | (header[7] & 0xF0);
    
    std::cout << "PRG: " << prg_size << "B, CHR: " << chr_size << "B, Mapper: " << mapper << std::endl;
    
    prg_rom.resize(prg_size > 0 ? prg_size : 16384);
    chr_rom.resize(chr_size > 0 ? chr_size : 8192);
    
    file.read((char*)prg_rom.data(), prg_size);
    if (chr_size > 0) file.read((char*)chr_rom.data(), chr_size);
    
    return true;
}

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <rom.nes>" << std::endl;
        return 1;
    }
    
    // Initialize SDL
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        std::cerr << "SDL init failed: " << SDL_GetError() << std::endl;
        return 1;
    }
    
    SDL_Window* window = SDL_CreateWindow("NES Emulator - Super Mario Bros",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 768, 720, 0);
    if (!window) {
        std::cerr << "Window creation failed: " << SDL_GetError() << std::endl;
        return 1;
    }
    
    SDL_Renderer* renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    SDL_Texture* texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGB24,
        SDL_TEXTUREACCESS_STREAMING, 256, 240);
    
    Verilated::commandArgs(argc, argv);
    Vnes_system* dut = new Vnes_system;
    
    std::vector<uint8_t> prg_rom, chr_rom;
    if (!load_rom(argv[1], prg_rom, chr_rom)) return 1;
    
    dut->clk = 0;
    dut->rst_n = 0;
    dut->controller1 = 0;
    dut->controller2 = 0;
    
    for (int i = 0; i < 10; i++) {
        dut->clk = !dut->clk;
        dut->eval();
    }
    dut->rst_n = 1;
    
    uint8_t framebuffer[256 * 240 * 3];
    memset(framebuffer, 0, sizeof(framebuffer));
    
    uint64_t cycles = 0;
    int frames = 0;
    bool last_vsync = false;
    int pixel_x = 0, pixel_y = 0;
    bool running = true;
    
    std::cout << "Running... Press ESC to quit" << std::endl;
    
    while (running && !Verilated::gotFinish()) {
        SDL_Event event;
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT || 
                (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_ESCAPE)) {
                running = false;
            }
            // Controller input: Arrow keys + Z/X
            if (event.type == SDL_KEYDOWN || event.type == SDL_KEYUP) {
                bool pressed = (event.type == SDL_KEYDOWN);
                switch (event.key.keysym.sym) {
                    case SDLK_RIGHT: dut->controller1 = pressed ? (dut->controller1 | 0x01) : (dut->controller1 & ~0x01); break;
                    case SDLK_LEFT:  dut->controller1 = pressed ? (dut->controller1 | 0x02) : (dut->controller1 & ~0x02); break;
                    case SDLK_DOWN:  dut->controller1 = pressed ? (dut->controller1 | 0x04) : (dut->controller1 & ~0x04); break;
                    case SDLK_UP:    dut->controller1 = pressed ? (dut->controller1 | 0x08) : (dut->controller1 & ~0x08); break;
                    case SDLK_RETURN: dut->controller1 = pressed ? (dut->controller1 | 0x10) : (dut->controller1 & ~0x10); break; // START
                    case SDLK_RSHIFT: dut->controller1 = pressed ? (dut->controller1 | 0x20) : (dut->controller1 & ~0x20); break; // SELECT
                    case SDLK_z:     dut->controller1 = pressed ? (dut->controller1 | 0x40) : (dut->controller1 & ~0x40); break; // B
                    case SDLK_x:     dut->controller1 = pressed ? (dut->controller1 | 0x80) : (dut->controller1 & ~0x80); break; // A
                }
            }
        }
        
        // Run emulation for ~1 frame worth of cycles
        for (int i = 0; i < 30000; i++) {
            dut->clk = !dut->clk;
            
            if (dut->clk) {
                uint32_t prg_addr = dut->prg_rom_addr % prg_rom.size();
                dut->prg_rom_data = prg_rom[prg_addr];
                
                uint32_t chr_addr = dut->chr_rom_addr % chr_rom.size();
                dut->chr_rom_data = chr_rom[chr_addr];
                
                if (dut->video_de) {
                    int idx = (pixel_y * 256 + pixel_x) * 3;
                    if (idx >= 0 && idx < 256 * 240 * 3) {
                        framebuffer[idx + 0] = dut->video_r;
                        framebuffer[idx + 1] = dut->video_g;
                        framebuffer[idx + 2] = dut->video_b;
                    }
                    pixel_x++;
                    if (pixel_x >= 256) {
                        pixel_x = 0;
                        pixel_y++;
                    }
                }
                
                if (!dut->video_vsync && last_vsync) {
                    frames++;
                    pixel_x = 0;
                    pixel_y = 0;
                    
                    // Update display
                    SDL_UpdateTexture(texture, NULL, framebuffer, 256 * 3);
                    SDL_RenderClear(renderer);
                    SDL_RenderCopy(renderer, texture, NULL, NULL);
                    SDL_RenderPresent(renderer);
                    
                    if (frames % 60 == 0) {
                        std::cout << "Frame " << frames << std::endl;
                    }
                }
                last_vsync = dut->video_vsync;
                cycles++;
            }
            
            dut->eval();
        }
    }
    
    std::cout << "Total frames: " << frames << std::endl;
    
    delete dut;
    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    
    return 0;
}
