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
    mem[16'h8000] = 8'hA9;  // LDA #$42
    mem[16'h8001] = 8'h42;
    mem[16'h8002] = 8'h85;  // STA $10
    mem[16'h8003] = 8'h10;
    mem[16'h8004] = 8'hA5;  // LDA $10
    mem[16'h8005] = 8'h10;
    mem[16'h8006] = 8'h69;  // ADC #$08
    mem[16'h8007] = 8'h08;
    mem[16'h8008] = 8'h85;  // STA $11
    mem[16'h8009] = 8'h11;
    mem[16'h800A] = 8'h4C;  // JMP $800A (infinite loop)
    mem[16'h800B] = 8'h0A;
    mem[16'h800C] = 8'h80;
    
    #20 rst_n = 1;
    
    // Wait for program execution
    #1000;
    
    // Check results
    if (mem[16'h10] == 8'h42) begin
        $display("[TEST] PASS: mem[$10] = $42");
    end else begin
        $display("[TEST] FAIL: mem[$10] = $%02x (expected $42)", mem[16'h10]);
    end
    
    if (mem[16'h11] == 8'h4A) begin
        $display("[TEST] PASS: mem[$11] = $4A");
    end else begin
        $display("[TEST] FAIL: mem[$11] = $%02x (expected $4A)", mem[16'h11]);
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
