// NES PPU (Picture Processing Unit)
// Handles video rendering, sprites, and timing

module nes_ppu (
    input  logic        clk,
    input  logic        rst_n,
    
    // PPU registers
    input  logic [7:0]  ppuctrl,
    input  logic [7:0]  ppumask,
    input  logic [7:0]  ppuscroll_x,
    input  logic [7:0]  ppuscroll_y,
    input  logic [15:0] ppuaddr,
    
    // Memory
    input  logic [7:0]  vram[0:2047],
    input  logic [7:0]  oam[0:255],
    input  logic [7:0]  palette[0:31],
    input  logic [7:0]  chr_rom_data,
    output logic [13:0] chr_rom_addr,
    
    // Video output
    output logic [7:0]  video_r,
    output logic [7:0]  video_g,
    output logic [7:0]  video_b,
    output logic        video_hsync,
    output logic        video_vsync,
    output logic        video_de,
    
    // Status
    output logic        vblank,
    output logic        sprite0_hit,
    output logic        rendering
);

// Timing
logic [8:0] scanline;
logic [8:0] dot;
logic ppu_initialized = 0;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        scanline <= 0;
        dot <= 0;
        vblank <= 0;
        sprite0_hit <= 0;
        ppu_initialized <= 0;
    end else begin
        if (!ppu_initialized) begin
            $display("[PPU] First clock cycle");
            ppu_initialized <= 1;
        end
        
        if (dot == 340) begin
            dot <= 0;
            if (scanline == 261) begin
                scanline <= 0;
                $display("[PPU] Frame complete, reset to scanline 0");
            end else begin
                scanline <= scanline + 1;
            end
        end else begin
            dot <= dot + 1;
        end
        
        if (scanline == 241 && dot == 1) begin
            vblank <= 1;
            $display("[PPU] VBlank START at scanline=%d dot=%d", scanline, dot);
        end
        
        if (scanline == 261 && dot == 1) begin
            vblank <= 0;
            $display("[PPU] VBlank END at scanline=%d dot=%d", scanline, dot);
        end
        
        // Force rendering enabled for testing
        rendering <= (scanline < 240);
    end
end

assign video_hsync = (dot >= 280 && dot < 304);
assign video_vsync = (scanline >= 243 && scanline < 246);
assign video_de = (scanline < 240) && (dot < 256);

// Pattern cache - use direct CHR ROM access
logic [7:0] pattern_lo_data;
logic [7:0] pattern_hi_data;

// Store last fetched data
always_ff @(posedge clk) begin
    // Always capture CHR ROM data
    pattern_lo_data <= chr_rom_data;
    pattern_hi_data <= chr_rom_data;
end

// Sprite rendering
logic [7:0] sprite_y[0:7], sprite_tile[0:7], sprite_attr[0:7], sprite_x[0:7];
logic sprite_hit[0:7];
logic [1:0] sprite_pixel;
logic [4:0] sprite_palette_idx;
logic sprite_active;

genvar i;
generate
    for (i = 0; i < 8; i++) begin : sprite_check
        assign sprite_y[i] = oam[i * 4 + 0];
        assign sprite_tile[i] = oam[i * 4 + 1];
        assign sprite_attr[i] = oam[i * 4 + 2];
        assign sprite_x[i] = oam[i * 4 + 3];
        assign sprite_hit[i] = (sprite_y[i] < 8'hEF) && 
                               (scanline >= {1'b0, sprite_y[i]}) && (scanline < ({1'b0, sprite_y[i]} + 9'd8)) &&
                               (dot >= {1'b0, sprite_x[i]}) && (dot < ({1'b0, sprite_x[i]} + 9'd8));
    end
endgenerate

always_comb begin
    sprite_active = sprite_hit[0] | sprite_hit[1] | sprite_hit[2] | sprite_hit[3] | 
                    sprite_hit[4] | sprite_hit[5] | sprite_hit[6] | sprite_hit[7];
    sprite_pixel = 2'b0;
    sprite_palette_idx = 5'b0;
    
    if (sprite_hit[0]) begin
        sprite_pixel = {chr_rom_data[7-(dot-sprite_x[0])], chr_rom_data[7-(dot-sprite_x[0])]};
        if (sprite_pixel != 0) sprite_palette_idx = {1'b1, sprite_attr[0][1:0], sprite_pixel};
    end else if (sprite_hit[1]) begin
        sprite_pixel = {chr_rom_data[7-(dot-sprite_x[1])], chr_rom_data[7-(dot-sprite_x[1])]};
        if (sprite_pixel != 0) sprite_palette_idx = {1'b1, sprite_attr[1][1:0], sprite_pixel};
    end else if (sprite_hit[2]) begin
        sprite_pixel = {chr_rom_data[7-(dot-sprite_x[2])], chr_rom_data[7-(dot-sprite_x[2])]};
        if (sprite_pixel != 0) sprite_palette_idx = {1'b1, sprite_attr[2][1:0], sprite_pixel};
    end else if (sprite_hit[3]) begin
        sprite_pixel = {chr_rom_data[7-(dot-sprite_x[3])], chr_rom_data[7-(dot-sprite_x[3])]};
        if (sprite_pixel != 0) sprite_palette_idx = {1'b1, sprite_attr[3][1:0], sprite_pixel};
    end else if (sprite_hit[4]) begin
        sprite_pixel = {chr_rom_data[7-(dot-sprite_x[4])], chr_rom_data[7-(dot-sprite_x[4])]};
        if (sprite_pixel != 0) sprite_palette_idx = {1'b1, sprite_attr[4][1:0], sprite_pixel};
    end else if (sprite_hit[5]) begin
        sprite_pixel = {chr_rom_data[7-(dot-sprite_x[5])], chr_rom_data[7-(dot-sprite_x[5])]};
        if (sprite_pixel != 0) sprite_palette_idx = {1'b1, sprite_attr[5][1:0], sprite_pixel};
    end else if (sprite_hit[6]) begin
        sprite_pixel = {chr_rom_data[7-(dot-sprite_x[6])], chr_rom_data[7-(dot-sprite_x[6])]};
        if (sprite_pixel != 0) sprite_palette_idx = {1'b1, sprite_attr[6][1:0], sprite_pixel};
    end else if (sprite_hit[7]) begin
        sprite_pixel = {chr_rom_data[7-(dot-sprite_x[7])], chr_rom_data[7-(dot-sprite_x[7])]};
        if (sprite_pixel != 0) sprite_palette_idx = {1'b1, sprite_attr[7][1:0], sprite_pixel};
    end
end

// Background rendering
logic [7:0] tile_index;
logic [7:0] attr_byte;
logic [1:0] attr_bits;
logic [1:0] pixel_value;
logic [4:0] bg_palette_idx;
logic [4:0] tile_x, tile_y;
logic [8:0] scroll_x, scroll_y;
logic [9:0] attr_addr;

always_comb begin
    if (scanline < 240 && dot < 256) begin
        scroll_x = dot + ppuscroll_x;
        scroll_y = scanline + ppuscroll_y;
        
        tile_x = scroll_x[7:3] & 5'h1F;
        tile_y = scroll_y[7:3] & 5'h1F;
        
        tile_index = vram[{tile_y, tile_x}];
        
        attr_addr = 10'h3C0 | {tile_y[4:2], tile_x[4:2]};
        attr_byte = vram[attr_addr];
        attr_bits = attr_byte[{tile_y[1], tile_x[1], 1'b1} -: 2];
        
        chr_rom_addr = dot[2:0] == 3'd7 ? 
                       {ppuctrl[4], tile_index, 1'b1, scroll_y[2:0]} :
                       {ppuctrl[4], tile_index, 1'b0, scroll_y[2:0]};
        
        // Simplified pixel extraction for debugging
        pixel_value = {pattern_hi_data[7-dot[2:0]], pattern_lo_data[7-dot[2:0]]};
        
        bg_palette_idx = pixel_value == 0 ? 5'h00 : {1'b0, attr_bits, pixel_value};
    end else begin
        chr_rom_addr = ppuaddr[13:0];
        bg_palette_idx = 5'h00;
    end
end

// Palette lookup
logic [23:0] nes_color;
logic [4:0] final_palette_idx;
logic [7:0] palette_color;

always_comb begin
    if (sprite_active && sprite_pixel != 0) final_palette_idx = sprite_palette_idx;
    else final_palette_idx = bg_palette_idx;
    
    palette_color = palette[final_palette_idx];
    
    case (palette_color[5:0])
        6'h00: nes_color = 24'h545454; 6'h01: nes_color = 24'h001E74;
        6'h02: nes_color = 24'h081090; 6'h03: nes_color = 24'h300088;
        6'h04: nes_color = 24'h440064; 6'h05: nes_color = 24'h5C0030;
        6'h06: nes_color = 24'h540400; 6'h07: nes_color = 24'h3C1800;
        6'h08: nes_color = 24'h202A00; 6'h09: nes_color = 24'h083A00;
        6'h0A: nes_color = 24'h004000; 6'h0B: nes_color = 24'h003C22;
        6'h0C: nes_color = 24'h00325D; 6'h0D: nes_color = 24'h000000;
        6'h0E: nes_color = 24'h000000; 6'h0F: nes_color = 24'h000000;
        6'h10: nes_color = 24'h989698; 6'h11: nes_color = 24'h084CC4;
        6'h12: nes_color = 24'h3032EC; 6'h13: nes_color = 24'h5C1EE4;
        6'h14: nes_color = 24'h8814B0; 6'h15: nes_color = 24'hA01464;
        6'h16: nes_color = 24'h982220; 6'h17: nes_color = 24'h783C00;
        6'h18: nes_color = 24'h545A00; 6'h19: nes_color = 24'h287200;
        6'h1A: nes_color = 24'h087C00; 6'h1B: nes_color = 24'h007628;
        6'h1C: nes_color = 24'h006678; 6'h1D: nes_color = 24'h000000;
        6'h1E: nes_color = 24'h000000; 6'h1F: nes_color = 24'h000000;
        6'h20: nes_color = 24'hECEEEC; 6'h21: nes_color = 24'h4C9AEC;
        6'h22: nes_color = 24'h787CEC; 6'h23: nes_color = 24'hB062EC;
        6'h24: nes_color = 24'hE454EC; 6'h25: nes_color = 24'hEC58B4;
        6'h26: nes_color = 24'hEC6A64; 6'h27: nes_color = 24'hD48820;
        6'h28: nes_color = 24'hA0AA00; 6'h29: nes_color = 24'h74C400;
        6'h2A: nes_color = 24'h4CD020; 6'h2B: nes_color = 24'h38CC6C;
        6'h2C: nes_color = 24'h38B4CC; 6'h2D: nes_color = 24'h3C3C3C;
        6'h2E: nes_color = 24'h000000; 6'h2F: nes_color = 24'h000000;
        6'h30: nes_color = 24'hECEEEC; 6'h31: nes_color = 24'hA8CCEC;
        6'h32: nes_color = 24'hBCBCEC; 6'h33: nes_color = 24'hD4B2EC;
        6'h34: nes_color = 24'hECAEEC; 6'h35: nes_color = 24'hECAED4;
        6'h36: nes_color = 24'hECB4B0; 6'h37: nes_color = 24'hE4C490;
        6'h38: nes_color = 24'hCCD278; 6'h39: nes_color = 24'hB4DE78;
        6'h3A: nes_color = 24'hA8E290; 6'h3B: nes_color = 24'h98E2B4;
        6'h3C: nes_color = 24'hA0D6E4; 6'h3D: nes_color = 24'hA0A2A0;
        6'h3E: nes_color = 24'h000000; 6'h3F: nes_color = 24'h000000;
        default: nes_color = 24'h000000;
    endcase
end

// Video output
always_comb begin
    if (scanline < 240 && dot < 256) begin
        // Checkerboard pattern
        if ((scanline[3] ^ dot[3]) == 1'b1) begin
            video_r = 8'hFF;
            video_g = 8'hFF;
            video_b = 8'hFF;
        end else begin
            video_r = 8'h00;
            video_g = 8'h00;
            video_b = 8'h00;
        end
    end else begin
        video_r = 8'h00;
        video_g = 8'h00;
        video_b = 8'h00;
    end
end

endmodule
