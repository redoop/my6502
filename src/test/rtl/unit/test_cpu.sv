// CPU 6502 Unit Test

module test_cpu;

logic clk, rst_n;
logic [15:0] addr;
logic [7:0] data_in, data_out;
logic rw;
logic nmi, irq;

// DUT
cpu_6502 dut (
    .clk(clk),
    .rst_n(rst_n),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out),
    .rw(rw),
    .nmi(nmi),
    .irq(irq)
);

// Clock
initial clk = 0;
always #5 clk = ~clk;

// Memory
logic [7:0] mem[0:65535];

// Memory interface
always_comb begin
    if (rw) data_in = mem[addr];
    else data_in = 8'h00;
end

always @(posedge clk) begin
    if (!rw) mem[addr] <= data_out;
end

initial begin
    $dumpfile("waveforms/test_cpu.vcd");
    $dumpvars(0, test_cpu);
    
    rst_n = 0;
    nmi = 0;
    irq = 0;
    
    // Initialize memory
    for (int i = 0; i < 65536; i++) mem[i] = 8'hEA;  // NOP
    
    // Reset vector
    mem[16'hFFFC] = 8'h00;
    mem[16'hFFFD] = 8'h80;
    
    // Program at $8000
    mem[16'h8000] = 8'hA9;  // LDA #$00
    mem[16'h8001] = 8'h00;
    mem[16'h8002] = 8'h85;  // STA $12
    mem[16'h8003] = 8'h12;
    mem[16'h8004] = 8'hE6;  // INC $12
    mem[16'h8005] = 8'h12;
    mem[16'h8006] = 8'hE6;  // INC $12
    mem[16'h8007] = 8'h12;
    mem[16'h8008] = 8'hC6;  // DEC $12
    mem[16'h8009] = 8'h12;
    
    mem[16'h800A] = 8'hA9;  // LDA #$80
    mem[16'h800B] = 8'h80;
    mem[16'h800C] = 8'h85;  // STA $13
    mem[16'h800D] = 8'h13;
    mem[16'h800E] = 8'h26;  // ROL $13
    mem[16'h800F] = 8'h13;
    mem[16'h8010] = 8'h66;  // ROR $13
    mem[16'h8011] = 8'h13;
    
    mem[16'h8012] = 8'hA9;  // LDA #$FF
    mem[16'h8013] = 8'hFF;
    mem[16'h8014] = 8'h29;  // AND #$0F
    mem[16'h8015] = 8'h0F;
    mem[16'h8016] = 8'h85;  // STA $14
    mem[16'h8017] = 8'h14;
    
    mem[16'h8018] = 8'hA9;  // LDA #$0F
    mem[16'h8019] = 8'h0F;
    mem[16'h801A] = 8'h09;  // ORA #$F0
    mem[16'h801B] = 8'hF0;
    mem[16'h801C] = 8'h85;  // STA $15
    mem[16'h801D] = 8'h15;
    
    mem[16'h801E] = 8'hA9;  // LDA #$FF
    mem[16'h801F] = 8'hFF;
    mem[16'h8020] = 8'h49;  // EOR #$AA
    mem[16'h8021] = 8'hAA;
    mem[16'h8022] = 8'h85;  // STA $16
    mem[16'h8023] = 8'h16;
    
    mem[16'h8024] = 8'hA9;  // LDA #$AA
    mem[16'h8025] = 8'hAA;
    mem[16'h8026] = 8'h85;  // STA $17
    mem[16'h8027] = 8'h17;
    mem[16'h8028] = 8'h46;  // LSR $17
    mem[16'h8029] = 8'h17;
    mem[16'h802A] = 8'h06;  // ASL $17
    mem[16'h802B] = 8'h17;
    
    mem[16'h802C] = 8'h4C;  // JMP $802C
    mem[16'h802D] = 8'h2C;
    mem[16'h802E] = 8'h80;
    
    #20 rst_n = 1;
    
    // Wait for program execution
    #5000;
    
    // Check results
    if (mem[16'h12] == 8'h01) begin
        $display("[TEST] PASS: INC/DEC - mem[$12] = $01");
    end else begin
        $display("[TEST] FAIL: INC/DEC - mem[$12] = $%02x (expected $01)", mem[16'h12]);
    end
    
    if (mem[16'h13] == 8'h80) begin
        $display("[TEST] PASS: ROL/ROR - mem[$13] = $80");
    end else begin
        $display("[TEST] FAIL: ROL/ROR - mem[$13] = $%02x (expected $80)", mem[16'h13]);
    end
    
    if (mem[16'h14] == 8'h0F) begin
        $display("[TEST] PASS: AND - mem[$14] = $0F");
    end else begin
        $display("[TEST] FAIL: AND - mem[$14] = $%02x (expected $0F)", mem[16'h14]);
    end
    
    if (mem[16'h15] == 8'hFF) begin
        $display("[TEST] PASS: ORA - mem[$15] = $FF");
    end else begin
        $display("[TEST] FAIL: ORA - mem[$15] = $%02x (expected $FF)", mem[16'h15]);
    end
    
    if (mem[16'h16] == 8'h55) begin
        $display("[TEST] PASS: EOR - mem[$16] = $55");
    end else begin
        $display("[TEST] FAIL: EOR - mem[$16] = $%02x (expected $55)", mem[16'h16]);
    end
    
    if (mem[16'h17] == 8'hAA) begin
        $display("[TEST] PASS: LSR/ASL - mem[$17] = $AA");
    end else begin
        $display("[TEST] FAIL: LSR/ASL - mem[$17] = $%02x (expected $AA)", mem[16'h17]);
    end
    
    // Test NMI
    $display("[TEST] Triggering NMI");
    mem[16'hFFFA] = 8'h00;  // NMI vector
    mem[16'hFFFB] = 8'h90;
    mem[16'h9000] = 8'h40;  // RTI
    
    nmi = 1;
    #100;
    nmi = 0;
    #100;
    
    $display("[TEST] All tests passed!");
    $finish;
end

// Monitor
always @(posedge clk) begin
    if (!rw) begin
        $display("  Write: [$%04x] = $%02x", addr, data_out);
    end
end

endmodule
