// PPUSTATUS Read Test - Verify $2002 read behavior

module ppustatus_test;

logic cpu_clk, rst_n;
logic [7:0] ppustatus;
logic ppustatus_read_last;
logic vblank_sync2;
logic cpu_rw;
logic [15:0] cpu_addr;

// Simulate ppustatus logic
always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        ppustatus <= 0;
        ppustatus_read_last <= 0;
    end else begin
        // Clear first (lower priority)
        if (ppustatus_read_last && !vblank_sync2) begin
            ppustatus[7] <= 0;
            $display("[%0t] PPUSTATUS[7] cleared (read last cycle)", $time);
        end
        
        // Set second (higher priority)
        if (vblank_sync2) begin
            ppustatus[7] <= 1;
            $display("[%0t] PPUSTATUS[7] set (vblank)", $time);
        end
        
        // Track read
        ppustatus_read_last <= (cpu_rw && cpu_addr == 16'h2002);
        if (cpu_rw && cpu_addr == 16'h2002) begin
            $display("[%0t] CPU reads $2002, value=$%02x", $time, ppustatus);
        end
    end
end

initial begin
    cpu_clk = 0;
    rst_n = 0;
    vblank_sync2 = 0;
    cpu_rw = 1;
    cpu_addr = 0;
    
    #20 rst_n = 1;
    
    // Test 1: VBlank set
    #100;
    $display("\n=== Test 1: VBlank Set ===");
    vblank_sync2 = 1;
    #10 cpu_clk = ~cpu_clk;
    #10 cpu_clk = ~cpu_clk;
    vblank_sync2 = 0;
    
    // Test 2: CPU reads $2002
    #100;
    $display("\n=== Test 2: CPU Read $2002 ===");
    cpu_addr = 16'h2002;
    cpu_rw = 1;
    #10 cpu_clk = ~cpu_clk;
    #10 cpu_clk = ~cpu_clk;
    
    // Test 3: Check if cleared next cycle
    #10 cpu_clk = ~cpu_clk;
    #10 cpu_clk = ~cpu_clk;
    $display("[%0t] After read: ppustatus=$%02x", $time, ppustatus);
    
    // Test 4: VBlank set while read pending
    #100;
    $display("\n=== Test 3: VBlank Set During Read ===");
    cpu_addr = 16'h2002;
    vblank_sync2 = 1;
    #10 cpu_clk = ~cpu_clk;
    #10 cpu_clk = ~cpu_clk;
    $display("[%0t] Result: ppustatus=$%02x (should be 1)", $time, ppustatus);
    
    #100;
    if (ppustatus[7] == 1) begin
        $display("\n[PASS] VBlank priority works correctly");
    end else begin
        $display("\n[FAIL] VBlank was cleared incorrectly");
    end
    
    $finish;
end

endmodule
