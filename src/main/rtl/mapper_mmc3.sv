// MMC3 Mapper (Mapper 4)
// Used by Super Mario Bros 3, Mega Man series, etc.

module mapper_mmc3 (
    input  logic        clk,
    input  logic        rst_n,
    
    // CPU interface
    input  logic [15:0] cpu_addr,
    input  logic [7:0]  cpu_data,
    input  logic        cpu_write,
    
    // PRG ROM mapping (256KB max = 18 bits)
    output logic [17:0] prg_rom_addr,
    
    // CHR ROM mapping (256KB max = 18 bits)
    input  logic [13:0] ppu_addr,
    output logic [17:0] chr_rom_addr,
    
    // IRQ output
    output logic        irq
);

// MMC3 registers
logic [2:0] bank_select;
logic prg_rom_bank_mode;
logic chr_a12_inversion;
logic [7:0] bank_regs[0:7];

// IRQ registers
logic [7:0] irq_latch;
logic [7:0] irq_counter;
logic irq_reload;
logic irq_enabled;
logic last_a12;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        bank_select <= 0;
        prg_rom_bank_mode <= 0;
        chr_a12_inversion <= 0;
        for (int i = 0; i < 8; i++) bank_regs[i] <= 0;
        irq_latch <= 0;
        irq_counter <= 0;
        irq_reload <= 0;
        irq_enabled <= 0;
        irq <= 0;
        last_a12 <= 0;
    end else begin
        // IRQ counter clocking on A12 rising edge
        if (ppu_addr[12] && !last_a12) begin
            if (irq_counter == 0 || irq_reload) begin
                irq_counter <= irq_latch;
                irq_reload <= 0;
            end else begin
                irq_counter <= irq_counter - 1;
            end
            
            if (irq_counter == 0 && irq_enabled) begin
                irq <= 1;
            end
        end
        last_a12 <= ppu_addr[12];
        
        if (cpu_write) begin
            if (cpu_addr >= 16'h8000 && cpu_addr <= 16'h9FFF && cpu_addr[0] == 0) begin
                // Bank select ($8000-$9FFE, even)
                bank_select <= cpu_data[2:0];
                prg_rom_bank_mode <= cpu_data[6];
                chr_a12_inversion <= cpu_data[7];
            end else if (cpu_addr >= 16'h8000 && cpu_addr <= 16'h9FFF && cpu_addr[0] == 1) begin
                // Bank data ($8001-$9FFF, odd)
                bank_regs[bank_select] <= cpu_data;
            end else if (cpu_addr >= 16'hC000 && cpu_addr <= 16'hDFFF && cpu_addr[0] == 0) begin
                // IRQ latch ($C000-$DFFE, even)
                irq_latch <= cpu_data;
            end else if (cpu_addr >= 16'hC000 && cpu_addr <= 16'hDFFF && cpu_addr[0] == 1) begin
                // IRQ reload ($C001-$DFFF, odd)
                irq_reload <= 1;
            end else if (cpu_addr >= 16'hE000 && cpu_addr <= 16'hFFFF && cpu_addr[0] == 0) begin
                // IRQ disable ($E000-$FFFE, even)
                irq_enabled <= 0;
                irq <= 0;
            end else if (cpu_addr >= 16'hE000 && cpu_addr <= 16'hFFFF && cpu_addr[0] == 1) begin
                // IRQ enable ($E001-$FFFF, odd)
                irq_enabled <= 1;
            end
        end
    end
end

// PRG ROM banking (8KB switchable + 8KB fixed)
always_comb begin
    if (cpu_addr >= 16'h8000 && cpu_addr < 16'hA000) begin
        // $8000-$9FFF: switchable
        if (!prg_rom_bank_mode)
            prg_rom_addr = {bank_regs[6][5:0], cpu_addr[12:0]};
        else
            prg_rom_addr = {6'b111110, cpu_addr[12:0]}; // second-to-last bank
    end else if (cpu_addr >= 16'hA000 && cpu_addr < 16'hC000) begin
        // $A000-$BFFF: switchable
        prg_rom_addr = {bank_regs[7][5:0], cpu_addr[12:0]};
    end else if (cpu_addr >= 16'hC000 && cpu_addr < 16'hE000) begin
        // $C000-$DFFF: switchable
        if (prg_rom_bank_mode)
            prg_rom_addr = {bank_regs[6][5:0], cpu_addr[12:0]};
        else
            prg_rom_addr = {6'b111110, cpu_addr[12:0]}; // second-to-last bank
    end else begin
        // $E000-$FFFF: fixed to last bank
        prg_rom_addr = {6'b111111, cpu_addr[12:0]};
    end
end

// CHR ROM banking (2KB + 1KB switchable banks)
always_comb begin
    if (!chr_a12_inversion) begin
        // Normal mode
        if (ppu_addr < 14'h0800)
            chr_rom_addr = {bank_regs[0][7:1], ppu_addr[10:0]};
        else if (ppu_addr < 14'h1000)
            chr_rom_addr = {bank_regs[1][7:1], ppu_addr[10:0]};
        else if (ppu_addr < 14'h1400)
            chr_rom_addr = {bank_regs[2], ppu_addr[9:0]};
        else if (ppu_addr < 14'h1800)
            chr_rom_addr = {bank_regs[3], ppu_addr[9:0]};
        else if (ppu_addr < 14'h1C00)
            chr_rom_addr = {bank_regs[4], ppu_addr[9:0]};
        else
            chr_rom_addr = {bank_regs[5], ppu_addr[9:0]};
    end else begin
        // Inverted mode
        if (ppu_addr < 14'h0400)
            chr_rom_addr = {bank_regs[2], ppu_addr[9:0]};
        else if (ppu_addr < 14'h0800)
            chr_rom_addr = {bank_regs[3], ppu_addr[9:0]};
        else if (ppu_addr < 14'h0C00)
            chr_rom_addr = {bank_regs[4], ppu_addr[9:0]};
        else if (ppu_addr < 14'h1000)
            chr_rom_addr = {bank_regs[5], ppu_addr[9:0]};
        else if (ppu_addr < 14'h1800)
            chr_rom_addr = {bank_regs[0][7:1], ppu_addr[10:0]};
        else
            chr_rom_addr = {bank_regs[1][7:1], ppu_addr[10:0]};
    end
end

endmodule
