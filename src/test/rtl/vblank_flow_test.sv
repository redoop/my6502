// Complete VBlank Flow Test - Simulate game waiting for VBlank

module vblank_flow_test;

logic clk, rst_n;
logic [3:0] clk_div;
logic cpu_clk, ppu_clk;
logic [8:0] scanline, dot;
logic vblank;
logic vblank_sync1, vblank_sync2;
logic [7:0] ppustatus;
logic ppustatus_read_last;
logic cpu_reads_2002;

int vblank_seen_count;
int read_count;

// Clock divider
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) clk_div <= 0;
    else clk_div <= clk_div + 1;
end

assign cpu_clk = clk_div[3];  // ÷16
assign ppu_clk = clk_div[1];  // ÷4

// PPU timing (simplified)
always_ff @(posedge ppu_clk or negedge rst_n) begin
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
        
        if (scanline == 241 && dot == 1) vblank <= 1;
        if (scanline == 261 && dot == 1) vblank <= 0;
    end
end

// Clock domain crossing
always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        vblank_sync1 <= 0;
        vblank_sync2 <= 0;
    end else begin
        vblank_sync1 <= vblank;
        vblank_sync2 <= vblank_sync1;
    end
end

// PPUSTATUS logic
always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        ppustatus <= 0;
        ppustatus_read_last <= 0;
    end else begin
        if (ppustatus_read_last && !vblank_sync2) begin
            ppustatus[7] <= 0;
        end
        
        if (vblank_sync2) begin
            ppustatus[7] <= 1;
        end
        
        ppustatus_read_last <= cpu_reads_2002;
    end
end

// Simulate game reading $2002
initial begin
    clk = 0;
    rst_n = 0;
    cpu_reads_2002 = 0;
    vblank_seen_count = 0;
    read_count = 0;
    
    #100 rst_n = 1;
    
    $display("=== Simulating Game VBlank Wait Loop ===\n");
    
    // Game loop: wait for VBlank
    fork
        // Clock generator
        forever #5 clk = ~clk;
        
        // Game code simulation
        begin
            // Wait a bit for system to stabilize
            repeat(1000) @(posedge cpu_clk);
            
            $display("[%0t] Game starts waiting for VBlank...", $time);
            
            // Simulate: while(!(PPUSTATUS & 0x80)) {}
            repeat(100000) begin
                @(posedge cpu_clk);
                cpu_reads_2002 = 1;
                @(posedge cpu_clk);
                cpu_reads_2002 = 0;
                read_count++;
                
                if (ppustatus[7]) begin
                    vblank_seen_count++;
                    $display("[%0t] VBlank detected! (read #%0d, ppustatus=$%02x)", 
                             $time, read_count, ppustatus);
                    
                    if (vblank_seen_count >= 3) begin
                        $display("\n[SUCCESS] Game saw VBlank %0d times", vblank_seen_count);
                        $display("Total reads: %0d", read_count);
                        $finish;
                    end
                    
                    // Wait for VBlank to clear
                    repeat(1000) @(posedge cpu_clk);
                end
                
                if (read_count % 10000 == 0) begin
                    $display("[%0t] Still waiting... (read #%0d)", $time, read_count);
                end
            end
            
            $display("\n[FAIL] Game never saw VBlank after %0d reads", read_count);
            $finish;
        end
    join
end

endmodule
