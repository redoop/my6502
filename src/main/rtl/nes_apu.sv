// NES APU (Audio Processing Unit)
// Generates audio from pulse, triangle, noise, and DMC channels

module nes_apu (
    input  logic        clk,
    input  logic        rst_n,
    
    // Register inputs
    input  logic [7:0]  apu_pulse1[0:3],
    input  logic [7:0]  apu_pulse2[0:3],
    input  logic [7:0]  apu_triangle[0:3],
    input  logic [7:0]  apu_noise[0:3],
    input  logic [7:0]  apu_dmc[0:3],
    input  logic [7:0]  apu_status,
    
    // Audio output
    output logic [15:0] audio_l,
    output logic [15:0] audio_r
);

// Test tone generator (440Hz)
logic [15:0] audio_counter;
logic [15:0] test_tone;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        audio_counter <= 0;
        test_tone <= 0;
    end else begin
        audio_counter <= audio_counter + 1;
        if (audio_counter >= 2034) begin  // 1.79MHz / 440Hz / 2
            audio_counter <= 0;
            test_tone <= ~test_tone[15] ? 16'h1000 : 16'h0000;
        end
    end
end

// Pulse 1 channel
logic [15:0] pulse1_timer;
logic [3:0]  pulse1_duty;
logic [3:0]  pulse1_volume;
logic        pulse1_enabled;
logic        pulse1_out_bit;
logic [15:0] pulse1_out;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pulse1_timer <= 0;
        pulse1_duty <= 0;
        pulse1_enabled <= 0;
    end else begin
        pulse1_volume <= apu_pulse1[0][3:0];
        pulse1_enabled <= apu_status[0];
        
        if (pulse1_timer == 0) begin
            pulse1_timer <= {apu_pulse1[3][2:0], apu_pulse1[2]};
            pulse1_duty <= pulse1_duty + 1;
        end else begin
            pulse1_timer <= pulse1_timer - 1;
        end
        
        case (apu_pulse1[0][7:6])
            2'b00: pulse1_out_bit <= (pulse1_duty[2:0] == 3'd0);
            2'b01: pulse1_out_bit <= (pulse1_duty[2:0] < 3'd2);
            2'b10: pulse1_out_bit <= (pulse1_duty[2:0] < 3'd4);
            2'b11: pulse1_out_bit <= (pulse1_duty[2:0] >= 3'd2);
        endcase
        
        if (pulse1_enabled && pulse1_out_bit) begin
            pulse1_out <= {pulse1_volume, 12'h000};
        end else begin
            pulse1_out <= 16'h0000;
        end
    end
end

// Pulse 2 channel
logic [15:0] pulse2_timer;
logic [3:0]  pulse2_duty;
logic [3:0]  pulse2_volume;
logic        pulse2_enabled;
logic        pulse2_out_bit;
logic [15:0] pulse2_out;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pulse2_timer <= 0;
        pulse2_duty <= 0;
        pulse2_enabled <= 0;
    end else begin
        pulse2_volume <= apu_pulse2[0][3:0];
        pulse2_enabled <= apu_status[1];
        
        if (pulse2_timer == 0) begin
            pulse2_timer <= {apu_pulse2[3][2:0], apu_pulse2[2]};
            pulse2_duty <= pulse2_duty + 1;
        end else begin
            pulse2_timer <= pulse2_timer - 1;
        end
        
        case (apu_pulse2[0][7:6])
            2'b00: pulse2_out_bit <= (pulse2_duty[2:0] == 3'd0);
            2'b01: pulse2_out_bit <= (pulse2_duty[2:0] < 3'd2);
            2'b10: pulse2_out_bit <= (pulse2_duty[2:0] < 3'd4);
            2'b11: pulse2_out_bit <= (pulse2_duty[2:0] >= 3'd2);
        endcase
        
        if (pulse2_enabled && pulse2_out_bit) begin
            pulse2_out <= {pulse2_volume, 12'h000};
        end else begin
            pulse2_out <= 16'h0000;
        end
    end
end

// Mix audio channels
assign audio_l = test_tone + pulse1_out + pulse2_out;
assign audio_r = test_tone + pulse1_out + pulse2_out;

endmodule
