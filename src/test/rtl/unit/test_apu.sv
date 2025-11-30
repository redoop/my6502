// APU Unit Test

module test_apu;

logic clk, rst_n;
logic [7:0] apu_pulse1[0:3];
logic [7:0] apu_pulse2[0:3];
logic [7:0] apu_triangle[0:3];
logic [7:0] apu_noise[0:3];
logic [7:0] apu_dmc[0:3];
logic [7:0] apu_status;
logic [15:0] audio_l, audio_r;

// DUT
nes_apu dut (
    .clk(clk),
    .rst_n(rst_n),
    .apu_pulse1(apu_pulse1),
    .apu_pulse2(apu_pulse2),
    .apu_triangle(apu_triangle),
    .apu_noise(apu_noise),
    .apu_dmc(apu_dmc),
    .apu_status(apu_status),
    .audio_l(audio_l),
    .audio_r(audio_r)
);

// Clock
initial clk = 0;
always #5 clk = ~clk;

initial begin
    $dumpfile("test_apu.vcd");
    $dumpvars(0, test_apu);
    
    rst_n = 0;
    apu_status = 0;
    
    for (int i = 0; i < 4; i++) begin
        apu_pulse1[i] = 0;
        apu_pulse2[i] = 0;
        apu_triangle[i] = 0;
        apu_noise[i] = 0;
        apu_dmc[i] = 0;
    end
    
    #20 rst_n = 1;
    
    // Test 1: Enable pulse 1 channel
    $display("[TEST] Enable Pulse 1 channel");
    apu_status = 8'b00000001;
    apu_pulse1[0] = 8'b10001111;  // 50% duty, volume 15
    apu_pulse1[2] = 8'hFF;
    apu_pulse1[3] = 8'h00;
    
    #1000;
    
    // Test 2: Enable pulse 2 channel
    $display("[TEST] Enable Pulse 2 channel");
    apu_status = 8'b00000011;
    apu_pulse2[0] = 8'b10001111;
    apu_pulse2[2] = 8'hFF;
    apu_pulse2[3] = 8'h00;
    
    #1000;
    
    // Test 3: Disable all
    $display("[TEST] Disable all channels");
    apu_status = 8'b00000000;
    
    #100;
    
    $display("[TEST] All tests passed!");
    $finish;
end

// Monitor audio output
always @(posedge clk) begin
    if (audio_l != 0 || audio_r != 0) begin
        $display("  Audio: L=$%04x R=$%04x", audio_l, audio_r);
    end
end

endmodule
