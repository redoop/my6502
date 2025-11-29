#include <verilated.h>
#include "VNESSystem.h"
#include <SDL.h>
#include <iostream>
#include <fstream>
#include <vector>

struct iNESHeader {
    char magic[4];
    uint8_t prg_rom_size, chr_rom_size, flags6, flags7, prg_ram_size, flags9, flags10;
    uint8_t padding[5];
};

std::vector<uint8_t> prg_rom, chr_rom;

bool load_rom(const char* filename) {
    std::ifstream file(filename, std::ios::binary);
    if (!file) return false;
    
    iNESHeader header;
    file.read((char*)&header, sizeof(header));
    if (header.magic[0] != 'N' || header.magic[1] != 'E' || 
        header.magic[2] != 'S' || header.magic[3] != 0x1A) return false;
    
    std::cout << "ROM: PRG=" << (int)header.prg_rom_size * 16 << "KB CHR=" 
              << (int)header.chr_rom_size * 8 << "KB" << std::endl;
    
    prg_rom.resize(header.prg_rom_size * 16384);
    file.read((char*)prg_rom.data(), prg_rom.size());
    chr_rom.resize(header.chr_rom_size * 8192);
    file.read((char*)chr_rom.data(), chr_rom.size());
    return true;
}

int main(int argc, char** argv) {
    const char* rom_file = argc > 1 ? argv[1] : "../games/Donkey-Kong.nes";
    
    if (!load_rom(rom_file)) {
        std::cerr << "Failed to load ROM" << std::endl;
        return 1;
    }
    
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) < 0) {
        std::cerr << "SDL init failed" << std::endl;
        return 1;
    }
    
    SDL_Window* window = SDL_CreateWindow("NES Emulator (Full)",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 512, 480, 0);
    SDL_Renderer* renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    SDL_Texture* texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGB888,
        SDL_TEXTUREACCESS_STREAMING, 256, 240);
    
    SDL_AudioSpec want = {44100, AUDIO_S16SYS, 2, 0, 512, 0, 0, NULL, NULL};
    SDL_AudioSpec have;
    SDL_AudioDeviceID audio_dev = SDL_OpenAudioDevice(NULL, 0, &want, &have, 0);
    if (audio_dev) {
        SDL_PauseAudioDevice(audio_dev, 0);
        std::cout << "Audio: " << have.freq << "Hz" << std::endl;
    }
    
    uint32_t pixels[256 * 240];
    int16_t audio_buffer[2048];
    int audio_pos = 0;
    
    Verilated::commandArgs(argc, argv);
    VNESSystem* top = new VNESSystem;
    
    top->clock = 0;
    top->reset = 1;
    
    bool running = true;
    uint64_t cycle = 0;
    int frame = 0;
    
    std::cout << "Running... ESC to quit" << std::endl;
    std::cout << "Controls: Arrows, Z=A, X=B, Enter=Start, RShift=Select" << std::endl;
    
    while (running) {
        SDL_Event event;
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT || 
                (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_ESCAPE)) {
                running = false;
            }
        }
        
        const uint8_t* keys = SDL_GetKeyboardState(NULL);
        uint8_t controller = 0;
        if (keys[SDL_SCANCODE_Z]) controller |= 0x01;
        if (keys[SDL_SCANCODE_X]) controller |= 0x02;
        if (keys[SDL_SCANCODE_RSHIFT]) controller |= 0x04;
        if (keys[SDL_SCANCODE_RETURN]) controller |= 0x08;
        if (keys[SDL_SCANCODE_UP]) controller |= 0x10;
        if (keys[SDL_SCANCODE_DOWN]) controller |= 0x20;
        if (keys[SDL_SCANCODE_LEFT]) controller |= 0x40;
        if (keys[SDL_SCANCODE_RIGHT]) controller |= 0x80;
        
        // Run one frame
        for (int i = 0; i < 30000; i++) {
            if (cycle == 10) top->reset = 0;
            
            // Clock
            top->clock = 0;
            top->eval();
            top->clock = 1;
            top->eval();
            
            cycle++;
        }
        
        // Render test pattern (NES output not yet connected)
        for (int y = 0; y < 240; y++) {
            for (int x = 0; x < 256; x++) {
                pixels[y * 256 + x] = (y << 16) | (x << 8) | 0x80;
            }
        }
        
        SDL_UpdateTexture(texture, NULL, pixels, 256 * 4);
        SDL_RenderClear(renderer);
        SDL_RenderCopy(renderer, texture, NULL, NULL);
        SDL_RenderPresent(renderer);
        
        frame++;
        if (frame % 60 == 0) {
            std::cout << "Frame " << frame << std::endl;
        }
        
        SDL_Delay(16);
    }
    
    delete top;
    if (audio_dev) SDL_CloseAudioDevice(audio_dev);
    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    
    return 0;
}
