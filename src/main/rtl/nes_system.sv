// NES System - Top Level Integration
// Modular SystemVerilog implementation

module nes_system #(
    parameter MAPPER = 0  // 0=NROM, 4=MMC3
) (
    input  logic        clk,
    input  logic        rst_n,
    
    // Video output
    output logic [7:0]  video_r,
    output logic [7:0]  video_g,
    output logic [7:0]  video_b,
    output logic        video_hsync,
    output logic        video_vsync,
    output logic        video_de,
    
    // Audio output
    output logic [15:0] audio_l,
    output logic [15:0] audio_r,
    
    // Controller input
    input  logic [7:0]  controller1,
    input  logic [7:0]  controller2,
    
    // Cartridge interface
    input  logic [7:0]  prg_rom_data,
    output logic [17:0] prg_rom_addr,
    input  logic [7:0]  chr_rom_data,
    output logic [17:0] chr_rom_addr,
    
    // Debug outputs
    output logic [15:0] vram_write_count,
    output logic [15:0] nmi_trigger_count,
    output logic [15:0] debug_cpu_addr,
    output logic        debug_cpu_rw,
    output logic [7:0]  debug_ppustatus,
    output logic        debug_vblank,
    output logic        debug_vblank_sync1,
    output logic        debug_vblank_sync2,
    output logic        debug_nmi,
    output logic [7:0]  debug_ppuctrl
);

//=============================================================================
// Clock Generation
//=============================================================================
logic [3:0] clk_div;
logic cpu_clk, ppu_clk;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) clk_div <= 0;
    else clk_div <= clk_div + 1;
end

assign cpu_clk = clk_div[2];  // ÷8 = 2.68 MHz (faster for testing)
assign ppu_clk = clk_div[1];  // ÷4 = 5.37 MHz

// Debug signal assignments
assign debug_cpu_addr = cpu_addr;
assign debug_cpu_rw = cpu_rw;
assign debug_ppustatus = ppustatus;
assign debug_vblank = vblank;
assign debug_vblank_sync1 = vblank_sync1;
assign debug_vblank_sync2 = vblank_sync2;
assign debug_nmi = nmi;
assign debug_ppuctrl = ppuctrl;

//=============================================================================
// Memory Arrays
//=============================================================================
logic [7:0] ram[0:2047];
logic [7:0] oam[0:255];
logic [7:0] vram[0:2047];
logic [7:0] palette[0:31];
logic [31:0] palette_write_count;

initial begin
    for (int i = 0; i < 2048; i++) vram[i] = 8'h00;
    for (int i = 0; i < 256; i++) oam[i] = 8'hFF;
    // Initialize with default NES palette for testing
    palette[0] = 8'h0F; palette[1] = 8'h00; palette[2] = 8'h10; palette[3] = 8'h30;
    palette[4] = 8'h0F; palette[5] = 8'h16; palette[6] = 8'h26; palette[7] = 8'h36;
    palette[8] = 8'h0F; palette[9] = 8'h09; palette[10] = 8'h19; palette[11] = 8'h29;
    palette[12] = 8'h0F; palette[13] = 8'h01; palette[14] = 8'h11; palette[15] = 8'h21;
    for (int i = 16; i < 32; i++) palette[i] = palette[i-16];  // Mirror sprite palette
    palette_write_count = 0;
    $display("[INIT] Default palette loaded");
end

//=============================================================================
// CPU Interface
//=============================================================================
logic [15:0] cpu_addr;
logic [7:0]  cpu_data_out, cpu_data_in;
logic        cpu_rw;
logic        nmi, irq;

cpu_6502 cpu (
    .clk(cpu_clk),
    .rst_n(rst_n),
    .addr(cpu_addr),
    .data_in(cpu_data_in),
    .data_out(cpu_data_out),
    .rw(cpu_rw),
    .nmi(nmi),
    .irq(irq)
);

//=============================================================================
// PPU Registers and State
//=============================================================================
logic [7:0]  ppuctrl, ppumask, ppustatus;
logic [7:0]  oamaddr;
logic [7:0]  ppuscroll_x, ppuscroll_y;
logic [15:0] ppuaddr;
logic        ppuaddr_latch;
logic [7:0]  ppudata_buffer;
logic        vblank, sprite0_hit, rendering;

// Mapper signals
logic [13:0] ppu_chr_addr;  // PPU's 14-bit address
logic        mapper_write;

// PPU Module
nes_ppu ppu (
    .clk(ppu_clk),
    .rst_n(rst_n),
    .ppuctrl(ppuctrl),
    .ppumask(ppumask),
    .ppuscroll_x(ppuscroll_x),
    .ppuscroll_y(ppuscroll_y),
    .ppuaddr(ppuaddr),
    .vram(vram),
    .oam(oam),
    .palette(palette),
    .chr_rom_data(chr_rom_data),
    .chr_rom_addr(ppu_chr_addr),
    .video_r(video_r),
    .video_g(video_g),
    .video_b(video_b),
    .video_hsync(video_hsync),
    .video_vsync(video_vsync),
    .video_de(video_de),
    .vblank(vblank),
    .sprite0_hit(sprite0_hit),
    .rendering(rendering)
);

//=============================================================================
// APU Registers
//=============================================================================
logic [7:0] apu_pulse1[0:3];
logic [7:0] apu_pulse2[0:3];
logic [7:0] apu_triangle[0:3];
logic [7:0] apu_noise[0:3];
logic [7:0] apu_dmc[0:3];
logic [7:0] apu_status;
logic [7:0] apu_frame_counter;

// APU Module
nes_apu apu (
    .clk(cpu_clk),
    .rst_n(rst_n),
    .apu_pulse1(apu_pulse1),
    .apu_pulse2(apu_pulse2),
    .apu_triangle(apu_triangle),
    .apu_noise(apu_noise),
    .apu_dmc(apu_dmc),
    .apu_status(apu_status),
    .audio_l(audio_l),
    .audio_r(audio_r)
);

//=============================================================================
// DMA Controller
//=============================================================================
logic dma_active, dma_start;
logic [7:0] dma_page, dma_offset;
logic [7:0] dma_ram_addr_low, dma_oam_addr, dma_oam_data;
logic dma_oam_write;

nes_dma dma (
    .clk(cpu_clk),
    .rst_n(rst_n),
    .dma_start(dma_start),
    .dma_page(dma_page),
    .dma_active(dma_active),
    .ram_data(ram[{dma_page, dma_ram_addr_low}]),
    .ram_addr_low(dma_ram_addr_low),
    .oam_addr(dma_oam_addr),
    .oam_data(dma_oam_data),
    .oam_write(dma_oam_write)
);

// DMA write to OAM
always_ff @(posedge cpu_clk) begin
    if (dma_oam_write) oam[dma_oam_addr] <= dma_oam_data;
end

//=============================================================================
// CPU Memory Map - Reads
//=============================================================================
always_comb begin
    cpu_data_in = 8'h00;
    
    if (cpu_rw && cpu_addr >= 16'h2000 && cpu_addr <= 16'h2007) begin
        $display("[DEBUG] PPU read: addr=$%04x", cpu_addr);
    end
    
    if (cpu_addr >= 16'h0000 && cpu_addr <= 16'h1FFF) begin
        cpu_data_in = ram[cpu_addr[10:0]];  // $0000-$1FFF: 2KB RAM (mirrored)
    end else if (cpu_addr == 16'h2002) begin
        cpu_data_in = ppustatus;
        if (cpu_rw) $display("[PPU] $2002 read: VBlank=%b status=$%02x", ppustatus[7], ppustatus);
    end else if (cpu_addr == 16'h2004) begin
        cpu_data_in = oam[oamaddr];
    end else if (cpu_addr == 16'h2007) begin
        cpu_data_in = ppudata_buffer;
    end else if (cpu_addr == 16'h4015) begin
        cpu_data_in = apu_status;
    end else if (cpu_addr == 16'h4016) begin
        cpu_data_in = {7'b0, controller1[0]};
    end else if (cpu_addr == 16'h4017) begin
        cpu_data_in = {7'b0, controller2[0]};
    end else if (cpu_addr >= 16'h4000 && cpu_addr <= 16'hFFFF) begin
        cpu_data_in = prg_rom_data;  // $4000-$FFFF: ROM
    end else begin
        cpu_data_in = 8'h00;
    end
end

//=============================================================================
// CPU Memory Map - Writes
//=============================================================================
logic [31:0] total_write_count;

always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        ppuctrl <= 0;
        ppumask <= 0;
        oamaddr <= 0;
        ppuaddr <= 0;
        ppuaddr_latch <= 0;
        dma_start <= 0;
        ppuscroll_x <= 0;
        ppuscroll_y <= 0;
        vram_write_count <= 0;
        total_write_count <= 0;
        nmi_trigger_count <= 0;
        apu_status <= 0;
        apu_frame_counter <= 0;
    end else begin
        dma_start <= 0;  // Pulse signal
        
        if (!cpu_rw) begin
            total_write_count <= total_write_count + 1;
            
            if (cpu_addr >= 16'h6000 && cpu_addr < 16'h7000) begin
                $display("[TEST] Write $%04x = $%02x", cpu_addr, cpu_data_out);
            end
            
            if (cpu_addr >= 16'h2000 && cpu_addr < 16'h4020) begin
                $display("[IO_WRITE] #%d addr=$%04x data=$%02x", total_write_count, cpu_addr, cpu_data_out);
            end
            
            if (cpu_addr >= 16'h0000 && cpu_addr <= 16'h1FFF) begin
                ram[cpu_addr[10:0]] <= cpu_data_out;
            end else if (cpu_addr == 16'h2000) begin
                ppuctrl <= cpu_data_out;
                $display("[PPU] PPUCTRL=$%02x (NMI=%b BG=$%x SPR=$%x)", 
                         cpu_data_out, cpu_data_out[7], cpu_data_out[4], cpu_data_out[3]);
            end else if (cpu_addr == 16'h2001) begin
                ppumask <= cpu_data_out;
                $display("[PPU] PPUMASK=$%02x", cpu_data_out);
            end else if (cpu_addr == 16'h2003) begin
                oamaddr <= cpu_data_out;
            end else if (cpu_addr == 16'h2004) begin
                oam[oamaddr] <= cpu_data_out;
                oamaddr <= oamaddr + 1;
            end else if (cpu_addr == 16'h2005) begin
                if (!ppuaddr_latch) ppuscroll_x <= cpu_data_out;
                else ppuscroll_y <= cpu_data_out;
                ppuaddr_latch <= ~ppuaddr_latch;
            end else if (cpu_addr == 16'h2006) begin
                if (!ppuaddr_latch) begin
                    ppuaddr[15:8] <= cpu_data_out;
                    $display("[PPU] PPUADDR high=$%02x", cpu_data_out);
                end else begin
                    ppuaddr[7:0] <= cpu_data_out;
                    $display("[PPU] PPUADDR low=$%02x, full=$%04x", cpu_data_out, {ppuaddr[15:8], cpu_data_out});
                end
                ppuaddr_latch <= ~ppuaddr_latch;
            end else if (cpu_addr == 16'h2007) begin
                $display("[PPU] PPUDATA write addr=$%04x data=$%02x", ppuaddr, cpu_data_out);
                if (ppuaddr[13:0] < 14'h2000) begin
                    // CHR ROM (read-only)
                end else if (ppuaddr[13:0] < 14'h3F00) begin
                    vram[ppuaddr[10:0]] <= cpu_data_out;
                    vram_write_count <= vram_write_count + 1;
                    $display("[VRAM] Write addr=$%03x data=$%02x", ppuaddr[10:0], cpu_data_out);
                end else begin
                    palette[ppuaddr[4:0]] <= cpu_data_out;
                    $display("[PALETTE #%0d] addr=$%02x data=$%02x", palette_write_count, ppuaddr[4:0], cpu_data_out);
                    palette_write_count <= palette_write_count + 1;
                end
                ppuaddr <= ppuaddr + (ppuctrl[2] ? 32 : 1);
            end else if (cpu_addr >= 16'h4000 && cpu_addr <= 16'h4003) begin
                apu_pulse1[cpu_addr[1:0]] <= cpu_data_out;
                $display("[APU] Pulse1[$%01x] = $%02x", cpu_addr[1:0], cpu_data_out);
            end else if (cpu_addr >= 16'h4004 && cpu_addr <= 16'h4007) begin
                apu_pulse2[cpu_addr[1:0]] <= cpu_data_out;
                $display("[APU] Pulse2[$%01x] = $%02x", cpu_addr[1:0], cpu_data_out);
            end else if (cpu_addr >= 16'h4008 && cpu_addr <= 16'h400B) begin
                apu_triangle[cpu_addr[1:0]] <= cpu_data_out;
            end else if (cpu_addr >= 16'h400C && cpu_addr <= 16'h400F) begin
                apu_noise[cpu_addr[1:0]] <= cpu_data_out;
            end else if (cpu_addr >= 16'h4010 && cpu_addr <= 16'h4013) begin
                apu_dmc[cpu_addr[1:0]] <= cpu_data_out;
            end else if (cpu_addr == 16'h4014) begin
                dma_page <= cpu_data_out;
                dma_start <= 1;
            end else if (cpu_addr == 16'h4015) begin
                apu_status <= cpu_data_out;
            end else if (cpu_addr == 16'h4017) begin
                apu_frame_counter <= cpu_data_out;
            end
        end
    end
end

//=============================================================================
// PPUSTATUS Management
//=============================================================================
// Double-flop synchronizer for vblank (ppu_clk -> cpu_clk)
logic vblank_sync1, vblank_sync2, vblank_sync3;
logic ppustatus_read_last;  // Track if $2002 was read last cycle

always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        vblank_sync1 <= 0;
        vblank_sync2 <= 0;
        vblank_sync3 <= 0;
    end else begin
        vblank_sync1 <= vblank;
        vblank_sync2 <= vblank_sync1;
        vblank_sync3 <= vblank_sync2;
        if (vblank_sync2 && !vblank_sync3) begin
            $display("[SYNC] VBlank rising edge detected");
        end
    end
end

logic [7:0] vblank_hold_counter;

always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        ppustatus <= 8'h80;  // Start with VBlank set
        ppustatus_read_last <= 0;
        vblank_hold_counter <= 255;  // Hold initially
    end else begin
        // VBlank flag set on rising edge
        if (vblank_sync2 && !vblank_sync3) begin
            ppustatus[7] <= 1;
            vblank_hold_counter <= 200;  // Hold for 200 CPU cycles
            $display("[VBLANK] SET - holding for 200 cycles");
        end
        
        // VBlank flag clear - on cycle AFTER $2002 read
        if (ppustatus_read_last) begin
            ppustatus[7] <= 0;
            ppuaddr_latch <= 0;
            $display("[VBLANK] Cleared (delayed after $2002 read)");
        end
        
        // Decrement counter
        if (vblank_hold_counter > 0) begin
            vblank_hold_counter <= vblank_hold_counter - 1;
            if (vblank_hold_counter == 1) begin
                $display("[VBLANK] Hold expired");
            end
        end
        
        // Track if $2002 was read this cycle
        ppustatus_read_last <= (cpu_rw && cpu_addr == 16'h2002);
    end
end

//=============================================================================
// NMI Generation
//=============================================================================
always_ff @(posedge cpu_clk or negedge rst_n) begin
    if (!rst_n) begin
        nmi <= 0;
    end else begin
        // Use synchronized vblank signal and check PPUCTRL NMI enable
        if (vblank_sync2 && ppuctrl[7]) begin
            nmi <= 1;
            nmi_trigger_count <= nmi_trigger_count + 1;
            $display("[NMI] Triggered at cycle, ppuctrl=$%02x", ppuctrl);
        end else if (!vblank_sync2) begin
            nmi <= 0;
        end
    end
end

//=============================================================================
// PPUDATA Read Buffering
//=============================================================================
always_ff @(posedge ppu_clk) begin
    if (cpu_rw && cpu_addr == 16'h2007) begin
        if (ppuaddr[13:0] >= 14'h3F00) begin
            ppudata_buffer <= palette[ppuaddr[4:0]];
        end else begin
            ppudata_buffer <= vram[ppuaddr[10:0]];
        end
    end
end

//=============================================================================
// Cartridge Mapper
//=============================================================================
assign mapper_write = !cpu_rw && (cpu_addr >= 16'h8000);

generate
    if (MAPPER == 4) begin : gen_mmc3
        mapper_mmc3 mapper (
            .clk(cpu_clk),
            .rst_n(rst_n),
            .cpu_addr(cpu_addr),
            .cpu_data(cpu_data_out),
            .cpu_write(mapper_write),
            .prg_rom_addr(prg_rom_addr),
            .ppu_addr(ppu_chr_addr),
            .chr_rom_addr(chr_rom_addr)
        );
    end else begin : gen_nrom
        // NROM (Mapper 0): simple address passthrough
        always_comb begin
            if (cpu_addr >= 16'h8000) begin
                prg_rom_addr = {4'b0, cpu_addr[13:0]};
            end else begin
                prg_rom_addr = 18'h00000;
            end
            chr_rom_addr = {4'b0, ppu_chr_addr};
        end
    end
endgenerate

endmodule
