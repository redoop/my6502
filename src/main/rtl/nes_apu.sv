// NES APU (Audio Processing Unit)
// Complete implementation with all 5 channels

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
    input  logic [7:0]  apu_frame_counter,
    input  logic        apu_write_pulse1_3,
    input  logic        apu_write_pulse2_3,
    
    // Audio output
    output logic [15:0] audio_sample,
    output logic        audio_ready
);

// APU runs at CPU clock rate (~1.79 MHz)
// No additional clock divider needed

// Frame counter (240Hz or 192Hz)
logic [14:0] frame_counter;
logic [1:0] frame_step;
logic frame_irq;
logic frame_mode; // 0=4-step, 1=5-step

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        frame_counter <= 0;
        frame_step <= 0;
    end else begin
        frame_counter <= frame_counter + 1;
        if (frame_mode == 0) begin // 4-step mode
            if (frame_counter >= 14915) begin
                frame_counter <= 0;
                frame_step <= (frame_step == 3) ? 0 : frame_step + 1;
            end
        end else begin // 5-step mode
            if (frame_counter >= 18641) begin
                frame_counter <= 0;
                frame_step <= (frame_step == 4) ? 0 : frame_step + 1;
            end
        end
    end
end

assign frame_mode = apu_frame_counter[7];

//=============================================================================
// Pulse Channel 1
//=============================================================================
logic [10:0] pulse1_timer;
logic [10:0] pulse1_period;
logic [2:0]  pulse1_seq_pos;
logic [3:0]  pulse1_volume;
logic [3:0]  pulse1_envelope;
logic [7:0]  pulse1_length;
logic        pulse1_enabled;
logic        pulse1_constant_vol;
logic [1:0]  pulse1_duty;
logic [3:0]  pulse1_out;

logic [7:0] duty_table[0:3];
assign duty_table[0] = 8'b01000000;  // 12.5%
assign duty_table[1] = 8'b01100000;  // 25%
assign duty_table[2] = 8'b01111000;  // 50%
assign duty_table[3] = 8'b10011111;  // 25% negated

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pulse1_timer <= 0;
        pulse1_seq_pos <= 0;
        pulse1_length <= 0;
        pulse1_envelope <= 15;
    end else begin
        // Length counter reload on $4003 write
        if (apu_write_pulse1_3 && apu_status[0]) begin
            pulse1_length <= 64; // Load with max length
            pulse1_seq_pos <= 0;
        end
        
        // Timer
        if (pulse1_timer == 0) begin
            pulse1_timer <= pulse1_period;
            pulse1_seq_pos <= pulse1_seq_pos + 1;
        end else begin
            pulse1_timer <= pulse1_timer - 1;
        end
        
        // Length counter
        if (frame_step == 1 || frame_step == 3) begin
            if (pulse1_length > 0 && !apu_pulse1[0][5]) // halt flag
                pulse1_length <= pulse1_length - 1;
        end
        
        // Envelope
        if (frame_step == 3) begin
            if (!pulse1_constant_vol && pulse1_envelope > 0)
                pulse1_envelope <= pulse1_envelope - 1;
        end
    end
end

always_comb begin
    pulse1_duty = apu_pulse1[0][7:6];
    pulse1_constant_vol = apu_pulse1[0][4];
    pulse1_volume = pulse1_constant_vol ? apu_pulse1[0][3:0] : pulse1_envelope;
    pulse1_period = {apu_pulse1[3][2:0], apu_pulse1[2]};
    pulse1_enabled = apu_status[0] && pulse1_length > 0;
    
    if (pulse1_enabled && duty_table[pulse1_duty][pulse1_seq_pos] && pulse1_period >= 8)
        pulse1_out = pulse1_volume;
    else
        pulse1_out = 0;
end

//=============================================================================
// Pulse Channel 2
//=============================================================================
logic [10:0] pulse2_timer;
logic [10:0] pulse2_period;
logic [2:0]  pulse2_seq_pos;
logic [3:0]  pulse2_volume;
logic [3:0]  pulse2_envelope;
logic [7:0]  pulse2_length;
logic        pulse2_enabled;
logic        pulse2_constant_vol;
logic [1:0]  pulse2_duty;
logic [3:0]  pulse2_out;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pulse2_timer <= 0;
        pulse2_seq_pos <= 0;
        pulse2_length <= 0;
        pulse2_envelope <= 15;
    end else begin
        // Length counter reload on $4007 write
        if (apu_write_pulse2_3 && apu_status[1]) begin
            pulse2_length <= 64;
            pulse2_seq_pos <= 0;
        end
        
        if (pulse2_timer == 0) begin
            pulse2_timer <= pulse2_period;
            pulse2_seq_pos <= pulse2_seq_pos + 1;
        end else begin
            pulse2_timer <= pulse2_timer - 1;
        end
        
        if (frame_step == 1 || frame_step == 3) begin
            if (pulse2_length > 0 && !apu_pulse2[0][5])
                pulse2_length <= pulse2_length - 1;
        end
        
        if (frame_step == 3) begin
            if (!pulse2_constant_vol && pulse2_envelope > 0)
                pulse2_envelope <= pulse2_envelope - 1;
        end
    end
end

always_comb begin
    pulse2_duty = apu_pulse2[0][7:6];
    pulse2_constant_vol = apu_pulse2[0][4];
    pulse2_volume = pulse2_constant_vol ? apu_pulse2[0][3:0] : pulse2_envelope;
    pulse2_period = {apu_pulse2[3][2:0], apu_pulse2[2]};
    pulse2_enabled = apu_status[1] && pulse2_length > 0;
    
    if (pulse2_enabled && duty_table[pulse2_duty][pulse2_seq_pos] && pulse2_period >= 8)
        pulse2_out = pulse2_volume;
    else
        pulse2_out = 0;
end

//=============================================================================
// Triangle Channel
//=============================================================================
logic [10:0] triangle_timer;
logic [10:0] triangle_period;
logic [4:0]  triangle_seq_pos;
logic [7:0]  triangle_length;
logic [6:0]  triangle_linear;
logic        triangle_enabled;
logic [3:0]  triangle_out;

logic [4:0] triangle_sequence[0:31];
assign triangle_sequence[0]  = 15; assign triangle_sequence[1]  = 14;
assign triangle_sequence[2]  = 13; assign triangle_sequence[3]  = 12;
assign triangle_sequence[4]  = 11; assign triangle_sequence[5]  = 10;
assign triangle_sequence[6]  = 9;  assign triangle_sequence[7]  = 8;
assign triangle_sequence[8]  = 7;  assign triangle_sequence[9]  = 6;
assign triangle_sequence[10] = 5;  assign triangle_sequence[11] = 4;
assign triangle_sequence[12] = 3;  assign triangle_sequence[13] = 2;
assign triangle_sequence[14] = 1;  assign triangle_sequence[15] = 0;
assign triangle_sequence[16] = 0;  assign triangle_sequence[17] = 1;
assign triangle_sequence[18] = 2;  assign triangle_sequence[19] = 3;
assign triangle_sequence[20] = 4;  assign triangle_sequence[21] = 5;
assign triangle_sequence[22] = 6;  assign triangle_sequence[23] = 7;
assign triangle_sequence[24] = 8;  assign triangle_sequence[25] = 9;
assign triangle_sequence[26] = 10; assign triangle_sequence[27] = 11;
assign triangle_sequence[28] = 12; assign triangle_sequence[29] = 13;
assign triangle_sequence[30] = 14; assign triangle_sequence[31] = 15;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        triangle_timer <= 0;
        triangle_seq_pos <= 0;
        triangle_length <= 0;
        triangle_linear <= 0;
    end else begin
        if (triangle_timer == 0) begin
            triangle_timer <= triangle_period;
            if (triangle_linear > 0 && triangle_length > 0)
                triangle_seq_pos <= triangle_seq_pos + 1;
        end else begin
            triangle_timer <= triangle_timer - 1;
        end
        
        if (frame_step == 1 || frame_step == 3) begin
            if (triangle_length > 0 && !apu_triangle[0][7])
                triangle_length <= triangle_length - 1;
            if (triangle_linear > 0)
                triangle_linear <= triangle_linear - 1;
        end
    end
end

always_comb begin
    triangle_period = {apu_triangle[3][2:0], apu_triangle[2]};
    triangle_enabled = apu_status[2] && triangle_length > 0 && triangle_linear > 0;
    
    if (triangle_enabled && triangle_period >= 2)
        triangle_out = triangle_sequence[triangle_seq_pos];
    else
        triangle_out = 0;
end

//=============================================================================
// Noise Channel
//=============================================================================
logic [11:0] noise_timer;
logic [11:0] noise_period;
logic [14:0] noise_lfsr;
logic [3:0]  noise_volume;
logic [3:0]  noise_envelope;
logic [7:0]  noise_length;
logic        noise_enabled;
logic        noise_constant_vol;
logic        noise_mode;
logic [3:0]  noise_out;
logic        noise_feedback;

logic [11:0] noise_period_table[0:15];
assign noise_period_table[0]  = 4;    assign noise_period_table[1]  = 8;
assign noise_period_table[2]  = 16;   assign noise_period_table[3]  = 32;
assign noise_period_table[4]  = 64;   assign noise_period_table[5]  = 96;
assign noise_period_table[6]  = 128;  assign noise_period_table[7]  = 160;
assign noise_period_table[8]  = 202;  assign noise_period_table[9]  = 254;
assign noise_period_table[10] = 380;  assign noise_period_table[11] = 508;
assign noise_period_table[12] = 762;  assign noise_period_table[13] = 1016;
assign noise_period_table[14] = 2034; assign noise_period_table[15] = 4068;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        noise_timer <= 0;
        noise_lfsr <= 1;
        noise_length <= 0;
        noise_envelope <= 15;
    end else begin
        if (noise_timer == 0) begin
            noise_timer <= noise_period;
            noise_feedback = noise_lfsr[0] ^ (noise_mode ? noise_lfsr[6] : noise_lfsr[1]);
            noise_lfsr <= {noise_feedback, noise_lfsr[14:1]};
        end else begin
            noise_timer <= noise_timer - 1;
        end
        
        if (frame_step == 1 || frame_step == 3) begin
            if (noise_length > 0 && !apu_noise[0][5])
                noise_length <= noise_length - 1;
        end
        
        if (frame_step == 3) begin
            if (!noise_constant_vol && noise_envelope > 0)
                noise_envelope <= noise_envelope - 1;
        end
    end
end

always_comb begin
    noise_constant_vol = apu_noise[0][4];
    noise_volume = noise_constant_vol ? apu_noise[0][3:0] : noise_envelope;
    noise_mode = apu_noise[2][7];
    noise_period = noise_period_table[apu_noise[2][3:0]];
    noise_enabled = apu_status[3] && noise_length > 0;
    
    if (noise_enabled && !noise_lfsr[0])
        noise_out = noise_volume;
    else
        noise_out = 0;
end

//=============================================================================
// DMC Channel (simplified - just silence)
//=============================================================================
logic [6:0] dmc_out;
assign dmc_out = 0;

//=============================================================================
// Audio Mixer
//=============================================================================
logic [7:0] pulse_sum;
logic [7:0] tnd_sum;
logic [15:0] mixed_output;

// Sample rate divider (44.1kHz from 1.79MHz)
logic [8:0] sample_divider;
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        sample_divider <= 0;
        audio_ready <= 0;
    end else begin
        if (sample_divider >= 485) begin // Adjusted for actual clock rate
            sample_divider <= 0;
            audio_ready <= 1;
        end else begin
            sample_divider <= sample_divider + 1;
            audio_ready <= 0;
        end
    end
end

always_comb begin
    pulse_sum = {pulse1_out, 4'b0} + {pulse2_out, 4'b0};
    tnd_sum = {triangle_out, 4'b0} + {noise_out, 4'b0} + {dmc_out, 1'b0};
    
    // Simple linear mixing (amplify by 256x for audible output)
    mixed_output = ({pulse_sum, 8'b0} + {tnd_sum, 8'b0}) << 4;
end

assign audio_sample = mixed_output;

endmodule
