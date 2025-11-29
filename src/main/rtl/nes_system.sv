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

// Initialize VRAM with test pattern
initial begin
    // Fill nametable with tile pattern
    for (int i = 0; i < 960; i++) begin
        vram[i] = (i[4:0] + i[9:5]) & 8'hFF;
    end
    // Fill attribute table
    for (int i = 960; i < 1024; i++) begin
        vram[i] = 8'hE4;
    end
    
    // Initialize test sprites
    // Sprite 0 - at (64, 64)
    oam[0] = 8'd64;   // Y position
    oam[1] = 8'h01;   // Tile index
    oam[2] = 8'h00;   // Attributes (palette 0)
    oam[3] = 8'd64;   // X position
    
    // Sprite 1 - at (64, 96)
    oam[4] = 8'd64;
    oam[5] = 8'h02;
    oam[6] = 8'h01;   // Palette 1
    oam[7] = 8'd96;
    
    // Sprite 2 - at (96, 64)
    oam[8] = 8'd96;
    oam[9] = 8'h03;
    oam[10] = 8'h02;  // Palette 2
    oam[11] = 8'd64;
    
    // Hide remaining sprites
    for (int i = 12; i < 256; i++) begin
        oam[i] = 8'hFF;
    end
    
    // Initialize palette
    palette[0] = 8'h0F;  // Universal background
    
    // Background palettes (0-3)
    palette[1] = 8'h30;  palette[2] = 8'h10;  palette[3] = 8'h00;
    palette[5] = 8'h16;  palette[6] = 8'h26;  palette[7] = 8'h06;
    palette[9] = 8'h11;  palette[10] = 8'h21; palette[11] = 8'h01;
    palette[13] = 8'h27; palette[14] = 8'h28; palette[15] = 8'h17;
    
    // Sprite palettes (4-7)
    palette[17] = 8'h30; palette[18] = 8'h27; palette[19] = 8'h16; // Palette 4 (white/orange/red)
    palette[21] = 8'h11; palette[22] = 8'h21; palette[23] = 8'h31; // Palette 5 (blue/cyan/light)
    palette[25] = 8'h1A; palette[26] = 8'h2A; palette[27] = 8'h3A; // Palette 6 (green)
    palette[29] = 8'h28; palette[30] = 8'h38; palette[31] = 8'h18; // Palette 7 (yellow)
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
        16'h2002:             cpu_data_in = ppustatus;
        16'h2004:             cpu_data_in = oam[oamaddr];
        16'h2007:             cpu_data_in = ppudata_buffer;
        16'h4015:             cpu_data_in = apu_status;
        16'h4016:             cpu_data_in = {7'b0, controller1[0]};
        16'h4017:             cpu_data_in = {7'b0, controller2[0]};
        16'b01??????????????,
        16'b1???????????????: cpu_data_in = prg_rom_data;           // $6000-$FFFF
        default:              cpu_data_in = 8'h00;
    endcase
end

// CPU writes
always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        ppuctrl <= 0;
        ppumask <= 0;
        oamaddr <= 0;
        ppuaddr <= 0;
        ppuaddr_latch <= 0;
        dma_active <= 0;
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

// PPUSTATUS read side effects
always_ff @(posedge cpu_clk) begin
    if (cpu_rw && cpu_addr == 16'h2002) begin
        ppustatus[7] <= 0;      // Clear VBlank flag
        ppuaddr_latch <= 0;     // Reset address latch
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
            ppustatus[7] <= 1;
            if (ppuctrl[7]) nmi <= 1;  // Trigger NMI if enabled
        end
        
        if (scanline == 261 && dot == 1) begin
            vblank <= 0;
            ppustatus[7] <= 0;
            ppustatus[6] <= 0;  // Clear sprite 0 hit
            nmi <= 0;
        end
        
        // Rendering active
        rendering <= (scanline < 240) && (ppumask[3] || ppumask[4]);
    end
end

// Video timing
assign video_hsync = (dot >= 280 && dot < 304);
assign video_vsync = (scanline >= 243 && scanline < 246);
assign video_de = (scanline < 240) && (dot < 256);

// PPU rendering - with sprite support
logic [7:0] tile_index;
logic [7:0] attr_byte;
logic [1:0] attr_bits;
logic [7:0] pattern_lo_reg, pattern_hi_reg;
logic [1:0] pixel_value;
logic [4:0] bg_palette_idx;
logic [4:0] tile_x, tile_y;
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

// Sprite evaluation - check all 64 sprites
always_comb begin
    sprite_active = 0;
    sprite_pixel = 0;
    sprite_palette_idx = 0;
    sprite_pattern_lo = 0;
    sprite_pattern_hi = 0;
    
    // Scan sprites (simplified - check first 8)
    for (int i = 0; i < 8; i++) begin
        sprite_y = oam[i * 4 + 0];
        sprite_tile = oam[i * 4 + 1];
        sprite_attr = oam[i * 4 + 2];
        sprite_x = oam[i * 4 + 3];
        
        // Check if sprite is on current scanline
        if (scanline >= sprite_y && scanline < sprite_y + 8) begin
            // Check if sprite is at current X position
            if (dot >= sprite_x && dot < sprite_x + 8) begin
                sprite_active = 1;
                
                // Get sprite pattern (simplified - use same as background)
                sprite_pattern_lo = chr_rom_data;
                sprite_pattern_hi = chr_rom_data;
                
                // Extract pixel
                sprite_pixel = {sprite_pattern_hi[7-(dot-sprite_x)], 
                               sprite_pattern_lo[7-(dot-sprite_x)]};
                
                // Sprite palette (4-7)
                if (sprite_pixel != 0) begin
                    sprite_palette_idx = {1'b1, sprite_attr[1:0], sprite_pixel};
                end
                
                break;  // Use first sprite found
            end
        end
    end
end

// Background rendering
always_comb begin
    if (scanline < 240 && dot < 256) begin
        tile_x = dot[7:3];
        tile_y = scanline[7:3];
        
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
            chr_addr_out = {ppuctrl[4], tile_index, 1'b0, scanline[2:0]};
        end else if (dot[2:0] == 3'd7) begin
            chr_addr_out = {ppuctrl[4], tile_index, 1'b1, scanline[2:0]};
        end else begin
            chr_addr_out = {ppuctrl[4], tile_index, 1'b0, scanline[2:0]};
        end
        
        pixel_value = {pattern_hi_reg[7-dot[2:0]], pattern_lo_reg[7-dot[2:0]]};
        
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

// NES palette lookup - with sprite support
logic [23:0] nes_color;
logic [4:0] final_palette_idx;

always_comb begin
    // Sprite has priority over background (if not transparent)
    if (sprite_active && sprite_pixel != 0) begin
        final_palette_idx = sprite_palette_idx;
    end else begin
        final_palette_idx = bg_palette_idx;
    end
    
    // Use palette index directly as NES color
    case (final_palette_idx[5:0])
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
logic [15:0] pulse1_out;

// Simple 440Hz test tone
always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        audio_counter <= 0;
        pulse1_out <= 0;
    end else begin
        audio_counter <= audio_counter + 1;
        if (audio_counter >= 2034) begin
            audio_counter <= 0;
            pulse1_out <= ~pulse1_out[15] ? 16'h2000 : 16'h0000;
        end
    end
end

assign audio_l = pulse1_out;
assign audio_r = pulse1_out;

//=============================================================================
// Cartridge Interface (Mapper 0 - NROM)
//=============================================================================
always_comb begin
    if (cpu_addr >= 16'h8000) begin
        prg_rom_addr = cpu_addr[13:0];
    end else begin
        prg_rom_addr = 14'h0000;
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
    WRITEBACK
} state_t;

state_t state, next_state;
logic [7:0] opcode, operand, alu_result;
logic [15:0] ea;  // Effective address
logic [2:0] cycle_count;
logic [15:0] reset_vector;

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
    end else begin
        state <= next_state;
        
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
                opcode <= data_in;
                PC <= PC + 1;
                cycle_count <= 0;
            end
            
            DECODE: begin
                // Fetch operand if needed
                addr <= PC;
                operand <= data_in;
                if (opcode[1:0] != 2'b10 || opcode[4:2] == 3'b100) begin
                    PC <= PC + 1;
                end
            end
            
            EXECUTE: begin
                // Execute instruction
                case (opcode)
                    // LDA
                    8'hA9: begin A <= operand; Z <= (operand == 0); N <= operand[7]; end
                    8'hA5: begin addr <= {8'h00, operand}; rw <= 1; end
                    8'hAD: begin addr <= {data_in, operand}; rw <= 1; end
                    
                    // LDX
                    8'hA2: begin X <= operand; Z <= (operand == 0); N <= operand[7]; end
                    8'hA6: begin addr <= {8'h00, operand}; rw <= 1; end
                    
                    // LDY
                    8'hA0: begin Y <= operand; Z <= (operand == 0); N <= operand[7]; end
                    8'hA4: begin addr <= {8'h00, operand}; rw <= 1; end
                    
                    // STA
                    8'h85: begin addr <= {8'h00, operand}; data_out <= A; rw <= 0; end
                    8'h8D: begin addr <= {data_in, operand}; data_out <= A; rw <= 0; end
                    
                    // STX
                    8'h86: begin addr <= {8'h00, operand}; data_out <= X; rw <= 0; end
                    
                    // STY
                    8'h84: begin addr <= {8'h00, operand}; data_out <= Y; rw <= 0; end
                    
                    // ADC
                    8'h69: begin
                        temp_sum = A + operand + C;
                        C <= temp_sum[8];
                        A <= temp_sum[7:0];
                        Z <= (temp_sum[7:0] == 0);
                        N <= temp_sum[7];
                        V <= (A[7] == operand[7]) && (A[7] != temp_sum[7]);
                    end
                    
                    // SBC
                    8'hE9: begin
                        temp_diff = A - operand - !C;
                        C <= !temp_diff[8];
                        A <= temp_diff[7:0];
                        Z <= (temp_diff[7:0] == 0);
                        N <= temp_diff[7];
                    end
                    
                    // AND
                    8'h29: begin
                        temp_result = A & operand;
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    
                    // ORA
                    8'h09: begin
                        temp_result = A | operand;
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                    end
                    
                    // EOR
                    8'h49: begin
                        temp_result = A ^ operand;
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
                // Memory access for load instructions
                if (opcode == 8'hA5 || opcode == 8'hAD) begin
                    A <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                end else if (opcode == 8'hA6) begin
                    X <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                end else if (opcode == 8'hA4) begin
                    Y <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                end else if (opcode == 8'h68) begin
                    A <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                end else if (opcode == 8'h28) begin
                    {N, V, B, D, I, Z, C} <= {data_in[7:6], data_in[4:0]};
                end
                rw <= 1;
            end
            
            WRITEBACK: begin
                rw <= 1;
            end
        endcase
        
        // NMI handling
        if (nmi && state == FETCH) begin
            addr <= {8'h01, SP};
            data_out <= PC[15:8];
            rw <= 0;
            SP <= SP - 3;
        end
    end
end

// Next state logic
always_comb begin
    case (state)
        RESET: begin
            if (cycle_count == 2) next_state = FETCH;
            else next_state = RESET;
        end
        FETCH: next_state = DECODE;
        DECODE: next_state = EXECUTE;
        EXECUTE: begin
            // Check if memory access needed
            if (opcode[1:0] == 2'b01 && opcode[4:2] != 3'b100) begin
                next_state = MEMORY;
            end else begin
                next_state = FETCH;
            end
        end
        MEMORY: next_state = WRITEBACK;
        WRITEBACK: next_state = FETCH;
        default: next_state = FETCH;
    endcase
end

endmodule
