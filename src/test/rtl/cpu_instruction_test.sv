// CPU 6502 Instruction Unit Tests
// Minimal test framework for verifying each instruction

module cpu_instruction_test;

// Clock and reset
logic clk = 0;
logic rst_n;
always #5 clk = ~clk;  // 10ns period

// CPU signals
logic [15:0] addr;
logic [7:0] data_in, data_out;
logic rw;

// Memory
logic [7:0] mem[0:65535];

// CPU instance (simplified interface)
cpu_6502 cpu (
    .clk(clk),
    .rst_n(rst_n),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out),
    .rw(rw),
    .nmi(1'b0),
    .irq(1'b0)
);

// Memory model
always_comb begin
    data_in = mem[addr];
end

always_ff @(posedge clk) begin
    if (!rw) mem[addr] <= data_out;
end

// Test utilities
task reset_cpu();
    rst_n = 0;
    repeat(5) @(posedge clk);
    rst_n = 1;
    repeat(10) @(posedge clk);
endtask

task load_program(input [7:0] prog[], input int size, input [15:0] start_addr);
    for (int i = 0; i < size; i++) begin
        mem[start_addr + i] = prog[i];
    end
    // Set reset vector
    mem[16'hFFFC] = start_addr[7:0];
    mem[16'hFFFD] = start_addr[15:8];
endtask

task run_cycles(input int n);
    repeat(n) @(posedge clk);
endtask

task check_register(input string name, input [7:0] expected, input [7:0] actual);
    if (expected !== actual) begin
        $display("FAIL: %s expected=$%02x actual=$%02x", name, expected, actual);
        $finish;
    end
endtask

// Test cases
initial begin
    $display("=== CPU 6502 Instruction Tests ===\n");
    
    // Test 1: LDA Immediate
    begin
        logic [7:0] prog[] = '{
            8'hA9, 8'h42,  // LDA #$42
            8'hEA          // NOP
        };
        $display("Test 1: LDA #$42");
        load_program(prog, 3, 16'hC000);
        reset_cpu();
        run_cycles(20);
        check_register("A", 8'h42, cpu.A);
        $display("  PASS\n");
    end
    
    // Test 2: LDA Zero Page
    begin
        logic [7:0] prog[] = '{
            8'hA5, 8'h10,  // LDA $10
            8'hEA          // NOP
        };
        $display("Test 2: LDA $10");
        mem[16'h0010] = 8'h55;
        load_program(prog, 3, 16'hC000);
        reset_cpu();
        run_cycles(20);
        check_register("A", 8'h55, cpu.A);
        $display("  PASS\n");
    end
    
    // Test 3: STA Zero Page
    begin
        logic [7:0] prog[] = '{
            8'hA9, 8'h33,  // LDA #$33
            8'h85, 8'h20,  // STA $20
            8'hEA          // NOP
        };
        $display("Test 3: STA $20");
        load_program(prog, 5, 16'hC000);
        reset_cpu();
        run_cycles(30);
        check_register("MEM[$20]", 8'h33, mem[16'h0020]);
        $display("  PASS\n");
    end
    
    // Test 4: ADC
    begin
        logic [7:0] prog[] = '{
            8'hA9, 8'h10,  // LDA #$10
            8'h69, 8'h05,  // ADC #$05
            8'hEA          // NOP
        };
        $display("Test 4: ADC #$05");
        load_program(prog, 5, 16'hC000);
        reset_cpu();
        run_cycles(30);
        check_register("A", 8'h15, cpu.A);
        $display("  PASS\n");
    end
    
    // Test 5: SBC
    begin
        logic [7:0] prog[] = '{
            8'h38,         // SEC
            8'hA9, 8'h20,  // LDA #$20
            8'hE9, 8'h08,  // SBC #$08
            8'hEA          // NOP
        };
        $display("Test 5: SBC #$08");
        load_program(prog, 6, 16'hC000);
        reset_cpu();
        run_cycles(40);
        check_register("A", 8'h18, cpu.A);
        $display("  PASS\n");
    end
    
    // Test 6: AND
    begin
        logic [7:0] prog[] = '{
            8'hA9, 8'hFF,  // LDA #$FF
            8'h29, 8'h0F,  // AND #$0F
            8'hEA          // NOP
        };
        $display("Test 6: AND #$0F");
        load_program(prog, 5, 16'hC000);
        reset_cpu();
        run_cycles(30);
        check_register("A", 8'h0F, cpu.A);
        $display("  PASS\n");
    end
    
    // Test 7: ORA
    begin
        logic [7:0] prog[] = '{
            8'hA9, 8'h0F,  // LDA #$0F
            8'h09, 8'hF0,  // ORA #$F0
            8'hEA          // NOP
        };
        $display("Test 7: ORA #$F0");
        load_program(prog, 5, 16'hC000);
        reset_cpu();
        run_cycles(30);
        check_register("A", 8'hFF, cpu.A);
        $display("  PASS\n");
    end
    
    // Test 8: Transfer TAX
    begin
        logic [7:0] prog[] = '{
            8'hA9, 8'h77,  // LDA #$77
            8'hAA,         // TAX
            8'hEA          // NOP
        };
        $display("Test 8: TAX");
        load_program(prog, 4, 16'hC000);
        reset_cpu();
        run_cycles(30);
        check_register("X", 8'h77, cpu.X);
        $display("  PASS\n");
    end
    
    // Test 9: INX
    begin
        logic [7:0] prog[] = '{
            8'hA2, 8'h05,  // LDX #$05
            8'hE8,         // INX
            8'hEA          // NOP
        };
        $display("Test 9: INX");
        load_program(prog, 4, 16'hC000);
        reset_cpu();
        run_cycles(30);
        check_register("X", 8'h06, cpu.X);
        $display("  PASS\n");
    end
    
    // Test 10: Branch BEQ
    begin
        logic [7:0] prog[] = '{
            8'hA9, 8'h00,  // LDA #$00 (sets Z flag)
            8'hF0, 8'h02,  // BEQ +2
            8'hA9, 8'hFF,  // LDA #$FF (skipped)
            8'hEA          // NOP (target)
        };
        $display("Test 10: BEQ (taken)");
        load_program(prog, 6, 16'hC000);
        reset_cpu();
        run_cycles(40);
        check_register("A", 8'h00, cpu.A);  // Should still be 0
        $display("  PASS\n");
    end
    
    $display("=== All Tests Passed! ===");
    $finish;
end

// Timeout
initial begin
    #100000;
    $display("ERROR: Test timeout!");
    $finish;
end

endmodule
