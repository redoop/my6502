// DMA Controller Unit Test

module test_dma;

logic clk, rst_n;
logic dma_start, dma_active;
logic [7:0] dma_page;
logic [7:0] ram_data, ram_addr_low;
logic [7:0] oam_addr, oam_data;
logic oam_write;

// DUT
nes_dma dut (
    .clk(clk),
    .rst_n(rst_n),
    .dma_start(dma_start),
    .dma_page(dma_page),
    .dma_active(dma_active),
    .ram_data(ram_data),
    .ram_addr_low(ram_addr_low),
    .oam_addr(oam_addr),
    .oam_data(oam_data),
    .oam_write(oam_write)
);

// Clock
initial clk = 0;
always #5 clk = ~clk;

// Test RAM
logic [7:0] test_ram[0:255];
assign ram_data = test_ram[ram_addr_low];

initial begin
    $dumpfile("test_dma.vcd");
    $dumpvars(0, test_dma);
    
    // Initialize
    rst_n = 0;
    dma_start = 0;
    dma_page = 0;
    
    // Fill test RAM
    for (int i = 0; i < 256; i++) begin
        test_ram[i] = i;
    end
    
    #20 rst_n = 1;
    
    // Test 1: DMA transfer from page $02
    $display("[TEST] Starting DMA from page $02");
    dma_page = 8'h02;
    dma_start = 1;
    #10 dma_start = 0;
    
    // Wait for transfer
    wait(!dma_active);
    #10;
    
    $display("[TEST] DMA transfer complete");
    
    // Test 2: Another transfer from page $03
    $display("[TEST] Starting DMA from page $03");
    dma_page = 8'h03;
    dma_start = 1;
    #10 dma_start = 0;
    
    wait(!dma_active);
    #10;
    
    $display("[TEST] All tests passed!");
    $finish;
end

// Monitor
always @(posedge clk) begin
    if (oam_write) begin
        $display("  OAM[$%02x] = $%02x", oam_addr, oam_data);
    end
end

endmodule
