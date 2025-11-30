// NES DMA Controller
// Handles OAM DMA transfers from CPU RAM to OAM

module nes_dma (
    input  logic        clk,
    input  logic        rst_n,
    
    // Control
    input  logic        dma_start,
    input  logic [7:0]  dma_page,
    output logic        dma_active,
    
    // Memory interface
    input  logic [7:0]  ram_data,
    output logic [7:0]  ram_addr_low,
    output logic [7:0]  oam_addr,
    output logic [7:0]  oam_data,
    output logic        oam_write
);

logic [7:0] dma_offset;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dma_active <= 0;
        dma_offset <= 0;
        oam_write <= 0;
    end else if (dma_start && !dma_active) begin
        dma_active <= 1;
        dma_offset <= 0;
    end else if (dma_active) begin
        ram_addr_low <= dma_offset;
        oam_addr <= dma_offset;
        oam_data <= ram_data;
        oam_write <= 1;
        
        dma_offset <= dma_offset + 1;
        if (dma_offset == 8'hFF) begin
            dma_active <= 0;
            oam_write <= 0;
        end
    end else begin
        oam_write <= 0;
    end
end

endmodule
