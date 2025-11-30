#include <iostream>
#include <fstream>
#include <vector>

int main() {
    std::ifstream file("../../../games/Zelda_mapper1.nes", std::ios::binary);
    uint8_t header[16];
    file.read((char*)header, 16);
    
    int prg_size = header[4] * 16384;
    std::vector<uint8_t> prg_rom(prg_size);
    file.read((char*)prg_rom.data(), prg_size);
    
    // Check address 0x1FF77 (bank 7, offset 0x3F77)
    uint32_t addr = 0x1FF77;
    std::cout << "PRG ROM size: " << prg_rom.size() << " bytes" << std::endl;
    std::cout << "Address $1FF77: $" << std::hex << (int)prg_rom[addr] << std::endl;
    std::cout << "Address $1FF76: $" << std::hex << (int)prg_rom[addr-1] << std::endl;
    std::cout << "Address $1FF78: $" << std::hex << (int)prg_rom[addr+1] << std::endl;
    
    return 0;
}
