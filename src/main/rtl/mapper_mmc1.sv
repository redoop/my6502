// MMC1 Mapper (Mapper 1)
// Used by Super Mario Bros, Zelda, Metroid, etc.

module mapper_mmc1 (
    input  logic        clk,
    input  logic        rst_n,
    
    // CPU interface
    input  logic [15:0] cpu_addr,
    input  logic [7:0]  cpu_data,
    input  logic        cpu_write,
    
    // PRG ROM mapping
    output logic [17:0] prg_rom_addr,
    
    // CHR ROM mapping
    input  logic [13:0] ppu_addr,
    output logic [17:0] chr_rom_addr
);

// Shift register
logic [4:0] shift_reg;
logic [2:0] shift_count;

// MMC1 registers
logic [4:0] control;
logic [4:0] chr_bank_0;
logic [4:0] chr_bank_1;
logic [4:0] prg_bank;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        shift_reg <= 5'b10000;
        shift_count <= 0;
        control <= 5'b01100;  // 16KB PRG mode, 4KB CHR mode
        chr_bank_0 <= 0;
        chr_bank_1 <= 0;
        prg_bank <= 0;
    end else begin
        if (cpu_write && cpu_addr >= 16'h8000) begin
            $display("[MMC1] Write addr=$%04x data=$%02x", cpu_addr, cpu_data);
            if (cpu_data[7]) begin
                // Reset shift register
                shift_reg <= 5'b10000;
                shift_count <= 0;
                control[3:2] <= 2'b11;  // Reset to 16KB PRG mode
                $display("[MMC1] Reset shift register");
            end else begin
                // Shift in bit
                shift_reg <= {cpu_data[0], shift_reg[4:1]};
                shift_count <= shift_count + 1;
                $display("[MMC1] Shift bit %d, count=%d", cpu_data[0], shift_count + 1);
                
                if (shift_count == 4) begin
                    // Write to register
                    if (cpu_addr < 16'hA000) begin
                        control <= {cpu_data[0], shift_reg[4:1]};
                        $display("[MMC1] Control=$%02x", {cpu_data[0], shift_reg[4:1]});
                    end else if (cpu_addr < 16'hC000) begin
                        chr_bank_0 <= {cpu_data[0], shift_reg[4:1]};
                        $display("[MMC1] CHR Bank 0=$%02x", {cpu_data[0], shift_reg[4:1]});
                    end else if (cpu_addr < 16'hE000) begin
                        chr_bank_1 <= {cpu_data[0], shift_reg[4:1]};
                        $display("[MMC1] CHR Bank 1=$%02x", {cpu_data[0], shift_reg[4:1]});
                    end else begin
                        prg_bank <= {cpu_data[0], shift_reg[4:1]};
                        $display("[MMC1] PRG Bank=$%02x", {cpu_data[0], shift_reg[4:1]});
                    end
                    
                    shift_reg <= 5'b10000;
                    shift_count <= 0;
                end
            end
        end
    end
end

// PRG ROM banking
always_comb begin
    if (cpu_addr < 16'h8000) begin
        prg_rom_addr = 18'h00000;
    end else begin
        case (control[3:2])
            2'b00, 2'b01: begin
                // 32KB mode
                prg_rom_addr = {4'b0, prg_bank[3:1], cpu_addr[14:0]};
            end
            2'b10: begin
                // Fix first bank at $8000, switch second at $C000
                if (cpu_addr < 16'hC000)
                    prg_rom_addr = {4'b0, 4'b0000, cpu_addr[13:0]};
                else
                    prg_rom_addr = {4'b0, prg_bank[3:0], cpu_addr[13:0]};
            end
            2'b11: begin
                // Switch first bank at $8000, fix last bank at $C000
                if (cpu_addr < 16'hC000)
                    prg_rom_addr = {4'b0, prg_bank[3:0], cpu_addr[13:0]};
                else
                    // Map to last 16KB bank (bank 7 for 128KB ROM)
                    prg_rom_addr = {4'b0, 4'b0111, cpu_addr[13:0]};
            end
        endcase
    end
end

// CHR ROM banking
always_comb begin
    if (control[4]) begin
        // 4KB mode
        if (ppu_addr < 14'h1000)
            chr_rom_addr = {1'b0, chr_bank_0[4:0], ppu_addr[11:0]};
        else
            chr_rom_addr = {1'b0, chr_bank_1[4:0], ppu_addr[11:0]};
    end else begin
        // 8KB mode
        chr_rom_addr = {1'b0, chr_bank_0[4:1], ppu_addr[12:0]};
    end
end

endmodule
