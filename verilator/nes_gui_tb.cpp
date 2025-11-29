#include <verilated.h>
#include "Vnes_system.h"
#include <SDL.h>
#include <iostream>
#include <fstream>
#include <vector>

struct iNESHeader {
    char magic[4];
    uint8_t prg_rom_size;
    uint8_t chr_rom_size;
    uint8_t flags6, flags7, prg_ram_size, flags9, flags10;
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
              << (int)header.chr_rom_size * 8 << "KB Mapper=" 
              << (int)((header.flags6 >> 4) | (header.flags7 & 0xF0)) << std::endl;
    
    prg_rom.resize(header.prg_rom_size * 16384);
    file.read((char*)prg_rom.data(), prg_rom.size());
    
    chr_rom.resize(header.chr_rom_size * 8192);
    file.read((char*)chr_rom.data(), chr_rom.size());
    
    return true;
}

int main(int argc, char** argv) {
    const char* rom_file = argc > 1 ? argv[1] : "../games/Super-Mario-Bros.nes";
    
    if (!load_rom(rom_file)) {
        std::cerr << "Failed to load ROM" << std::endl;
        return 1;
    }
    
    // Init SDL
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) < 0) {
        std::cerr << "SDL init failed: " << SDL_GetError() << std::endl;
        return 1;
    }
    
    // Setup audio
    SDL_AudioSpec want, have;
    SDL_zero(want);
    want.freq = 44100;
    want.format = AUDIO_S16SYS;
    want.channels = 2;
    want.samples = 512;
    want.callback = NULL;
    
    SDL_AudioDeviceID audio_dev = SDL_OpenAudioDevice(NULL, 0, &want, &have, 0);
    if (audio_dev == 0) {
        std::cerr << "Failed to open audio: " << SDL_GetError() << std::endl;
    } else {
        SDL_PauseAudioDevice(audio_dev, 0);
        std::cout << "Audio: " << have.freq << "Hz " << (int)have.channels << "ch" << std::endl;
    }
    
    SDL_Window* window = SDL_CreateWindow("NES Emulator - Super Mario Bros",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 512, 480, 0);
    
    SDL_Renderer* renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    SDL_Texture* texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGB888,
        SDL_TEXTUREACCESS_STREAMING, 256, 240);
    
    uint32_t pixels[256 * 240];
    int16_t audio_buffer[2048];
    int audio_pos = 0;
    
    Verilated::commandArgs(argc, argv);
    Vnes_system* top = new Vnes_system;
    
    top->clk = 0;
    top->rst_n = 0;
    top->controller1 = 0;
    top->controller2 = 0;
    
    bool running = true;
    uint64_t cycle = 0;
    int frame = 0;
    uint8_t controller = 0;
    
    std::cout << "Starting emulation... Press ESC to quit" << std::endl;
    std::cout << "Controls: Arrow keys=D-Pad, Z=A, X=B, Enter=Start, RShift=Select" << std::endl;
    
    while (running) {
        // Handle events
        SDL_Event event;
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT || 
                (event.type == SDL_KEYDOWN && event.key.keysym.sym == SDLK_ESCAPE)) {
                running = false;
            }
        }
        
        // Read keyboard state (NES controller: A B Select Start Up Down Left Right)
        const uint8_t* keys = SDL_GetKeyboardState(NULL);
        controller = 0;
        if (keys[SDL_SCANCODE_Z])      controller |= 0x01; // A
        if (keys[SDL_SCANCODE_X])      controller |= 0x02; // B
        if (keys[SDL_SCANCODE_RSHIFT]) controller |= 0x04; // Select
        if (keys[SDL_SCANCODE_RETURN]) controller |= 0x08; // Start
        if (keys[SDL_SCANCODE_UP])     controller |= 0x10; // Up
        if (keys[SDL_SCANCODE_DOWN])   controller |= 0x20; // Down
        if (keys[SDL_SCANCODE_LEFT])   controller |= 0x40; // Left
        if (keys[SDL_SCANCODE_RIGHT])  controller |= 0x80; // Right
        
        top->controller1 = controller;
        
        // Run simulation for one frame (~30K cycles)
        for (int i = 0; i < 30000; i++) {
            if (cycle == 10) top->rst_n = 1;
            
            // Provide ROM data
            top->prg_rom_data = (top->prg_rom_addr < prg_rom.size()) ? 
                prg_rom[top->prg_rom_addr] : 0xFF;
            top->chr_rom_data = (top->chr_rom_addr < chr_rom.size()) ? 
                chr_rom[top->chr_rom_addr] : 0;
            
            // Clock
            top->clk = 0;
            top->eval();
            top->clk = 1;
            top->eval();
            
            // Capture pixel
            if (top->video_de) {
                int x = (cycle / 3) % 256;
                int y = (cycle / 3) / 341;
                if (x < 256 && y < 240) {
                    pixels[y * 256 + x] = (top->video_r << 16) | 
                                          (top->video_g << 8) | 
                                          top->video_b;
                }
            }
            
            // Capture audio (every ~40 cycles = 44.1kHz)
            if (cycle % 40 == 0 && audio_pos < 2046) {
                audio_buffer[audio_pos++] = top->audio_l;
                audio_buffer[audio_pos++] = top->audio_r;
            }
            
            cycle++;
        }
        
        // Queue audio
        if (audio_dev && audio_pos > 0) {
            SDL_QueueAudio(audio_dev, audio_buffer, audio_pos * sizeof(int16_t));
            audio_pos = 0;
        }
        
        // Update display
        SDL_UpdateTexture(texture, NULL, pixels, 256 * 4);
        SDL_RenderClear(renderer);
        SDL_RenderCopy(renderer, texture, NULL, NULL);
        SDL_RenderPresent(renderer);
        
        frame++;
        if (frame % 60 == 0) {
            std::cout << "Frame " << frame 
                      << " Cycle " << cycle
                      << " PRG=0x" << std::hex << (int)top->prg_rom_addr 
                      << " CHR=0x" << (int)top->chr_rom_addr
                      << std::dec;
            if (controller) {
                std::cout << " Input:";
                if (controller & 0x80) std::cout << "R";
                if (controller & 0x40) std::cout << "L";
                if (controller & 0x20) std::cout << "D";
                if (controller & 0x10) std::cout << "U";
                if (controller & 0x08) std::cout << "S";
                if (controller & 0x04) std::cout << "s";
                if (controller & 0x02) std::cout << "B";
                if (controller & 0x01) std::cout << "A";
            }
            std::cout << std::endl;
        }
        
        SDL_Delay(16); // ~60 FPS
    }
    
    delete top;
    if (audio_dev) SDL_CloseAudioDevice(audio_dev);
    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    
    return 0;
}
