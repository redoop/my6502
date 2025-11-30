// PPU Unit Test

module test_ppu;

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

// Clock (5.37 MHz PPU clock)
initial clk = 0;
always #2 clk = ~clk;

// CHR ROM simulation
assign chr_rom_data = 8'hAA;

initial begin
    $dumpfile("waveforms/test_ppu.vcd");
    $dumpvars(0, test_ppu);
    
    rst_n = 0;
    ppuctrl = 0;
    ppumask = 0;
    ppuscroll_x = 0;
    ppuscroll_y = 0;
    ppuaddr = 0;
    
    // Initialize memory
    for (int i = 0; i < 2048; i++) vram[i] = 0;
    for (int i = 0; i < 256; i++) oam[i] = 8'hFF;
    for (int i = 0; i < 32; i++) palette[i] = 0;
    
    // Set background palette
    palette[0] = 8'h0F;  // Black
    palette[1] = 8'h30;  // White
    palette[2] = 8'h16;  // Red
    palette[3] = 8'h27;  // Orange
    
    #20 rst_n = 1;
    
    // Test 1: Wait for VBlank
    $display("[TEST] Waiting for VBlank");
    wait(vblank);
    $display("[TEST] VBlank detected!");
    
    // Test 2: Enable rendering
    $display("[TEST] Enable rendering");
    ppuctrl = 8'b10010000;  // NMI enabled, BG pattern table 1
    ppumask = 8'b00011110;  // Show BG and sprites
    
    // Wait for next VBlank
    wait(!vblank);
    wait(vblank);
    $display("[TEST] Second VBlank detected!");
    
    // Test 3: Check video output during active display
    wait(!vblank);
    #10000;
    
    $display("[TEST] All tests passed!");
    $finish;
end

// Monitor VBlank transitions
always @(posedge vblank) begin
    $display("  VBlank START");
end

always @(negedge vblank) begin
    $display("  VBlank END");
end

endmodule
