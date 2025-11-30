// NES APU (Audio Processing Unit)
// Simplified implementation with pulse wave channels

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

// Duty cycle lookup table
logic [7:0] duty_table[0:3];
assign duty_table[0] = 8'b01000000;  // 12.5%
assign duty_table[1] = 8'b01100000;  // 25%
assign duty_table[2] = 8'b01111000;  // 50%
assign duty_table[3] = 8'b10011111;  // 25% negated

//=============================================================================
// Pulse Channel 1
//=============================================================================
logic [10:0] pulse1_timer;
logic [10:0] pulse1_period;
logic [2:0]  pulse1_seq_pos;
logic [3:0]  pulse1_volume;
logic        pulse1_enabled;
logic [1:0]  pulse1_duty;
logic [15:0] pulse1_out;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pulse1_timer <= 0;
        pulse1_seq_pos <= 0;
    end else begin
        if (pulse1_timer == 0) begin
            pulse1_timer <= pulse1_period;
            pulse1_seq_pos <= pulse1_seq_pos + 1;
        end else begin
            pulse1_timer <= pulse1_timer - 1;
        end
    end
end

always_comb begin
    pulse1_duty = apu_pulse1[0][7:6];
    pulse1_volume = apu_pulse1[0][3:0];
    pulse1_period = {apu_pulse1[3][2:0], apu_pulse1[2]};
    pulse1_enabled = apu_status[0];
    
    if (pulse1_enabled && duty_table[pulse1_duty][pulse1_seq_pos]) begin
        pulse1_out = {pulse1_volume, 12'h000};
    end else begin
        pulse1_out = 16'h0000;
    end
end

//=============================================================================
// Pulse Channel 2
//=============================================================================
logic [10:0] pulse2_timer;
logic [10:0] pulse2_period;
logic [2:0]  pulse2_seq_pos;
logic [3:0]  pulse2_volume;
logic        pulse2_enabled;
logic [1:0]  pulse2_duty;
logic [15:0] pulse2_out;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pulse2_timer <= 0;
        pulse2_seq_pos <= 0;
    end else begin
        if (pulse2_timer == 0) begin
            pulse2_timer <= pulse2_period;
            pulse2_seq_pos <= pulse2_seq_pos + 1;
        end else begin
            pulse2_timer <= pulse2_timer - 1;
        end
    end
end

always_comb begin
    pulse2_duty = apu_pulse2[0][7:6];
    pulse2_volume = apu_pulse2[0][3:0];
    pulse2_period = {apu_pulse2[3][2:0], apu_pulse2[2]};
    pulse2_enabled = apu_status[1];
    
    if (pulse2_enabled && duty_table[pulse2_duty][pulse2_seq_pos]) begin
        pulse2_out = {pulse2_volume, 12'h000};
    end else begin
        pulse2_out = 16'h0000;
    end
end

//=============================================================================
// Audio Mixer
//=============================================================================
assign audio_l = pulse1_out + pulse2_out;
assign audio_r = pulse1_out + pulse2_out;

endmodule
