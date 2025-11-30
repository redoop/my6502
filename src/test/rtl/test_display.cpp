#include "Vnes_system.h"
#include "verilated.h"
#include <SDL2/SDL.h>
#include <fstream>
#include <vector>

bool load_rom(const char* filename, std::vector<uint8_t>& prg_rom, std::vector<uint8_t>& chr_rom) {
    std::ifstream file(filename, std::ios::binary);
    if (!file) return false;
    
    uint8_t header[16];
    file.read((char*)header, 16);
    
    int prg_size = header[4] * 16384;
    int chr_size = header[5] * 8192;
    
    prg_rom.resize(prg_size > 0 ? prg_size : 16384);
    chr_rom.resize(8192);
    
    file.read((char*)prg_rom.data(), prg_size);
    if (chr_size > 0) {
        file.read((char*)chr_rom.data(), chr_size);
    } else {
        // 填充测试图案到CHR RAM
        for (int i = 0; i < 8192; i++) {
            chr_rom[i] = (i & 0xFF);
        }
    }
    
    return true;
}

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <rom_file>" << std::endl;
        return 1;
    }
    
    SDL_Init(SDL_INIT_VIDEO);
    SDL_Window* window = SDL_CreateWindow("NES Test", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 768, 720, 0);
    SDL_Renderer* renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    SDL_Texture* texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGB24, SDL_TEXTUREACCESS_STREAMING, 256, 240);
    
    Verilated::commandArgs(argc, argv);
    Vnes_system* dut = new Vnes_system;
    
    std::vector<uint8_t> prg_rom, chr_rom;
    if (!load_rom(argv[1], prg_rom, chr_rom)) return 1;
    
    dut->clk = 0;
    dut->rst_n = 0;
    dut->controller1 = 0;
    dut->controller2 = 0;
    dut->prg_rom_data = prg_rom[0];
    dut->chr_rom_data = chr_rom[0];
    
    for (int i = 0; i < 10; i++) {
        dut->clk = !dut->clk;
        dut->eval();
        uint32_t prg_addr = dut->prg_rom_addr % prg_rom.size();
        dut->prg_rom_data = prg_rom[prg_addr];
        uint32_t chr_addr = dut->chr_rom_addr % chr_rom.size();
        dut->chr_rom_data = chr_rom[chr_addr];
    }
    dut->rst_n = 1;
    
    uint8_t framebuffer[256 * 240 * 3];
    memset(framebuffer, 0, sizeof(framebuffer));
    
    int pixel_x = 0, pixel_y = 0;
    bool last_vsync = false;
    int frame_count = 0;
    
    // 运行10秒
    for (int frame = 0; frame < 600; frame++) {
        SDL_Event event;
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT || (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_ESCAPE)) {
                goto cleanup;
            }
        }
        
        for (int i = 0; i < 30000; i++) {
            dut->clk = !dut->clk;
            dut->eval();
            
            uint32_t prg_addr = dut->prg_rom_addr % prg_rom.size();
            dut->prg_rom_data = prg_rom[prg_addr];
            
            uint32_t chr_addr = dut->chr_rom_addr % chr_rom.size();
            dut->chr_rom_data = chr_rom[chr_addr];
            
            if (dut->clk) {
                if (dut->chr_ram_write) {
                    chr_rom[chr_addr] = dut->chr_ram_data;
                }
                
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
                    frame_count++;
                    pixel_x = 0;
                    pixel_y = 0;
                    
                    // 更新显示
                    SDL_UpdateTexture(texture, NULL, framebuffer, 256 * 3);
                    SDL_RenderClear(renderer);
                    SDL_RenderCopy(renderer, texture, NULL, NULL);
                    SDL_RenderPresent(renderer);
                }
                last_vsync = dut->video_vsync;
            }
        }
    }
    
cleanup:
    std::cout << "Total frames: " << frame_count << std::endl;
    
    delete dut;
    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    
    return 0;
}
