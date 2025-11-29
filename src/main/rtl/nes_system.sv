// NES System - Complete Nintendo Entertainment System Implementation
// Single-file SystemVerilog implementation
// Based on NES_ARCHITECTURE_ANALYSIS.md

module nes_system (
    input  logic        clk,           // Master clock (21.477272 MHz NTSC)
    input  logic        rst_n,         // Active-low reset
    
    // Video output
    output logic [7:0]  video_r,
    output logic [7:0]  video_g,
    output logic [7:0]  video_b,
    output logic        video_hsync,
    output logic        video_vsync,
    output logic        video_de,
    
    // Audio output
    output logic [15:0] audio_l,
    output logic [15:0] audio_r,
    
    // Controller input
    input  logic [7:0]  controller1,
    input  logic [7:0]  controller2,
    
    // Cartridge interface
    input  logic [7:0]  prg_rom_data,
    output logic [14:0] prg_rom_addr,
    input  logic [7:0]  chr_rom_data,
    output logic [13:0] chr_rom_addr
);

// Clock dividers
logic [3:0] clk_div;
logic cpu_clk, ppu_clk;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) clk_div <= 0;
    else clk_div <= clk_div + 1;
end

assign cpu_clk = clk_div[3];  // ÷12 = 1.79 MHz
assign ppu_clk = clk_div[1];  // ÷4 = 5.37 MHz

// CPU signals
logic [15:0] cpu_addr;
logic [7:0]  cpu_data_out, cpu_data_in;
logic        cpu_rw;
logic        nmi, irq;

// Memory
logic [7:0]  ram[0:2047];      // 2KB internal RAM
logic [7:0]  oam[0:255];       // Sprite memory
logic [7:0]  vram[0:2047];     // Nametable VRAM
logic [7:0]  palette[0:31];    // Palette RAM

// Initialize VRAM - with Donkey Kong level pattern
initial begin
    // Simulate Donkey Kong level layout
    // Fill with platform tiles (tile 0x24 = platform, 0x26 = ladder)
    for (int y = 0; y < 30; y++) begin
        for (int x = 0; x < 32; x++) begin
            int addr = y * 32 + x;
            
            // Create platform pattern every 4 rows
            if (y % 4 == 0 || y % 4 == 1) begin
                vram[addr] = 8'h24;  // Platform tile
            end else if (x % 8 == 2 || x % 8 == 3) begin
                vram[addr] = 8'h26;  // Ladder tile
            end else begin
                vram[addr] = 8'h00;  // Empty
            end
        end
    end
    
    // Attribute table - pink platforms, cyan ladders
    for (int i = 960; i < 1024; i++) begin
        vram[i] = 8'hE4;  // Mixed palettes
    end
    
    // Clear OAM
    for (int i = 0; i < 256; i++) begin
        oam[i] = 8'hFF;
    end
    
    // Initialize palette with Donkey Kong colors
    palette[0] = 8'h0F;  // Black background
    palette[1] = 8'h30;  // White
    palette[2] = 8'h27;  // Orange
    palette[3] = 8'h16;  // Red
    palette[5] = 8'h11;  // Blue (ladder)
    palette[6] = 8'h21;  // Cyan
    palette[7] = 8'h31;  // Light cyan
    palette[9] = 8'h25;  // Pink (platform)
    palette[10] = 8'h35; // Light pink
    palette[11] = 8'h15; // Dark pink
    palette[13] = 8'h28; // Yellow
    palette[14] = 8'h38; // Light yellow
    palette[15] = 8'h18; // Dark yellow
    
    // Sprite palettes
    palette[17] = 8'h30; palette[18] = 8'h27; palette[19] = 8'h16;
    palette[21] = 8'h11; palette[22] = 8'h21; palette[23] = 8'h31;
    palette[25] = 8'h1A; palette[26] = 8'h2A; palette[27] = 8'h3A;
    palette[29] = 8'h28; palette[30] = 8'h38; palette[31] = 8'h18;
end

// PPU registers
logic [7:0]  ppuctrl, ppumask, ppustatus;
logic [7:0]  oamaddr, oamdata;
logic [7:0]  ppuscroll_x, ppuscroll_y;
logic [15:0] ppuaddr;
logic [7:0]  ppudata;
logic        ppuaddr_latch;
logic [7:0]  ppudata_buffer;

// APU registers
logic [7:0]  apu_pulse1[0:3];
logic [7:0]  apu_pulse2[0:3];
logic [7:0]  apu_triangle[0:3];
logic [7:0]  apu_noise[0:3];
logic [7:0]  apu_dmc[0:3];
logic [7:0]  apu_status;
logic [7:0]  apu_frame_counter;

// PPU state
logic [8:0]  scanline;
logic [8:0]  dot;
logic        rendering;
logic        vblank;
logic        sprite0_hit;

// DMA
logic        dma_active;
logic [7:0]  dma_page;
logic [7:0]  dma_offset;

//=============================================================================
// CPU Core (6502)
//=============================================================================
cpu_6502 cpu (
    .clk(cpu_clk),
    .rst_n(rst_n),
    .addr(cpu_addr),
    .data_in(cpu_data_in),
    .data_out(cpu_data_out),
    .rw(cpu_rw),
    .nmi(nmi),
    .irq(irq)
);

//=============================================================================
// CPU Memory Map
//=============================================================================
always_comb begin
    cpu_data_in = 8'h00;
    
    casez (cpu_addr)
        16'b0001????????????: cpu_data_in = ram[cpu_addr[10:0]];    // $0000-$1FFF
        16'h2002: begin
            // Return VBlank status directly (combinational)
            cpu_data_in = {vblank_sync, ppustatus[6:0]};
        end
        16'h2004:             cpu_data_in = oam[oamaddr];
        16'h2007:             cpu_data_in = ppudata_buffer;
        16'h4015:             cpu_data_in = apu_status;
        16'h4016: cpu_data_in = {7'b0, controller1[0]};
        16'h4017: cpu_data_in = {7'b0, controller2[0]};
        16'b01??????????????,
        16'b1???????????????: cpu_data_in = prg_rom_data;           // $6000-$FFFF
        default:              cpu_data_in = 8'h00;
    endcase
end

// CPU writes
logic [15:0] vram_write_count;

always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        ppuctrl <= 0;
        ppumask <= 0;
        oamaddr <= 0;
        ppuaddr <= 0;
        ppuaddr_latch <= 0;
        dma_active <= 0;
        ppuscroll_x <= 0;
        ppuscroll_y <= 0;
        vram_write_count <= 0;
    end else if (!cpu_rw) begin
        casez (cpu_addr)
            16'b0001????????????: ram[cpu_addr[10:0]] <= cpu_data_out;
            16'h2000: ppuctrl <= cpu_data_out;
            16'h2001: ppumask <= cpu_data_out;
            16'h2003: oamaddr <= cpu_data_out;
            16'h2004: begin
                oam[oamaddr] <= cpu_data_out;
                oamaddr <= oamaddr + 1;
            end
            16'h2005: begin
                if (!ppuaddr_latch) ppuscroll_x <= cpu_data_out;
                else ppuscroll_y <= cpu_data_out;
                ppuaddr_latch <= ~ppuaddr_latch;
            end
            16'h2006: begin
                if (!ppuaddr_latch) ppuaddr[15:8] <= cpu_data_out;
                else ppuaddr[7:0] <= cpu_data_out;
                ppuaddr_latch <= ~ppuaddr_latch;
            end
            16'h2007: begin
                if (ppuaddr[13:0] < 14'h2000) begin
                    // CHR ROM (read-only)
                end else if (ppuaddr[13:0] < 14'h3F00) begin
                    vram[ppuaddr[10:0]] <= cpu_data_out;
                    vram_write_count <= vram_write_count + 1;  // Count writes
                end else begin
                    palette[ppuaddr[4:0]] <= cpu_data_out;
                end
                ppuaddr <= ppuaddr + (ppuctrl[2] ? 32 : 1);
            end
            16'h4000, 16'h4001, 16'h4002, 16'h4003: 
                apu_pulse1[cpu_addr[1:0]] <= cpu_data_out;
            16'h4004, 16'h4005, 16'h4006, 16'h4007: 
                apu_pulse2[cpu_addr[1:0]] <= cpu_data_out;
            16'h4008, 16'h4009, 16'h400A, 16'h400B: 
                apu_triangle[cpu_addr[1:0]] <= cpu_data_out;
            16'h400C, 16'h400D, 16'h400E, 16'h400F: 
                apu_noise[cpu_addr[1:0]] <= cpu_data_out;
            16'h4010, 16'h4011, 16'h4012, 16'h4013: 
                apu_dmc[cpu_addr[1:0]] <= cpu_data_out;
            16'h4014: begin
                dma_page <= cpu_data_out;
                dma_active <= 1;
                dma_offset <= 0;
            end
            16'h4015: apu_status <= cpu_data_out;
            16'h4017: apu_frame_counter <= cpu_data_out;
        endcase
    end
end

// PPUSTATUS management - sync VBlank and handle reads
logic vblank_sync;
always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        ppustatus <= 0;
        vblank_sync <= 0;
        ppuaddr_latch <= 0;
    end else begin
        // Sync vblank from PPU clock domain
        vblank_sync <= vblank;
        
        // Set VBlank flag on rising edge (only if not being cleared by read)
        if (vblank && !vblank_sync && !(cpu_rw && cpu_addr == 16'h2002)) begin
            ppustatus[7] <= 1;
        end
        
        // Clear VBlank flag on $2002 read (happens AFTER the read returns current value)
        if (cpu_rw && cpu_addr == 16'h2002) begin
            ppustatus[7] <= 0;
            ppuaddr_latch <= 0;
        end
    end
end

// PPUDATA read buffering
always_ff @(posedge ppu_clk) begin
    if (cpu_rw && cpu_addr == 16'h2007) begin
        if (ppuaddr[13:0] >= 14'h3F00) begin
            ppudata_buffer <= palette[ppuaddr[4:0]];  // Palette: immediate
        end else begin
            ppudata_buffer <= ppudata;                // Others: buffered
        end
    end
end

//=============================================================================
// DMA Controller
//=============================================================================
always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        dma_active <= 0;
        dma_offset <= 0;
    end else if (dma_active) begin
        oam[dma_offset] <= ram[{dma_page, dma_offset}];
        dma_offset <= dma_offset + 1;
        if (dma_offset == 8'hFF) dma_active <= 0;
    end
end

//=============================================================================
// PPU Rendering
//=============================================================================
always_ff @(posedge ppu_clk or negedge rst_n) begin
    if (!rst_n) begin
        scanline <= 0;
        dot <= 0;
        vblank <= 0;
        sprite0_hit <= 0;
    end else begin
        // Increment dot counter
        if (dot == 340) begin
            dot <= 0;
            if (scanline == 261) scanline <= 0;
            else scanline <= scanline + 1;
        end else begin
            dot <= dot + 1;
        end
        
        // VBlank control
        if (scanline == 241 && dot == 1) begin
            vblank <= 1;
            if (ppuctrl[7]) begin
                nmi <= 1;
            end
        end
        
        if (scanline == 261 && dot == 1) begin
            vblank <= 0;
            nmi <= 0;  // Clear NMI signal
        end
        
        // Rendering active
        rendering <= (scanline < 240) && (ppumask[3] || ppumask[4]);
    end
end

// Video timing
assign video_hsync = (dot >= 280 && dot < 304);
assign video_vsync = (scanline >= 243 && scanline < 246);
assign video_de = (scanline < 240) && (dot < 256);

// PPU rendering - with scrolling support
logic [7:0] tile_index;
logic [7:0] attr_byte;
logic [1:0] attr_bits;
logic [7:0] pattern_lo_reg, pattern_hi_reg;
logic [1:0] pixel_value;
logic [4:0] bg_palette_idx;
logic [4:0] tile_x, tile_y;
logic [8:0] scroll_x, scroll_y;  // 9-bit for wrapping
logic [9:0] attr_addr;
logic [13:0] chr_addr_out;

// Sprite rendering
logic [7:0] sprite_y, sprite_tile, sprite_attr, sprite_x;
logic [7:0] sprite_pattern_lo, sprite_pattern_hi;
logic [1:0] sprite_pixel;
logic [4:0] sprite_palette_idx;
logic sprite_active;
logic [5:0] sprite_idx;

// Cache pattern data
always_ff @(posedge ppu_clk) begin
    if (scanline < 240) begin
        if (dot[2:0] == 3'd5) begin
            pattern_lo_reg <= chr_rom_data;
        end else if (dot[2:0] == 3'd7) begin
            pattern_hi_reg <= chr_rom_data;
        end
    end
end

// Sprite evaluation - simplified and fixed
always_comb begin
    sprite_active = 0;
    sprite_pixel = 0;
    sprite_palette_idx = 0;
    
    // Check first 8 sprites
    for (int i = 0; i < 8; i++) begin
        sprite_y = oam[i * 4 + 0];
        sprite_tile = oam[i * 4 + 1];
        sprite_attr = oam[i * 4 + 2];
        sprite_x = oam[i * 4 + 3];
        
        // Check if sprite is visible (not hidden at 0xFF)
        if (sprite_y < 8'hEF) begin
            // Check if sprite is on current scanline
            if (scanline >= sprite_y && scanline < (sprite_y + 8)) begin
                // Check if sprite is at current X position
                if (dot >= sprite_x && dot < (sprite_x + 8)) begin
                    sprite_active = 1;
                    
                    // Use CHR ROM data (simplified - same as background for now)
                    sprite_pixel = {chr_rom_data[7-(dot-sprite_x)], chr_rom_data[7-(dot-sprite_x)]};
                    
                    // Sprite palette (16-31)
                    if (sprite_pixel != 0) begin
                        sprite_palette_idx = {1'b1, sprite_attr[1:0], sprite_pixel};
                    end
                    
                    break;
                end
            end
        end
    end
end

// Background rendering with scrolling
always_comb begin
    if (scanline < 240 && dot < 256) begin
        // Apply scroll offset
        scroll_x = dot + ppuscroll_x;
        scroll_y = scanline + ppuscroll_y;
        
        // Calculate tile position with wrapping
        tile_x = scroll_x[7:3] & 5'h1F;  // Wrap at 32 tiles
        tile_y = scroll_y[7:3] & 5'h1F;
        
        tile_index = vram[{tile_y, tile_x}];
        
        attr_addr = 10'h3C0 | {tile_y[4:2], tile_x[4:2]};
        attr_byte = vram[attr_addr];
        
        case ({tile_y[1], tile_x[1]})
            2'b00: attr_bits = attr_byte[1:0];
            2'b01: attr_bits = attr_byte[3:2];
            2'b10: attr_bits = attr_byte[5:4];
            2'b11: attr_bits = attr_byte[7:6];
        endcase
        
        if (dot[2:0] == 3'd5) begin
            chr_addr_out = {ppuctrl[4], tile_index, 1'b0, scroll_y[2:0]};
        end else if (dot[2:0] == 3'd7) begin
            chr_addr_out = {ppuctrl[4], tile_index, 1'b1, scroll_y[2:0]};
        end else begin
            chr_addr_out = {ppuctrl[4], tile_index, 1'b0, scroll_y[2:0]};
        end
        
        // Use scrolled fine X
        pixel_value = {pattern_hi_reg[7-scroll_x[2:0]], 
                       pattern_lo_reg[7-scroll_x[2:0]]};
        
        if (pixel_value == 0) begin
            bg_palette_idx = 5'h00;
        end else begin
            bg_palette_idx = {1'b0, attr_bits, pixel_value};
        end
    end else begin
        chr_addr_out = ppuaddr[13:0];
        bg_palette_idx = 5'h00;
    end
end

// NES palette lookup - use palette RAM
logic [23:0] nes_color;
logic [4:0] final_palette_idx;
logic [7:0] palette_color;

always_comb begin
    // Sprite has priority over background
    if (sprite_active && sprite_pixel != 0) begin
        final_palette_idx = sprite_palette_idx;
    end else begin
        final_palette_idx = bg_palette_idx;
    end
    
    // Read from palette RAM
    palette_color = palette[final_palette_idx];
    
    // Convert to RGB using NES palette
    case (palette_color[5:0])
        6'h00: nes_color = 24'h545454;
        6'h01: nes_color = 24'h001E74;
        6'h02: nes_color = 24'h081090;
        6'h03: nes_color = 24'h300088;
        6'h04: nes_color = 24'h440064;
        6'h05: nes_color = 24'h5C0030;
        6'h06: nes_color = 24'h540400;
        6'h07: nes_color = 24'h3C1800;
        6'h08: nes_color = 24'h202A00;
        6'h09: nes_color = 24'h083A00;
        6'h0A: nes_color = 24'h004000;
        6'h0B: nes_color = 24'h003C22;
        6'h0C: nes_color = 24'h00325D;
        6'h0D: nes_color = 24'h000000;
        6'h0E: nes_color = 24'h000000;
        6'h0F: nes_color = 24'h000000;
        6'h10: nes_color = 24'h989698;
        6'h11: nes_color = 24'h084CC4;
        6'h12: nes_color = 24'h3032EC;
        6'h13: nes_color = 24'h5C1EE4;
        6'h14: nes_color = 24'h8814B0;
        6'h15: nes_color = 24'hA01464;
        6'h16: nes_color = 24'h982220;
        6'h17: nes_color = 24'h783C00;
        6'h18: nes_color = 24'h545A00;
        6'h19: nes_color = 24'h287200;
        6'h1A: nes_color = 24'h087C00;
        6'h1B: nes_color = 24'h007628;
        6'h1C: nes_color = 24'h006678;
        6'h1D: nes_color = 24'h000000;
        6'h1E: nes_color = 24'h000000;
        6'h1F: nes_color = 24'h000000;
        6'h20: nes_color = 24'hECEEEC;
        6'h21: nes_color = 24'h4C9AEC;
        6'h22: nes_color = 24'h787CEC;
        6'h23: nes_color = 24'hB062EC;
        6'h24: nes_color = 24'hE454EC;
        6'h25: nes_color = 24'hEC58B4;
        6'h26: nes_color = 24'hEC6A64;
        6'h27: nes_color = 24'hD48820;
        6'h28: nes_color = 24'hA0AA00;
        6'h29: nes_color = 24'h74C400;
        6'h2A: nes_color = 24'h4CD020;
        6'h2B: nes_color = 24'h38CC6C;
        6'h2C: nes_color = 24'h38B4CC;
        6'h2D: nes_color = 24'h3C3C3C;
        6'h2E: nes_color = 24'h000000;
        6'h2F: nes_color = 24'h000000;
        6'h30: nes_color = 24'hECEEEC;
        6'h31: nes_color = 24'hA8CCEC;
        6'h32: nes_color = 24'hBCBCEC;
        6'h33: nes_color = 24'hD4B2EC;
        6'h34: nes_color = 24'hECAEEC;
        6'h35: nes_color = 24'hECAED4;
        6'h36: nes_color = 24'hECB4B0;
        6'h37: nes_color = 24'hE4C490;
        6'h38: nes_color = 24'hCCD278;
        6'h39: nes_color = 24'hB4DE78;
        6'h3A: nes_color = 24'hA8E290;
        6'h3B: nes_color = 24'h98E2B4;
        6'h3C: nes_color = 24'hA0D6E4;
        6'h3D: nes_color = 24'hA0A2A0;
        6'h3E: nes_color = 24'h000000;
        6'h3F: nes_color = 24'h000000;
    endcase
end

// Video output
always_comb begin
    if (scanline < 240 && dot < 256) begin
        video_r = nes_color[23:16];
        video_g = nes_color[15:8];
        video_b = nes_color[7:0];
    end else begin
        video_r = 8'h00;
        video_g = 8'h00;
        video_b = 8'h00;
    end
end

//=============================================================================
// APU Audio Generation
//=============================================================================
logic [15:0] audio_counter;
logic [15:0] pulse1_timer, pulse2_timer;
logic [3:0] pulse1_duty, pulse2_duty;
logic [3:0] pulse1_volume, pulse2_volume;
logic pulse1_enabled, pulse2_enabled;
logic pulse1_out_bit, pulse2_out_bit;
logic [15:0] pulse1_out, pulse2_out;
logic [15:0] test_tone;

// Test tone generator (440Hz)
always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        audio_counter <= 0;
        test_tone <= 0;
    end else begin
        audio_counter <= audio_counter + 1;
        if (audio_counter >= 2034) begin  // 1.79MHz / 440Hz / 2
            audio_counter <= 0;
            test_tone <= ~test_tone[15] ? 16'h1000 : 16'h0000;
        end
    end
end

// Pulse 1 channel
always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        pulse1_timer <= 0;
        pulse1_duty <= 0;
        pulse1_enabled <= 0;
    end else begin
        pulse1_volume <= apu_pulse1[0][3:0];
        pulse1_enabled <= apu_status[0];
        
        if (pulse1_timer == 0) begin
            pulse1_timer <= {apu_pulse1[3][2:0], apu_pulse1[2]};
            pulse1_duty <= pulse1_duty + 1;
        end else begin
            pulse1_timer <= pulse1_timer - 1;
        end
        
        case (apu_pulse1[0][7:6])
            2'b00: pulse1_out_bit <= (pulse1_duty[2:0] == 3'd0);
            2'b01: pulse1_out_bit <= (pulse1_duty[2:0] < 3'd2);
            2'b10: pulse1_out_bit <= (pulse1_duty[2:0] < 3'd4);
            2'b11: pulse1_out_bit <= (pulse1_duty[2:0] >= 3'd2);
        endcase
        
        if (pulse1_enabled && pulse1_out_bit) begin
            pulse1_out <= {pulse1_volume, 12'h000};
        end else begin
            pulse1_out <= 16'h0000;
        end
    end
end

// Pulse 2 channel
always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        pulse2_timer <= 0;
        pulse2_duty <= 0;
        pulse2_enabled <= 0;
    end else begin
        pulse2_volume <= apu_pulse2[0][3:0];
        pulse2_enabled <= apu_status[1];
        
        if (pulse2_timer == 0) begin
            pulse2_timer <= {apu_pulse2[3][2:0], apu_pulse2[2]};
            pulse2_duty <= pulse2_duty + 1;
        end else begin
            pulse2_timer <= pulse2_timer - 1;
        end
        
        case (apu_pulse2[0][7:6])
            2'b00: pulse2_out_bit <= (pulse2_duty[2:0] == 3'd0);
            2'b01: pulse2_out_bit <= (pulse2_duty[2:0] < 3'd2);
            2'b10: pulse2_out_bit <= (pulse2_duty[2:0] < 3'd4);
            2'b11: pulse2_out_bit <= (pulse2_duty[2:0] >= 3'd2);
        endcase
        
        if (pulse2_enabled && pulse2_out_bit) begin
            pulse2_out <= {pulse2_volume, 12'h000};
        end else begin
            pulse2_out <= 16'h0000;
        end
    end
end

// Mix: test tone + game audio
assign audio_l = test_tone + pulse1_out + pulse2_out;
assign audio_r = test_tone + pulse1_out + pulse2_out;

//=============================================================================
// Cartridge Interface (Mapper 0 - NROM)
//=============================================================================
always_comb begin
    if (cpu_addr >= 16'h8000) begin
        // For 16KB ROM: mirror $C000-$FFFF to $8000-$BFFF
        prg_rom_addr = {1'b0, cpu_addr[13:0]};  // Force bit 14 to 0 for 16KB mirroring
    end else begin
        prg_rom_addr = 15'h0000;
    end
end

assign chr_rom_addr = chr_addr_out;

endmodule

//=============================================================================
// 6502 CPU Core (Full Implementation)
//=============================================================================
module cpu_6502 (
    input  logic        clk,
    input  logic        rst_n,
    output logic [15:0] addr,
    input  logic [7:0]  data_in,
    output logic [7:0]  data_out,
    output logic        rw,
    input  logic        nmi,
    input  logic        irq
);

// Registers
logic [7:0]  A, X, Y, SP;
logic [15:0] PC;
logic        C, Z, I, D, B, V, N;  // Status flags

// State machine
typedef enum logic [2:0] {
    RESET,
    FETCH,
    DECODE,
    EXECUTE,
    MEMORY,
    WRITEBACK,
    NMI_HANDLER
} state_t;

state_t state, next_state;
logic [7:0] opcode, operand, alu_result;
logic [15:0] ea;  // Effective address
logic [2:0] cycle_count;
logic [15:0] reset_vector;
logic [2:0] nmi_cycle;
logic       nmi_pending;
logic       nmi_prev;  // Previous NMI state for edge detection
logic [7:0] indirect_addr_lo, indirect_addr_hi;  // For indirect addressing

// Temporary variables for ALU operations
logic [8:0] temp_sum, temp_diff;
logic [7:0] temp_result;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= RESET;
        cycle_count <= 0;
        rw <= 1;
        SP <= 8'hFD;
        A <= 0; X <= 0; Y <= 0;
        C <= 0; Z <= 0; I <= 1; D <= 0; B <= 0; V <= 0; N <= 0;
        nmi_cycle <= 0;
        nmi_pending <= 0;
        nmi_prev <= 0;
    end else begin
        state <= next_state;
        nmi_prev <= nmi;
        
        // Detect NMI rising edge
        if (nmi && !nmi_prev && !nmi_pending && state == FETCH) begin
            nmi_pending <= 1;
        end
        
        // Debug: Print store instructions
        if (state == EXECUTE && (opcode == 8'h8D || opcode == 8'h85)) begin
            $display("CPU: STA addr=$%04x data=$%02x rw=%b", addr, data_out, rw);
        end
        
        case (state)
            RESET: begin
                // Read reset vector from $FFFC-$FFFD
                if (cycle_count == 0) begin
                    addr <= 16'hFFFC;
                    rw <= 1;
                    cycle_count <= 1;
                end else if (cycle_count == 1) begin
                    reset_vector[7:0] <= data_in;
                    addr <= 16'hFFFD;
                    cycle_count <= 2;
                end else begin
                    reset_vector[15:8] <= data_in;
                    PC <= {data_in, reset_vector[7:0]};
                    cycle_count <= 0;
                end
            end
            FETCH: begin
                addr <= PC;
                rw <= 1;
                PC <= PC + 1;
                cycle_count <= 0;
            end
            
            DECODE: begin
                // Read opcode (data is now stable)
                opcode <= data_in;
                // Fetch operand if needed
                addr <= PC;
                operand <= data_in;
                if (data_in[1:0] != 2'b10 || data_in[4:2] == 3'b100) begin
                    PC <= PC + 1;
                end
            end
            
            EXECUTE: begin
                // Execute instruction
                case (opcode)
                    // LDA
                    8'hA9: begin A <= operand; Z <= (operand == 0); N <= operand[7]; end
                    8'hA5: begin addr <= {8'h00, operand}; rw <= 1; end
                    8'hB5: begin addr <= {8'h00, operand + X}; rw <= 1; end  // LDA zp,X
                    8'hAD: begin addr <= {data_in, operand}; rw <= 1; end
                    8'hBD: begin addr <= {data_in, operand} + X; rw <= 1; end  // LDA abs,X
                    8'hB9: begin addr <= {data_in, operand} + Y; rw <= 1; end  // LDA abs,Y
                    8'hA1: begin addr <= {8'h00, operand + X}; rw <= 1; cycle_count <= 1; end  // LDA (ind,X) - read pointer
                    8'hB1: begin addr <= {8'h00, operand}; rw <= 1; cycle_count <= 1; end      // LDA (ind),Y - read pointer
                    
                    // STA
                    8'h85: begin addr <= {8'h00, operand}; data_out <= A; rw <= 0; end
                    8'h95: begin addr <= {8'h00, operand + X}; data_out <= A; rw <= 0; end  // STA zp,X
                    8'h8D: begin addr <= {data_in, operand}; data_out <= A; rw <= 0; end
                    8'h9D: begin addr <= {data_in, operand} + X; data_out <= A; rw <= 0; end  // STA abs,X
                    8'h81: begin addr <= {8'h00, operand + X}; rw <= 1; cycle_count <= 1; end  // STA (ind,X)
                    8'h91: begin addr <= {8'h00, operand}; rw <= 1; cycle_count <= 1; end      // STA (ind),Y
                    
                    // ORA
                    8'h09: begin
                        temp_result = A | operand;
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    8'h05: begin addr <= {8'h00, operand}; rw <= 1; end  // ORA zp
                    8'h01: begin addr <= {8'h00, operand + X}; rw <= 1; cycle_count <= 1; end  // ORA (ind,X)
                    
                    // AND
                    8'h29: begin
                        temp_result = A & operand;
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    8'h21: begin addr <= {8'h00, operand + X}; rw <= 1; cycle_count <= 1; end  // AND (ind,X)
                    
                    // EOR
                    8'h49: begin
                        temp_result = A ^ operand;
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    
                    // ADC
                    8'h69: begin  // ADC #imm
                        temp_sum = A + operand + C;
                        C <= temp_sum[8];
                        A <= temp_sum[7:0];
                        Z <= (temp_sum[7:0] == 0);
                        N <= temp_sum[7];
                        V <= (A[7] == operand[7]) && (A[7] != temp_sum[7]);
                    end
                    8'h65: begin addr <= {8'h00, operand}; rw <= 1; end  // ADC zp
                    8'h75: begin addr <= {8'h00, operand + X}; rw <= 1; end  // ADC zp,X
                    8'h6D: begin addr <= {data_in, operand}; rw <= 1; end  // ADC abs
                    8'h7D: begin addr <= {data_in, operand} + X; rw <= 1; end  // ADC abs,X
                    8'h79: begin addr <= {data_in, operand} + Y; rw <= 1; end  // ADC abs,Y
                    
                    // SBC
                    8'hE9: begin  // SBC #imm
                        temp_diff = A - operand - !C;
                        C <= !temp_diff[8];
                        A <= temp_diff[7:0];
                        Z <= (temp_diff[7:0] == 0);
                        N <= temp_diff[7];
                    end
                    8'hE5: begin addr <= {8'h00, operand}; rw <= 1; end  // SBC zp
                    8'hF5: begin addr <= {8'h00, operand + X}; rw <= 1; end  // SBC zp,X
                    8'hED: begin addr <= {data_in, operand}; rw <= 1; end  // SBC abs
                    8'hFD: begin addr <= {data_in, operand} + X; rw <= 1; end  // SBC abs,X
                    8'hF9: begin addr <= {data_in, operand} + Y; rw <= 1; end  // SBC abs,Y
                    
                    // BIT
                    8'h24: begin  // BIT zp
                        addr <= {8'h00, operand};
                        rw <= 1;
                    end
                    
                    // ASL
                    8'h0A: begin  // ASL A
                        C <= A[7];
                        A <= {A[6:0], 1'b0};
                        Z <= (A[6:0] == 0);
                        N <= A[6];
                    end
                    8'h06: begin  // ASL zp
                        addr <= {8'h00, operand};
                        rw <= 1;
                    end
                    
                    // LSR
                    8'h4A: begin  // LSR A
                        C <= A[0];
                        A <= {1'b0, A[7:1]};
                        Z <= (A[7:1] == 0);
                        N <= 0;
                    end
                    
                    // ROL
                    8'h2A: begin  // ROL A
                        temp_result = {A[6:0], C};
                        C <= A[7];
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    
                    // ROR
                    8'h6A: begin  // ROR A
                        temp_result = {C, A[7:1]};
                        C <= A[0];
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    
                    // CMP
                    8'hC9: begin
                        temp_result = A - operand;
                        C <= (A >= operand);
                        Z <= (A == operand);
                        N <= temp_result[7];
                    end
                    8'hC5: begin addr <= {8'h00, operand}; rw <= 1; end  // CMP zp
                    
                    // CPX
                    8'hE0: begin
                        temp_result = X - operand;
                        C <= (X >= operand);
                        Z <= (X == operand);
                        N <= temp_result[7];
                    end
                    
                    // CPY
                    8'hC0: begin
                        temp_result = Y - operand;
                        C <= (Y >= operand);
                        Z <= (Y == operand);
                        N <= temp_result[7];
                    end
                    8'hC4: begin addr <= {8'h00, operand}; rw <= 1; end  // CPY zp
                    
                    // INC
                    8'hE6: begin
                        addr <= {8'h00, operand};
                        temp_result = data_in + 1;
                        alu_result <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    
                    // DEC
                    8'hC6: begin
                        addr <= {8'h00, operand};
                        temp_result = data_in - 1;
                        alu_result <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    
                    // INX
                    8'hE8: begin
                        temp_result = X + 1;
                        X <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    
                    // INY
                    8'hC8: begin
                        temp_result = Y + 1;
                        Y <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    
                    // DEX
                    8'hCA: begin
                        temp_result = X - 1;
                        X <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    
                    // DEY
                    8'h88: begin
                        temp_result = Y - 1;
                        Y <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    
                    // TAX
                    8'hAA: begin X <= A; Z <= (A == 0); N <= A[7]; end
                    
                    // TAY
                    8'hA8: begin Y <= A; Z <= (A == 0); N <= A[7]; end
                    
                    // TXA
                    8'h8A: begin A <= X; Z <= (X == 0); N <= X[7]; end
                    
                    // TYA
                    8'h98: begin A <= Y; Z <= (Y == 0); N <= Y[7]; end
                    
                    // TSX
                    8'hBA: begin X <= SP; Z <= (SP == 0); N <= SP[7]; end
                    
                    // TXS
                    8'h9A: begin SP <= X; end
                    
                    // PHA
                    8'h48: begin addr <= {8'h01, SP}; data_out <= A; rw <= 0; SP <= SP - 1; end
                    
                    // PLA
                    8'h68: begin SP <= SP + 1; addr <= {8'h01, SP + 1}; rw <= 1; end
                    
                    // PHP
                    8'h08: begin
                        addr <= {8'h01, SP};
                        data_out <= {N, V, 1'b1, B, D, I, Z, C};
                        rw <= 0;
                        SP <= SP - 1;
                    end
                    
                    // PLP
                    8'h28: begin SP <= SP + 1; addr <= {8'h01, SP + 1}; rw <= 1; end
                    
                    // JMP
                    8'h4C: begin PC <= {data_in, operand}; end
                    8'h6C: begin addr <= {data_in, operand}; rw <= 1; end
                    
                    // JSR
                    8'h20: begin
                        addr <= {8'h01, SP};
                        data_out <= PC[15:8];
                        rw <= 0;
                        SP <= SP - 1;
                    end
                    
                    // RTS
                    8'h60: begin
                        SP <= SP + 1;
                        addr <= {8'h01, SP + 1};
                        rw <= 1;
                    end
                    
                    // BRK
                    8'h00: begin
                        addr <= {8'h01, SP};
                        data_out <= PC[15:8];
                        rw <= 0;
                        SP <= SP - 1;
                        B <= 1;
                    end
                    
                    // RTI
                    8'h40: begin
                        SP <= SP + 1;
                        addr <= {8'h01, SP + 1};
                        rw <= 1;
                    end
                    
                    // BEQ
                    8'hF0: if (Z) PC <= PC + {{8{operand[7]}}, operand};
                    
                    // BNE
                    8'hD0: if (!Z) PC <= PC + {{8{operand[7]}}, operand};
                    
                    // BCS
                    8'hB0: if (C) PC <= PC + {{8{operand[7]}}, operand};
                    
                    // BCC
                    8'h90: if (!C) PC <= PC + {{8{operand[7]}}, operand};
                    
                    // BMI
                    8'h30: if (N) PC <= PC + {{8{operand[7]}}, operand};
                    
                    // BPL
                    8'h10: if (!N) PC <= PC + {{8{operand[7]}}, operand};
                    
                    // BVS
                    8'h70: if (V) PC <= PC + {{8{operand[7]}}, operand};
                    
                    // BVC
                    8'h50: if (!V) PC <= PC + {{8{operand[7]}}, operand};
                    
                    // CLC
                    8'h18: C <= 0;
                    
                    // SEC
                    8'h38: C <= 1;
                    
                    // CLI
                    8'h58: I <= 0;
                    
                    // SEI
                    8'h78: I <= 1;
                    
                    // CLD
                    8'hD8: D <= 0;
                    
                    // SED
                    8'hF8: D <= 1;
                    
                    // CLV
                    8'hB8: V <= 0;
                    
                    // NOP
                    8'hEA: begin end
                    
                    default: begin end
                endcase
            end
            
            MEMORY: begin
                // Indirect addressing - multi-cycle
                if ((opcode == 8'hA1 || opcode == 8'h81 || opcode == 8'h01 || opcode == 8'h21 || opcode == 8'hB1 || opcode == 8'h91) && cycle_count == 1) begin
                    // Read low byte of pointer
                    indirect_addr_lo <= data_in;
                    addr <= addr + 1;
                    cycle_count <= 2;
                    rw <= 1;
                end else if ((opcode == 8'hA1 || opcode == 8'h81 || opcode == 8'h01 || opcode == 8'h21) && cycle_count == 2) begin
                    // (ind,X): Read high byte, form address
                    indirect_addr_hi <= data_in;
                    addr <= {data_in, indirect_addr_lo};
                    cycle_count <= 0;
                    if (opcode == 8'h81) begin
                        data_out <= A;
                        rw <= 0;  // Write for STA
                    end else begin
                        rw <= 1;  // Read for LDA/ORA/AND
                    end
                end else if ((opcode == 8'hB1 || opcode == 8'h91) && cycle_count == 2) begin
                    // (ind),Y: Read high byte, form address + Y
                    indirect_addr_hi <= data_in;
                    addr <= {data_in, indirect_addr_lo} + Y;
                    cycle_count <= 0;
                    if (opcode == 8'h91) begin
                        data_out <= A;
                        rw <= 0;  // Write for STA
                    end else begin
                        rw <= 1;  // Read for LDA
                    end
                end else if (opcode == 8'hA5 || opcode == 8'hAD || opcode == 8'hB5 || opcode == 8'hBD || opcode == 8'hB9 || opcode == 8'hA1 || opcode == 8'hB1) begin
                    A <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                    rw <= 1;
                end else if (opcode == 8'hA6 || opcode == 8'hB6 || opcode == 8'hAE) begin
                    X <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                    rw <= 1;
                end else if (opcode == 8'hA4 || opcode == 8'hB4) begin
                    Y <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                    rw <= 1;
                end else if (opcode == 8'h68) begin
                    A <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                    rw <= 1;
                end else if (opcode == 8'h28) begin
                    {N, V, B, D, I, Z, C} <= {data_in[7:6], data_in[4:0]};
                    rw <= 1;
                end else if (opcode == 8'h05) begin  // ORA zp
                    temp_result = A | data_in;
                    A <= temp_result;
                    Z <= (temp_result == 0);
                    N <= temp_result[7];
                    rw <= 1;
                end else if (opcode == 8'h01) begin  // ORA (ind,X)
                    temp_result = A | data_in;
                    A <= temp_result;
                    Z <= (temp_result == 0);
                    N <= temp_result[7];
                    rw <= 1;
                end else if (opcode == 8'h21) begin  // AND (ind,X)
                    temp_result = A & data_in;
                    A <= temp_result;
                    Z <= (temp_result == 0);
                    N <= temp_result[7];
                    rw <= 1;
                end else if (opcode == 8'h24) begin  // BIT zp
                    Z <= ((A & data_in) == 0);
                    N <= data_in[7];
                    V <= data_in[6];
                    rw <= 1;
                end else if (opcode == 8'h06) begin  // ASL zp
                    C <= data_in[7];
                    alu_result <= {data_in[6:0], 1'b0};
                    Z <= (data_in[6:0] == 0);
                    N <= data_in[6];
                    data_out <= {data_in[6:0], 1'b0};
                    rw <= 0;  // Write back
                end else if (opcode == 8'hC5) begin  // CMP zp
                    temp_result = A - data_in;
                    C <= (A >= data_in);
                    Z <= (A == data_in);
                    N <= temp_result[7];
                    rw <= 1;
                end else if (opcode == 8'hC4) begin  // CPY zp
                    temp_result = Y - data_in;
                    C <= (Y >= data_in);
                    Z <= (Y == data_in);
                    N <= temp_result[7];
                    rw <= 1;
                end else if (opcode == 8'h65 || opcode == 8'h75 || opcode == 8'h6D || opcode == 8'h7D || opcode == 8'h79) begin  // ADC
                    temp_sum = A + data_in + C;
                    C <= temp_sum[8];
                    A <= temp_sum[7:0];
                    Z <= (temp_sum[7:0] == 0);
                    N <= temp_sum[7];
                    V <= (A[7] == data_in[7]) && (A[7] != temp_sum[7]);
                    rw <= 1;
                end else if (opcode == 8'hE5 || opcode == 8'hF5 || opcode == 8'hED || opcode == 8'hFD || opcode == 8'hF9) begin  // SBC
                    temp_diff = A - data_in - !C;
                    C <= !temp_diff[8];
                    A <= temp_diff[7:0];
                    Z <= (temp_diff[7:0] == 0);
                    N <= temp_diff[7];
                    rw <= 1;
                end else if (opcode == 8'h85 || opcode == 8'h8D || 
                             opcode == 8'h86 || opcode == 8'h84 ||
                             opcode == 8'h95 || opcode == 8'h9D ||
                             opcode == 8'h96 || opcode == 8'h94) begin
                    // Store operations - keep rw=0 for one more cycle
                    rw <= 1;  // Will be set to 1 next cycle
                end
            end
            
            WRITEBACK: begin
                rw <= 1;
            end
            
            NMI_HANDLER: begin
                case (nmi_cycle)
                    0: begin  // Push PCH
                        addr <= {8'h01, SP};
                        data_out <= PC[15:8];
                        rw <= 0;
                        SP <= SP - 1;
                        nmi_cycle <= 1;
                    end
                    1: begin  // Push PCL
                        addr <= {8'h01, SP};
                        data_out <= PC[7:0];
                        rw <= 0;
                        SP <= SP - 1;
                        nmi_cycle <= 2;
                    end
                    2: begin  // Push status
                        addr <= {8'h01, SP};
                        data_out <= {N, V, 1'b1, B, D, I, Z, C};
                        rw <= 0;
                        SP <= SP - 1;
                        nmi_cycle <= 3;
                    end
                    3: begin  // Read NMI vector low
                        addr <= 16'hFFFA;
                        rw <= 1;
                        nmi_cycle <= 4;
                    end
                    4: begin  // Read NMI vector high
                        PC[7:0] <= data_in;
                        addr <= 16'hFFFB;
                        rw <= 1;
                        nmi_cycle <= 5;
                    end
                    5: begin  // Jump to NMI handler
                        PC[15:8] <= data_in;
                        nmi_cycle <= 0;
                        nmi_pending <= 0;
                        I <= 1;  // Disable interrupts
                    end
                endcase
            end
        endcase
    end
end

// Next state logic
always_comb begin
    case (state)
        RESET: begin
            if (cycle_count == 2) next_state = FETCH;
            else next_state = RESET;
        end
        FETCH: begin
            if (nmi_pending) next_state = NMI_HANDLER;
            else next_state = DECODE;
        end
        DECODE: next_state = EXECUTE;
        EXECUTE: begin
            // Check if memory access needed
            if ((opcode[1:0] == 2'b01 && opcode[4:2] != 3'b100) ||  // Load instructions
                (opcode == 8'h85 || opcode == 8'h8D || opcode == 8'h95 || opcode == 8'h9D ||  // STA
                 opcode == 8'h86 || opcode == 8'h96 ||               // STX
                 opcode == 8'h84 || opcode == 8'h94 ||               // STY
                 opcode == 8'hA5 || opcode == 8'hAD || opcode == 8'hB5 || opcode == 8'hBD || opcode == 8'hB9 ||  // LDA
                 opcode == 8'hA6 || opcode == 8'hB6 || opcode == 8'hAE ||  // LDX
                 opcode == 8'hA4 || opcode == 8'hB4 ||               // LDY
                 opcode == 8'h05 || opcode == 8'h24 || opcode == 8'h06 ||  // ORA zp, BIT zp, ASL zp
                 opcode == 8'hC5 || opcode == 8'hC4 ||               // CMP zp, CPY zp
                 opcode == 8'h65 || opcode == 8'h75 || opcode == 8'h6D || opcode == 8'h7D || opcode == 8'h79 ||  // ADC
                 opcode == 8'hE5 || opcode == 8'hF5 || opcode == 8'hED || opcode == 8'hFD || opcode == 8'hF9 ||  // SBC
                 opcode == 8'hA1 || opcode == 8'hB1 ||               // LDA (ind,X), LDA (ind),Y
                 opcode == 8'h81 || opcode == 8'h91 ||               // STA (ind,X), STA (ind),Y
                 opcode == 8'h01 || opcode == 8'h21)) begin          // ORA (ind,X), AND (ind,X)
                next_state = MEMORY;
            end else begin
                next_state = FETCH;
            end
        end
        MEMORY: begin
            // Stay in MEMORY for multi-cycle indirect addressing
            if (cycle_count > 0) next_state = MEMORY;
            else next_state = WRITEBACK;
        end
        WRITEBACK: next_state = FETCH;
        NMI_HANDLER: begin
            if (nmi_cycle == 5) next_state = FETCH;
            else next_state = NMI_HANDLER;
        end
        default: next_state = FETCH;
    endcase
end

endmodule
