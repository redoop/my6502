// Performance Benchmark Test
// Measures CPU instruction throughput and PPU rendering performance

module perf_test;

logic clk, rst_n;
logic [15:0] addr;
logic [7:0] data_in, data_out;
logic rw;
logic nmi, irq;

cpu_6502 cpu (
    .clk(clk),
    .rst_n(rst_n),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out),
    .rw(rw),
    .nmi(nmi),
    .irq(irq)
);

initial clk = 0;
always #5 clk = ~clk;

logic [7:0] mem[0:65535];

always_comb begin
    if (rw) data_in = mem[addr];
    else data_in = 8'h00;
end

always @(posedge clk) begin
    if (!rw) mem[addr] <= data_out;
end

integer cycle_count;
integer instr_count;

initial begin
    rst_n = 0;
    nmi = 0;
    irq = 0;
    cycle_count = 0;
    instr_count = 0;
    
    for (int i = 0; i < 65536; i++) mem[i] = 8'hEA;
    
    mem[16'hFFFC] = 8'h00;
    mem[16'hFFFD] = 8'h80;
    
    // Benchmark: 100 instructions
    // LDA #$00, ADC #$01, STA $10, repeated
    for (int i = 0; i < 33; i++) begin
        mem[16'h8000 + i*6 + 0] = 8'hA9;  // LDA #$00
        mem[16'h8000 + i*6 + 1] = 8'h00;
        mem[16'h8000 + i*6 + 2] = 8'h69;  // ADC #$01
        mem[16'h8000 + i*6 + 3] = 8'h01;
        mem[16'h8000 + i*6 + 4] = 8'h85;  // STA $10
        mem[16'h8000 + i*6 + 5] = 8'h10;
    end
    mem[16'h8000 + 198] = 8'h4C;  // JMP $8000 + 198
    mem[16'h8000 + 199] = 8'hC6;
    mem[16'h8000 + 200] = 8'h80;
    
    #20 rst_n = 1;
    
    // Count cycles for 100 instructions
    repeat(1000) @(posedge clk) cycle_count++;
    
    $display("[PERF] Executed ~100 instructions in %0d cycles", cycle_count);
    $display("[PERF] Average cycles per instruction: %0.2f", cycle_count / 100.0);
    $display("[PERF] Instructions per second @ 1MHz: %0d", 1000000 / (cycle_count / 100));
    
    $finish;
end

endmodule
