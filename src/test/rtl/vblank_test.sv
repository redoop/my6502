// VBlank Signal Test - Verify PPU VBlank generation

module vblank_test;

logic clk, rst_n;
logic [8:0] scanline, dot;
logic vblank;

// Simple PPU timing
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        scanline <= 0;
        dot <= 0;
        vblank <= 0;
    end else begin
        if (dot == 340) begin
            dot <= 0;
            if (scanline == 261) scanline <= 0;
            else scanline <= scanline + 1;
        end else begin
            dot <= dot + 1;
        end
        
        // VBlank set at scanline 241
        if (scanline == 241 && dot == 1) begin
            vblank <= 1;
            $display("[%0t] VBlank SET at scanline=%d dot=%d", $time, scanline, dot);
        end
        
        // VBlank clear at scanline 261
        if (scanline == 261 && dot == 1) begin
            vblank <= 0;
            $display("[%0t] VBlank CLEAR at scanline=%d dot=%d", $time, scanline, dot);
        end
    end
end

initial begin
    clk = 0;
    rst_n = 0;
    #20 rst_n = 1;
    
    // Run for 3 frames
    repeat(262 * 341 * 3) begin
        #5 clk = ~clk;
    end
    
    $display("[TEST] VBlank test complete");
    $finish;
end

endmodule
