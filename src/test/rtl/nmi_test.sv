// NMI Test - Verify NMI interrupt handling

module nmi_test;

logic clk, rst_n;
logic [7:0] prg_rom_data, chr_rom_data;
logic [14:0] prg_rom_addr;
logic [13:0] chr_rom_addr;
logic [15:0] nmi_trigger_count;

// Simple test ROM
logic [7:0] test_rom [0:16383];

initial begin
    // Initialize ROM with test program
    for (int i = 0; i < 16384; i++) test_rom[i] = 8'hEA; // NOP
    
    // Reset vector at $FFFC-$FFFD -> $8000
    test_rom[16'h3FFC] = 8'h00;
    test_rom[16'h3FFD] = 8'h80;
    
    // NMI vector at $FFFA-$FFFB -> $8100
    test_rom[16'h3FFA] = 8'h00;
    test_rom[16'h3FFB] = 8'h81;
    
    // Main program at $8000
    test_rom[16'h0000] = 8'hA9; // LDA #$90
    test_rom[16'h0001] = 8'h90;
    test_rom[16'h0002] = 8'h8D; // STA $2000 (PPUCTRL, enable NMI)
    test_rom[16'h0003] = 8'h00;
    test_rom[16'h0004] = 8'h20;
    test_rom[16'h0005] = 8'h4C; // JMP $8005 (infinite loop)
    test_rom[16'h0006] = 8'h05;
    test_rom[16'h0007] = 8'h80;
    
    // NMI handler at $8100
    test_rom[16'h0100] = 8'hEE; // INC $0200 (increment counter)
    test_rom[16'h0101] = 8'h00;
    test_rom[16'h0102] = 8'h02;
    test_rom[16'h0103] = 8'h40; // RTI
end

// ROM interface
always_comb begin
    if (prg_rom_addr < 16384)
        prg_rom_data = test_rom[prg_rom_addr];
    else
        prg_rom_data = 8'h00;
end

assign chr_rom_data = 8'h00;

// DUT
nes_system dut (
    .clk(clk),
    .rst_n(rst_n),
    .prg_rom_data(prg_rom_data),
    .prg_rom_addr(prg_rom_addr),
    .chr_rom_data(chr_rom_data),
    .chr_rom_addr(chr_rom_addr),
    .controller1(8'h00),
    .controller2(8'h00),
    .nmi_trigger_count(nmi_trigger_count),
    .video_r(),
    .video_g(),
    .video_b(),
    .video_hsync(),
    .video_vsync(),
    .video_de(),
    .audio_l(),
    .audio_r(),
    .vram_write_count(),
    .debug_cpu_addr(),
    .debug_cpu_rw(),
    .debug_ppustatus(),
    .debug_vblank(),
    .debug_vblank_sync1(),
    .debug_vblank_sync2(),
    .debug_nmi(),
    .debug_ppuctrl()
);

// Clock generation
initial clk = 0;
always #5 clk = ~clk;

// Test sequence
initial begin
    $dumpfile("waveforms/nmi_test.vcd");
    $dumpvars(0, nmi_test);
    
    rst_n = 0;
    #100;
    rst_n = 1;
    
    // Wait for NMI to trigger (need ~330k cycles for first VBlank)
    #10000000;
    
    if (nmi_trigger_count > 0) begin
        $display("[TEST] PASS: NMI triggered %0d times", nmi_trigger_count);
    end else begin
        $display("[TEST] FAIL: NMI never triggered");
    end
    
    $finish;
end

endmodule
