#include <verilated.h>
#include "Vnes_system.h"
#include <SDL.h>
#include <fstream>
#include <iostream>
#include <queue>
#include <mutex>

#define SCREEN_WIDTH 256
#define SCREEN_HEIGHT 240
#define SCALE 3
#define AUDIO_SAMPLE_RATE 44100
#define AUDIO_BUFFER_SIZE 2048

std::queue<float> audio_queue;
std::mutex audio_mutex;

void audio_callback(void* userdata, Uint8* stream, int len) {
    float* fstream = (float*)stream;
    int samples = len / sizeof(float);
    
    std::lock_guard<std::mutex> lock(audio_mutex);
    for (int i = 0; i < samples; i++) {
        if (!audio_queue.empty()) {
            fstream[i] = audio_queue.front();
            audio_queue.pop();
        } else {
            fstream[i] = 0.0f;
        }
    }
}

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <rom_file>" << std::endl;
        return 1;
    }
    
    // Initialize SDL
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) < 0) {
        std::cerr << "SDL init failed: " << SDL_GetError() << std::endl;
        return 1;
    }
    
    // Create window
    SDL_Window* window = SDL_CreateWindow("NES Emulator with Audio",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
        SCREEN_WIDTH * SCALE, SCREEN_HEIGHT * SCALE, SDL_WINDOW_SHOWN);
    
    SDL_Renderer* renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    SDL_Texture* texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGB24,
        SDL_TEXTUREACCESS_STREAMING, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    // Setup audio
    SDL_AudioSpec want, have;
    SDL_zero(want);
    want.freq = AUDIO_SAMPLE_RATE;
    want.format = AUDIO_F32;
    want.channels = 1;
    want.samples = AUDIO_BUFFER_SIZE;
    want.callback = audio_callback;
    
    SDL_AudioDeviceID audio_device = SDL_OpenAudioDevice(NULL, 0, &want, &have, 0);
    if (audio_device == 0) {
        std::cerr << "Failed to open audio: " << SDL_GetError() << std::endl;
    } else {
        std::cout << "Audio: " << have.freq << "Hz, " << have.channels << " channel(s)" << std::endl;
        SDL_PauseAudioDevice(audio_device, 0);
    }
    
    // Load ROM
    std::ifstream rom(argv[1], std::ios::binary);
    if (!rom) {
        std::cerr << "Cannot open ROM: " << argv[1] << std::endl;
        return 1;
    }
    
    uint8_t header[16];
    rom.read((char*)header, 16);
    
    int prg_size = header[4] * 16384;
    int chr_size = header[5] * 8192;
    
    uint8_t* prg_rom = new uint8_t[prg_size];
    uint8_t* chr_rom = new uint8_t[chr_size];
    
    rom.read((char*)prg_rom, prg_size);
    rom.read((char*)chr_rom, chr_size);
    rom.close();
    
    std::cout << "ROM: PRG=" << prg_size << " CHR=" << chr_size << std::endl;
    
    // Initialize Verilator
    Verilated::commandArgs(argc, argv);
    Vnes_system* dut = new Vnes_system;
    
    // Reset
    dut->clk = 0;
    dut->rst_n = 0;
    for (int i = 0; i < 10; i++) {
        dut->clk = !dut->clk;
        dut->eval();
    }
    dut->rst_n = 1;
    
    // Frame buffer
    uint8_t framebuffer[SCREEN_HEIGHT][SCREEN_WIDTH][3];
    int pixel_x = 0, pixel_y = 0;
    bool running = true;
    uint32_t frame_count = 0;
    uint32_t last_time = SDL_GetTicks();
    
    // Audio generation (simple square wave for testing)
    int audio_cycle = 0;
    const int cycles_per_sample = 21477216 / AUDIO_SAMPLE_RATE / 2; // NES master clock / sample rate / 2 clocks per cycle
    
    while (running && !Verilated::gotFinish()) {
        // Handle events
        SDL_Event event;
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) {
                running = false;
            } else if (event.type == SDL_KEYDOWN) {
                if (event.key.keysym.sym == SDLK_ESCAPE) {
                    running = false;
                }
            }
        }
        
        // Run emulation
        dut->clk = !dut->clk;
        
        if (dut->clk) {
            // Provide ROM data
            if (dut->prg_rom_addr < prg_size) {
                dut->prg_rom_data = prg_rom[dut->prg_rom_addr];
            }
            if (dut->chr_rom_addr < chr_size) {
                dut->chr_rom_data = chr_rom[dut->chr_rom_addr];
            }
            
            // Capture pixel
            if (dut->video_de && pixel_y < SCREEN_HEIGHT && pixel_x < SCREEN_WIDTH) {
                framebuffer[pixel_y][pixel_x][0] = dut->video_r;
                framebuffer[pixel_y][pixel_x][1] = dut->video_g;
                framebuffer[pixel_y][pixel_x][2] = dut->video_b;
            }
            
            if (dut->video_de) {
                pixel_x++;
                if (pixel_x >= SCREEN_WIDTH) {
                    pixel_x = 0;
                    pixel_y++;
                }
            }
            
            // Generate audio sample (simple test tone)
            audio_cycle++;
            if (audio_cycle >= cycles_per_sample) {
                audio_cycle = 0;
                
                // Generate 440Hz test tone
                static int tone_phase = 0;
                tone_phase++;
                float sample = (tone_phase % 100 < 50) ? 0.1f : -0.1f;
                
                std::lock_guard<std::mutex> lock(audio_mutex);
                if (audio_queue.size() < AUDIO_BUFFER_SIZE * 4) {
                    audio_queue.push(sample);
                }
            }
            
            // Frame complete
            static bool last_vsync = false;
            if (dut->video_vsync && !last_vsync) {
                SDL_UpdateTexture(texture, NULL, framebuffer, SCREEN_WIDTH * 3);
                SDL_RenderClear(renderer);
                SDL_RenderCopy(renderer, texture, NULL, NULL);
                SDL_RenderPresent(renderer);
                
                pixel_x = 0;
                pixel_y = 0;
                frame_count++;
                
                // FPS counter
                uint32_t current_time = SDL_GetTicks();
                if (current_time - last_time >= 1000) {
                    char title[64];
                    snprintf(title, sizeof(title), "NES Emulator - %d FPS | Audio: %zu samples", 
                             frame_count, audio_queue.size());
                    SDL_SetWindowTitle(window, title);
                    frame_count = 0;
                    last_time = current_time;
                }
            }
            last_vsync = dut->video_vsync;
        }
        
        dut->eval();
    }
    
    // Cleanup
    if (audio_device) {
        SDL_CloseAudioDevice(audio_device);
    }
    
    delete[] prg_rom;
    delete[] chr_rom;
    delete dut;
    
    SDL_DestroyTexture(texture);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    
    return 0;
}
