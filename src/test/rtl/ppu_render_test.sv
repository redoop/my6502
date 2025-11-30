// PPU Rendering Test - Verify background and sprite rendering

module ppu_render_test;

logic clk, rst_n;
logic [7:0] ppuctrl, ppumask;
logic [7:0] ppuscroll_x, ppuscroll_y;
logic [15:0] ppuaddr;
logic [7:0] vram[0:2047];
logic [7:0] oam[0:255];
logic [7:0] palette[0:31];
logic [7:0] chr_rom_data;
logic [13:0] chr_rom_addr;
logic [7:0] video_r, video_g, video_b;
logic video_hsync, video_vsync, video_de;
logic vblank, sprite0_hit, rendering;

// Simple CHR ROM (checkerboard pattern)
logic [7:0] chr_rom[0:8191];

initial begin
    // Initialize CHR ROM with test pattern
    for (int i = 0; i < 8192; i++) chr_rom[i] = 8'h00;
    
    // Tile 0: Solid color
    for (int i = 0; i < 8; i++) begin
        chr_rom[i] = 8'hFF;      // Plane 0
        chr_rom[i+8] = 8'hFF;    // Plane 1
    end
    
    // Tile 1: Checkerboard
    for (int i = 0; i < 8; i++) begin
        chr_rom[16+i] = 8'hAA;   // Plane 0
        chr_rom[24+i] = 8'h55;   // Plane 1
    end
    
    // Initialize VRAM with tile pattern
    for (int i = 0; i < 2048; i++) vram[i] = (i % 2);
    
    // Initialize palette
    palette[0] = 8'h0F;  // Background color (black)
    palette[1] = 8'h30;  // BG palette 0, color 1 (white)
    palette[2] = 8'h16;  // BG palette 0, color 2 (red)
    palette[3] = 8'h27;  // BG palette 0, color 3 (orange)
    
    // Initialize OAM (no sprites)
    for (int i = 0; i < 256; i++) oam[i] = 8'hFF;
end

// CHR ROM interface
assign chr_rom_data = chr_rom[chr_rom_addr];

// DUT
nes_ppu dut (
    .clk(clk),
    .rst_n(rst_n),
    .ppuctrl(ppuctrl),
    .ppumask(ppumask),
    .ppuscroll_x(ppuscroll_x),
    .ppuscroll_y(ppuscroll_y),
    .ppuaddr(ppuaddr),
    .vram(vram),
    .oam(oam),
    .palette(palette),
    .chr_rom_data(chr_rom_data),
    .chr_rom_addr(chr_rom_addr),
    .video_r(video_r),
    .video_g(video_g),
    .video_b(video_b),
    .video_hsync(video_hsync),
    .video_vsync(video_vsync),
    .video_de(video_de),
    .vblank(vblank),
    .sprite0_hit(sprite0_hit),
    .rendering(rendering)
);

// Clock generation (5.37 MHz PPU clock)
initial clk = 0;
always #93 clk = ~clk;  // ~5.37 MHz

// Test sequence
integer pixel_count = 0;
integer frame_count = 0;
logic prev_vblank = 0;

always @(posedge clk) begin
    prev_vblank <= vblank;
    
    if (video_de) begin
        pixel_count++;
        // Check if we're getting valid video output
        if (pixel_count == 1) begin
            $display("[TEST] First pixel: R=%02x G=%02x B=%02x", video_r, video_g, video_b);
        end
    end
    
    if (vblank && !prev_vblank) begin
        frame_count++;
        $display("[TEST] Frame %0d complete, pixels rendered: %0d", frame_count, pixel_count);
        
        if (frame_count >= 2) begin
            if (pixel_count > 60000) begin
                $display("[TEST] PASS: PPU rendered %0d pixels", pixel_count);
            end else begin
                $display("[TEST] FAIL: Only %0d pixels rendered", pixel_count);
            end
            $finish;
        end
        pixel_count = 0;
    end
end

initial begin
    $dumpfile("waveforms/ppu_render_test.vcd");
    $dumpvars(0, ppu_render_test);
    
    rst_n = 0;
    ppuctrl = 8'h90;      // NMI enabled, BG pattern table 1
    ppumask = 8'h1E;      // Show background and sprites
    ppuscroll_x = 0;
    ppuscroll_y = 0;
    ppuaddr = 0;
    
    #1000;
    rst_n = 1;
    
    // Wait for 2 frames
    #40000000;
    
    $display("[TEST] TIMEOUT");
    $finish;
end

endmodule
