//=============================================================================
// 6502 CPU Core (Full Implementation)
//=============================================================================
module cpu_6502 (
    input  logic        clk,
    input  logic        rst_n,
    output logic [15:0] addr,
    input  logic [7:0]  data_in,
    output logic [7:0]  data_out,
    output logic        rw,
    input  logic        nmi,
    input  logic        irq
);

// Registers
logic [7:0]  A, X, Y, SP;
logic [15:0] PC;
logic        C, Z, I, D, B, V, N;  // Status flags

// State machine
typedef enum logic [2:0] {
    RESET,
    FETCH,
    DECODE,
    EXECUTE,
    MEMORY,
    WRITEBACK,
    NMI_HANDLER
} state_t;

state_t state, next_state;
logic [7:0] opcode, operand, alu_result;
logic [15:0] ea;  // Effective address
logic [2:0] cycle_count;
logic [15:0] reset_vector;
logic [2:0] nmi_cycle;
logic       nmi_pending;
logic       nmi_prev;  // Previous NMI state for edge detection
logic [7:0] indirect_addr_lo, indirect_addr_hi;  // For indirect addressing

// Temporary variables for ALU operations
logic [8:0] temp_sum, temp_diff;
logic [7:0] temp_result;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= RESET;
        cycle_count <= 0;
        rw <= 1;
        SP <= 8'hFD;
        A <= 0; X <= 0; Y <= 0;
        C <= 0; Z <= 0; I <= 1; D <= 0; B <= 0; V <= 0; N <= 0;
        nmi_cycle <= 0;
        nmi_pending <= 0;
        nmi_prev <= 0;
    end else begin
        state <= next_state;
        nmi_prev <= nmi;
        
        // Detect NMI rising edge
        if (nmi && !nmi_prev && !nmi_pending && state == FETCH) begin
            nmi_pending <= 1;
        end
        
        case (state)
            RESET: begin
                // Read reset vector from $FFFC-$FFFD
                if (cycle_count == 0) begin
                    addr <= 16'hFFFC;
                    rw <= 1;
                    cycle_count <= 1;
                end else if (cycle_count == 1) begin
                    reset_vector[7:0] <= data_in;
                    addr <= 16'hFFFD;
                    cycle_count <= 2;
                end else begin
                    reset_vector[15:8] <= data_in;
                    PC <= {data_in, reset_vector[7:0]};
                    cycle_count <= 0;
                    $display("[CPU] Reset vector: $%04x", {data_in, reset_vector[7:0]});
                end
            end
            FETCH: begin
                addr <= PC;
                rw <= 1;
                PC <= PC + 1;
                cycle_count <= 0;
            end
            
            DECODE: begin
                opcode <= data_in;
                addr <= PC;
                rw <= 1;
            end
            
            EXECUTE: begin
                // For immediate addressing, operand is in data_in
                // For other modes, operand was set in DECODE
                // Save operand for later use
                operand <= data_in;
                
                // Execute instruction
                case (opcode)
                    // LDA - use data_in directly
                    8'hA9: begin 
                        A <= data_in; 
                        Z <= (data_in == 0); 
                        N <= data_in[7]; 
                        PC <= PC + 1;
                    end
                    8'hA5: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end
                    8'hB5: begin addr <= {8'h00, data_in + X}; rw <= 1; PC <= PC + 1; end  // LDA zp,X
                    // LDA absolute - need to read high byte first, save low byte in operand
                    8'hAD: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end
                    8'hBD: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // LDA abs,X
                    8'hB9: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // LDA abs,Y
                    8'hA1: begin addr <= {8'h00, data_in + X}; rw <= 1; cycle_count <= 1; PC <= PC + 1; end  // LDA (ind,X) - read pointer
                    8'hB1: begin addr <= {8'h00, data_in}; rw <= 1; cycle_count <= 1; PC <= PC + 1; end      // LDA (ind),Y - read pointer
                    
                    // LDX
                    8'hA2: begin 
                        X <= data_in; 
                        Z <= (data_in == 0); 
                        N <= data_in[7]; 
                        PC <= PC + 1;
                    end
                    8'hA6: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end  // LDX zp
                    8'hB6: begin addr <= {8'h00, data_in + Y}; rw <= 1; PC <= PC + 1; end  // LDX zp,Y
                    8'hAE: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // LDX abs
                    
                    // LDY
                    8'hA0: begin 
                        Y <= data_in; 
                        Z <= (data_in == 0); 
                        N <= data_in[7]; 
                        PC <= PC + 1;
                    end
                    8'hA4: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end  // LDY zp
                    8'hB4: begin addr <= {8'h00, data_in + X}; rw <= 1; PC <= PC + 1; end  // LDY zp,X
                    
                    // STA
                    8'h85: begin addr <= {8'h00, data_in}; data_out <= A; rw <= 0; PC <= PC + 1; end
                    8'h95: begin addr <= {8'h00, data_in + X}; data_out <= A; rw <= 0; PC <= PC + 1; end  // STA zp,X
                    8'h8D: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // STA abs
                    8'h9D: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // STA abs,X
                    8'h81: begin addr <= {8'h00, data_in + X}; rw <= 1; cycle_count <= 1; PC <= PC + 1; end  // STA (ind,X)
                    8'h91: begin addr <= {8'h00, data_in}; rw <= 1; cycle_count <= 1; PC <= PC + 1; end      // STA (ind),Y
                    
                    // STX
                    8'h86: begin addr <= {8'h00, data_in}; data_out <= X; rw <= 0; PC <= PC + 1; end  // STX zp
                    8'h96: begin addr <= {8'h00, data_in + Y}; data_out <= X; rw <= 0; PC <= PC + 1; end  // STX zp,Y
                    8'h8E: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // STX abs
                    
                    // STY
                    8'h84: begin addr <= {8'h00, data_in}; data_out <= Y; rw <= 0; PC <= PC + 1; end  // STY zp
                    8'h94: begin addr <= {8'h00, data_in + X}; data_out <= Y; rw <= 0; PC <= PC + 1; end  // STY zp,X
                    8'h8C: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // STY abs
                    
                    // ORA
                    8'h09: begin
                        temp_result = A | data_in;
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                        PC <= PC + 1;
                    end
                    8'h05: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end  // ORA zp
                    8'h01: begin addr <= {8'h00, data_in + X}; rw <= 1; cycle_count <= 1; PC <= PC + 1; end  // ORA (ind,X)
                    
                    // AND
                    8'h29: begin
                        temp_result = A & data_in;
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                        PC <= PC + 1;
                    end
                    8'h21: begin addr <= {8'h00, data_in + X}; rw <= 1; cycle_count <= 1; PC <= PC + 1; end  // AND (ind,X)
                    
                    // EOR
                    8'h49: begin
                        temp_result = A ^ data_in;
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                        PC <= PC + 1;
                    end
                    
                    // ADC
                    8'h69: begin  // ADC #imm
                        temp_sum = A + data_in + {8'b0, C};
                        C <= temp_sum[8];
                        A <= temp_sum[7:0];
                        Z <= (temp_sum[7:0] == 0);
                        N <= temp_sum[7];
                        V <= (A[7] == data_in[7]) && (A[7] != temp_sum[7]);
                        PC <= PC + 1;
                    end
                    8'h65: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end  // ADC zp
                    8'h75: begin addr <= {8'h00, data_in + X}; rw <= 1; PC <= PC + 1; end  // ADC zp,X
                    8'h6D: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // ADC abs
                    8'h7D: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // ADC abs,X
                    8'h79: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // ADC abs,Y
                    
                    // SBC
                    8'hE9: begin  // SBC #imm
                        temp_diff = A - data_in - {8'b0, !C};
                        C <= !temp_diff[8];
                        A <= temp_diff[7:0];
                        Z <= (temp_diff[7:0] == 0);
                        N <= temp_diff[7];
                        PC <= PC + 1;
                    end
                    8'hE5: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end  // SBC zp
                    8'hF5: begin addr <= {8'h00, data_in + X}; rw <= 1; PC <= PC + 1; end  // SBC zp,X
                    8'hED: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // SBC abs
                    8'hFD: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // SBC abs,X
                    8'hF9: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // SBC abs,Y
                    
                    // BIT
                    8'h24: begin  // BIT zp
                        addr <= {8'h00, data_in};
                        rw <= 1;
                        PC <= PC + 1;
                    end
                    8'h2C: begin  // BIT abs
                        addr <= PC + 1;
                        rw <= 1;
                        PC <= PC + 1;
                        cycle_count <= 1;
                    end
                    
                    // INC - Increment Memory
                    8'hE6: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end  // INC zp
                    8'hF6: begin addr <= {8'h00, data_in + X}; rw <= 1; PC <= PC + 1; end  // INC zp,X
                    8'hEE: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // INC abs
                    8'hFE: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // INC abs,X
                    
                    // DEC - Decrement Memory
                    8'hC6: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end  // DEC zp
                    8'hD6: begin addr <= {8'h00, data_in + X}; rw <= 1; PC <= PC + 1; end  // DEC zp,X
                    8'hCE: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // DEC abs
                    8'hDE: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // DEC abs,X
                    
                    // ROL - Rotate Left
                    8'h26: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end  // ROL zp
                    8'h36: begin addr <= {8'h00, data_in + X}; rw <= 1; PC <= PC + 1; end  // ROL zp,X
                    8'h2E: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // ROL abs
                    8'h3E: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // ROL abs,X
                    
                    // ROR - Rotate Right
                    8'h66: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end  // ROR zp
                    8'h76: begin addr <= {8'h00, data_in + X}; rw <= 1; PC <= PC + 1; end  // ROR zp,X
                    8'h6E: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // ROR abs
                    8'h7E: begin addr <= PC + 1; rw <= 1; PC <= PC + 1; cycle_count <= 1; end  // ROR abs,X
                    
                    // ASL
                    8'h0A: begin  // ASL A
                        C <= A[7];
                        A <= {A[6:0], 1'b0};
                        Z <= (A[6:0] == 0);
                        N <= A[6];
                        PC <= PC;
                    end
                    8'h06: begin  // ASL zp
                        addr <= {8'h00, data_in};
                        rw <= 1;
                        PC <= PC + 1;
                    end
                    
                    // LSR
                    8'h4A: begin  // LSR A
                        C <= A[0];
                        A <= {1'b0, A[7:1]};
                        Z <= (A[7:1] == 0);
                        N <= 0;
                        PC <= PC;
                    end
                    
                    // ROL
                    8'h2A: begin  // ROL A
                        temp_result = {A[6:0], C};
                        C <= A[7];
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                        PC <= PC;
                    end
                    
                    // ROR
                    8'h6A: begin  // ROR A
                        temp_result = {C, A[7:1]};
                        C <= A[0];
                        A <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                        PC <= PC;
                    end
                    
                    // CMP
                    8'hC9: begin
                        temp_result = A - data_in;
                        C <= (A >= data_in);
                        Z <= (A == data_in);
                        N <= temp_result[7];
                        PC <= PC + 1;
                    end
                    8'hC5: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end  // CMP zp
                    
                    // CPX
                    8'hE0: begin
                        temp_result = X - data_in;
                        C <= (X >= data_in);
                        Z <= (X == data_in);
                        N <= temp_result[7];
                        PC <= PC + 1;
                    end
                    
                    // CPY
                    8'hC0: begin
                        temp_result = Y - data_in;
                        C <= (Y >= data_in);
                        Z <= (Y == data_in);
                        N <= temp_result[7];
                        PC <= PC + 1;
                    end
                    8'hC4: begin addr <= {8'h00, data_in}; rw <= 1; PC <= PC + 1; end  // CPY zp
                    
                    // INC
                    8'hE6: begin
                        addr <= {8'h00, data_in};
                        rw <= 1;
                        PC <= PC + 1;
                    end
                    
                    // DEC
                    8'hC6: begin
                        addr <= {8'h00, data_in};
                        rw <= 1;
                        PC <= PC + 1;
                    end
                    
                    // INX
                    8'hE8: begin
                        temp_result = X + 1;
                        X <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                        PC <= PC;
                    end
                    
                    // INY
                    8'hC8: begin
                        temp_result = Y + 1;
                        Y <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                        PC <= PC;
                    end
                    
                    // DEX
                    8'hCA: begin
                        temp_result = X - 1;
                        X <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                        PC <= PC;
                    end
                    
                    // DEY
                    8'h88: begin
                        temp_result = Y - 1;
                        Y <= temp_result;
                        Z <= (temp_result == 0);
                        N <= temp_result[7];
                        PC <= PC;
                    end
                    
                    // TAX
                    8'hAA: begin X <= A; Z <= (A == 0); N <= A[7]; PC <= PC; end
                    
                    // TAY
                    8'hA8: begin Y <= A; Z <= (A == 0); N <= A[7]; PC <= PC; end
                    
                    // TXA
                    8'h8A: begin A <= X; Z <= (X == 0); N <= X[7]; PC <= PC; end
                    
                    // TYA
                    8'h98: begin A <= Y; Z <= (Y == 0); N <= Y[7]; PC <= PC; end
                    
                    // TSX
                    8'hBA: begin X <= SP; Z <= (SP == 0); N <= SP[7]; PC <= PC; end
                    
                    // TXS
                    8'h9A: begin SP <= X; PC <= PC; end
                    
                    // PHA
                    8'h48: begin addr <= {8'h01, SP}; data_out <= A; rw <= 0; SP <= SP - 1; PC <= PC; end
                    
                    // PLA
                    8'h68: begin SP <= SP + 1; addr <= {8'h01, SP + 1}; rw <= 1; PC <= PC; end
                    
                    // PHP
                    8'h08: begin
                        addr <= {8'h01, SP};
                        data_out <= {N, V, 1'b1, B, D, I, Z, C};
                        rw <= 0;
                        SP <= SP - 1;
                        PC <= PC;
                    end
                    
                    // PLP
                    8'h28: begin SP <= SP + 1; addr <= {8'h01, SP + 1}; rw <= 1; PC <= PC; end
                    
                    // JMP
                    8'h4C: begin PC <= {data_in, operand}; end  // JMP abs
                    8'h6C: begin addr <= {data_in, operand}; rw <= 1; PC <= PC + 1; end  // JMP ind
                    
                    // JSR
                    8'h20: begin
                        addr <= {8'h01, SP};
                        data_out <= PC[15:8];
                        rw <= 0;
                        SP <= SP - 1;
                        PC <= PC;
                    end
                    
                    // RTS
                    8'h60: begin
                        SP <= SP + 1;
                        addr <= {8'h01, SP + 1};
                        rw <= 1;
                        PC <= PC;
                    end
                    
                    // BRK
                    8'h00: begin
                        addr <= {8'h01, SP};
                        data_out <= PC[15:8];
                        rw <= 0;
                        SP <= SP - 1;
                        B <= 1;
                        PC <= PC;
                    end
                    
                    // RTI
                    8'h40: begin
                        SP <= SP + 1;
                        addr <= {8'h01, SP + 1};
                        rw <= 1;
                        PC <= PC;
                    end
                    
                    // BEQ
                    8'hF0: begin
                        if (Z) PC <= PC + 1 + {{8{data_in[7]}}, data_in};
                        else PC <= PC + 1;
                    end
                    
                    // BNE
                    8'hD0: begin
                        if (!Z) PC <= PC + 1 + {{8{data_in[7]}}, data_in};
                        else PC <= PC + 1;
                    end
                    
                    // BCS
                    8'hB0: begin
                        if (C) PC <= PC + 1 + {{8{data_in[7]}}, data_in};
                        else PC <= PC + 1;
                    end
                    
                    // BCC
                    8'h90: begin
                        if (!C) PC <= PC + 1 + {{8{data_in[7]}}, data_in};
                        else PC <= PC + 1;
                    end
                    
                    // BMI
                    8'h30: begin
                        if (N) PC <= PC + 1 + {{8{data_in[7]}}, data_in};
                        else PC <= PC + 1;
                    end
                    
                    // BPL
                    8'h10: begin
                        if (!N) PC <= PC + 1 + {{8{data_in[7]}}, data_in};
                        else PC <= PC + 1;
                    end
                    
                    // BVS
                    8'h70: begin
                        if (V) PC <= PC + 1 + {{8{data_in[7]}}, data_in};
                        else PC <= PC + 1;
                    end
                    
                    // BVC
                    8'h50: begin
                        if (!V) PC <= PC + 1 + {{8{data_in[7]}}, data_in};
                        else PC <= PC + 1;
                    end
                    
                    // CLC
                    8'h18: begin C <= 0; PC <= PC; end
                    
                    // SEC
                    8'h38: begin C <= 1; PC <= PC; end
                    
                    // CLI
                    8'h58: begin I <= 0; PC <= PC; end
                    
                    // SEI
                    8'h78: begin I <= 1; PC <= PC; end
                    
                    // CLD
                    8'hD8: begin D <= 0; PC <= PC; end
                    
                    // SED
                    8'hF8: begin D <= 1; PC <= PC; end
                    
                    // CLV
                    8'hB8: begin V <= 0; PC <= PC; end
                    
                    // NOP
                    8'hEA: begin PC <= PC; end
                    
                    default: begin PC <= PC; end
                endcase
            end
            
            MEMORY: begin
                // LDA/STA absolute addressing - read high byte
                if ((opcode == 8'hAD || opcode == 8'hBD || opcode == 8'hB9 || 
                     opcode == 8'h8D || opcode == 8'h9D ||
                     opcode == 8'hAE || opcode == 8'h8E ||
                     opcode == 8'h8C ||
                     opcode == 8'h6D || opcode == 8'h7D || opcode == 8'h79 ||
                     opcode == 8'hED || opcode == 8'hFD || opcode == 8'hF9) && cycle_count == 1) begin
                    // data_in has high byte, operand has low byte
                    if (opcode == 8'hBD || opcode == 8'h9D || opcode == 8'h7D || opcode == 8'hFD) begin
                        addr <= {data_in, operand} + {8'b0, X};
                    end else if (opcode == 8'hB9 || opcode == 8'h79 || opcode == 8'hF9) begin
                        addr <= {data_in, operand} + {8'b0, Y};
                    end else begin
                        addr <= {data_in, operand};
                    end
                    
                    if (opcode == 8'h8D || opcode == 8'h9D || opcode == 8'h8E || opcode == 8'h8C) begin
                        // Store instructions
                        if (opcode == 8'h8D || opcode == 8'h9D) data_out <= A;
                        else if (opcode == 8'h8E) data_out <= X;
                        else if (opcode == 8'h8C) data_out <= Y;
                        rw <= 0;
                    end else begin
                        rw <= 1;
                    end
                    cycle_count <= 0;
                    PC <= PC + 1;  // Increment PC for the high byte
                // Indirect addressing - multi-cycle
                end else if ((opcode == 8'hA1 || opcode == 8'h81 || opcode == 8'h01 || opcode == 8'h21 || opcode == 8'hB1 || opcode == 8'h91) && cycle_count == 1) begin
                    // Read low byte of pointer
                    indirect_addr_lo <= data_in;
                    addr <= addr + 1;
                    cycle_count <= 2;
                    rw <= 1;
                end else if ((opcode == 8'hA1 || opcode == 8'h81 || opcode == 8'h01 || opcode == 8'h21) && cycle_count == 2) begin
                    // (ind,X): Read high byte, form address
                    indirect_addr_hi <= data_in;
                    addr <= {data_in, indirect_addr_lo};
                    cycle_count <= 0;
                    if (opcode == 8'h81) begin
                        data_out <= A;
                        rw <= 0;  // Write for STA
                    end else begin
                        rw <= 1;  // Read for LDA/ORA/AND
                    end
                end else if ((opcode == 8'hB1 || opcode == 8'h91) && cycle_count == 2) begin
                    // (ind),Y: Read high byte, form address + Y
                    indirect_addr_hi <= data_in;
                    addr <= {data_in, indirect_addr_lo} + {8'b0, Y};
                    cycle_count <= 0;
                    if (opcode == 8'h91) begin
                        data_out <= A;
                        rw <= 0;  // Write for STA
                    end else begin
                        rw <= 1;  // Read for LDA
                    end
                end else if (opcode == 8'hA5 || opcode == 8'hAD || opcode == 8'hB5 || opcode == 8'hBD || opcode == 8'hB9 || opcode == 8'hA1 || opcode == 8'hB1) begin
                    A <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                    rw <= 1;
                end else if (opcode == 8'hA6 || opcode == 8'hB6 || opcode == 8'hAE) begin
                    X <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                    rw <= 1;
                end else if (opcode == 8'hA4 || opcode == 8'hB4) begin
                    Y <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                    rw <= 1;
                end else if (opcode == 8'h68) begin
                    A <= data_in;
                    Z <= (data_in == 0);
                    N <= data_in[7];
                    rw <= 1;
                end else if (opcode == 8'h28) begin
                    {N, V, B, D, I, Z, C} <= {data_in[7:6], data_in[4:0]};
                    rw <= 1;
                end else if (opcode == 8'h05) begin  // ORA zp
                    temp_result = A | data_in;
                    A <= temp_result;
                    Z <= (temp_result == 0);
                    N <= temp_result[7];
                    rw <= 1;
                end else if (opcode == 8'h01) begin  // ORA (ind,X)
                    temp_result = A | data_in;
                    A <= temp_result;
                    Z <= (temp_result == 0);
                    N <= temp_result[7];
                    rw <= 1;
                end else if (opcode == 8'h21) begin  // AND (ind,X)
                    temp_result = A & data_in;
                    A <= temp_result;
                    Z <= (temp_result == 0);
                    N <= temp_result[7];
                    rw <= 1;
                end else if (opcode == 8'h24) begin  // BIT zp
                    Z <= ((A & data_in) == 0);
                    N <= data_in[7];
                    V <= data_in[6];
                    rw <= 1;
                end else if (opcode == 8'h06) begin  // ASL zp
                    C <= data_in[7];
                    alu_result <= {data_in[6:0], 1'b0};
                    Z <= (data_in[6:0] == 0);
                    N <= data_in[6];
                    data_out <= {data_in[6:0], 1'b0};
                    rw <= 0;  // Write back
                end else if (opcode == 8'hC5) begin  // CMP zp
                    temp_result = A - data_in;
                    C <= (A >= data_in);
                    Z <= (A == data_in);
                    N <= temp_result[7];
                    rw <= 1;
                end else if (opcode == 8'hC4) begin  // CPY zp
                    temp_result = Y - data_in;
                    C <= (Y >= data_in);
                    Z <= (Y == data_in);
                    N <= temp_result[7];
                    rw <= 1;
                end else if (opcode == 8'h65 || opcode == 8'h75 || opcode == 8'h6D || opcode == 8'h7D || opcode == 8'h79) begin  // ADC
                    temp_sum = A + data_in + {8'b0, C};
                    C <= temp_sum[8];
                    A <= temp_sum[7:0];
                    Z <= (temp_sum[7:0] == 0);
                    N <= temp_sum[7];
                    V <= (A[7] == data_in[7]) && (A[7] != temp_sum[7]);
                    rw <= 1;
                end else if (opcode == 8'hE5 || opcode == 8'hF5 || opcode == 8'hED || opcode == 8'hFD || opcode == 8'hF9) begin  // SBC
                    temp_diff = A - data_in - {8'b0, !C};
                    C <= !temp_diff[8];
                    A <= temp_diff[7:0];
                    Z <= (temp_diff[7:0] == 0);
                    N <= temp_diff[7];
                    rw <= 1;
                end else if (opcode == 8'h85 || opcode == 8'h8D || 
                             opcode == 8'h86 || opcode == 8'h84 ||
                             opcode == 8'h95 || opcode == 8'h9D ||
                             opcode == 8'h96 || opcode == 8'h94) begin
                    // Store operations - keep rw=0
                end else if (opcode == 8'h2C) begin  // BIT abs
                    Z <= ((A & data_in) == 0);
                    N <= data_in[7];
                    V <= data_in[6];
                    rw <= 1;
                end else if (opcode == 8'hE6 || opcode == 8'hF6 || opcode == 8'hEE || opcode == 8'hFE) begin  // INC
                    temp_result = data_in + 1;
                    data_out <= temp_result;
                    Z <= (temp_result == 0);
                    N <= temp_result[7];
                    rw <= 0;  // Write back
                end else if (opcode == 8'hC6 || opcode == 8'hD6 || opcode == 8'hCE || opcode == 8'hDE) begin  // DEC
                    temp_result = data_in - 1;
                    data_out <= temp_result;
                    Z <= (temp_result == 0);
                    N <= temp_result[7];
                    rw <= 0;  // Write back
                end else if (opcode == 8'h26 || opcode == 8'h36 || opcode == 8'h2E || opcode == 8'h3E) begin  // ROL
                    temp_result = {data_in[6:0], C};
                    C <= data_in[7];
                    data_out <= temp_result;
                    Z <= (temp_result == 0);
                    N <= temp_result[7];
                    rw <= 0;  // Write back
                end else if (opcode == 8'h66 || opcode == 8'h76 || opcode == 8'h6E || opcode == 8'h7E) begin  // ROR
                    temp_result = {C, data_in[7:1]};
                    C <= data_in[0];
                    data_out <= temp_result;
                    Z <= (temp_result == 0);
                    N <= temp_result[7];
                    rw <= 0;  // Write back
                end
            end
            
            WRITEBACK: begin
                rw <= 1;
            end
            
            NMI_HANDLER: begin
                case (nmi_cycle)
                    0: begin  // Push PCH
                        addr <= {8'h01, SP};
                        data_out <= PC[15:8];
                        rw <= 0;
                        SP <= SP - 1;
                        nmi_cycle <= 1;
                    end
                    1: begin  // Push PCL
                        addr <= {8'h01, SP};
                        data_out <= PC[7:0];
                        rw <= 0;
                        SP <= SP - 1;
                        nmi_cycle <= 2;
                    end
                    2: begin  // Push status
                        addr <= {8'h01, SP};
                        data_out <= {N, V, 1'b1, B, D, I, Z, C};
                        rw <= 0;
                        SP <= SP - 1;
                        nmi_cycle <= 3;
                    end
                    3: begin  // Read NMI vector low
                        addr <= 16'hFFFA;
                        rw <= 1;
                        nmi_cycle <= 4;
                    end
                    4: begin  // Read NMI vector high
                        PC[7:0] <= data_in;
                        addr <= 16'hFFFB;
                        rw <= 1;
                        nmi_cycle <= 5;
                    end
                    5: begin  // Jump to NMI handler
                        PC[15:8] <= data_in;
                        nmi_cycle <= 0;
                        nmi_pending <= 0;
                        I <= 1;  // Disable interrupts
                    end
                endcase
            end
        endcase
    end
end

// Next state logic
always_comb begin
    case (state)
        RESET: begin
            if (cycle_count == 2) next_state = FETCH;
            else next_state = RESET;
        end
        FETCH: begin
            if (nmi_pending) next_state = NMI_HANDLER;
            else next_state = DECODE;
        end
        DECODE: next_state = EXECUTE;
        EXECUTE: begin
            // Check if memory access needed
            if ((opcode[1:0] == 2'b01 && opcode[4:2] != 3'b100) ||  // Load instructions
                (opcode == 8'h85 || opcode == 8'h8D || opcode == 8'h95 || opcode == 8'h9D ||  // STA
                 opcode == 8'h86 || opcode == 8'h96 ||               // STX
                 opcode == 8'h84 || opcode == 8'h94 ||               // STY
                 opcode == 8'hA5 || opcode == 8'hAD || opcode == 8'hB5 || opcode == 8'hBD || opcode == 8'hB9 ||  // LDA
                 opcode == 8'hA6 || opcode == 8'hB6 || opcode == 8'hAE ||  // LDX
                 opcode == 8'hA4 || opcode == 8'hB4 ||               // LDY
                 opcode == 8'h05 || opcode == 8'h24 || opcode == 8'h2C || opcode == 8'h06 ||  // ORA zp, BIT, ASL zp
                 opcode == 8'hC5 || opcode == 8'hC4 ||               // CMP zp, CPY zp
                 opcode == 8'h65 || opcode == 8'h75 || opcode == 8'h6D || opcode == 8'h7D || opcode == 8'h79 ||  // ADC
                 opcode == 8'hE5 || opcode == 8'hF5 || opcode == 8'hED || opcode == 8'hFD || opcode == 8'hF9 ||  // SBC
                 opcode == 8'hE6 || opcode == 8'hF6 || opcode == 8'hEE || opcode == 8'hFE ||  // INC
                 opcode == 8'hC6 || opcode == 8'hD6 || opcode == 8'hCE || opcode == 8'hDE ||  // DEC
                 opcode == 8'h26 || opcode == 8'h36 || opcode == 8'h2E || opcode == 8'h3E ||  // ROL
                 opcode == 8'h66 || opcode == 8'h76 || opcode == 8'h6E || opcode == 8'h7E ||  // ROR
                 opcode == 8'hA1 || opcode == 8'hB1 ||               // LDA (ind,X), LDA (ind),Y
                 opcode == 8'h81 || opcode == 8'h91 ||               // STA (ind,X), STA (ind),Y
                 opcode == 8'h01 || opcode == 8'h21)) begin          // ORA (ind,X), AND (ind,X)
                next_state = MEMORY;
            end else begin
                next_state = FETCH;
            end
        end
        MEMORY: begin
            // Stay in MEMORY for multi-cycle indirect addressing
            if (cycle_count > 0) next_state = MEMORY;
            else next_state = WRITEBACK;
        end
        WRITEBACK: next_state = FETCH;
        NMI_HANDLER: begin
            if (nmi_cycle == 5) next_state = FETCH;
            else next_state = NMI_HANDLER;
        end
        default: next_state = FETCH;
    endcase
end

endmodule
