#include "Vcpu_instruction_test.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);
    
    Vcpu_instruction_test* top = new Vcpu_instruction_test;
    
    // Optional VCD trace
    VerilatedVcdC* tfp = nullptr;
    if (argc > 1 && std::string(argv[1]) == "--trace") {
        tfp = new VerilatedVcdC;
        top->trace(tfp, 99);
        tfp->open("cpu_test.vcd");
    }
    
    // Run simulation - let SystemVerilog $finish control exit
    while (!Verilated::gotFinish() && main_time < 1000000) {
        top->eval();
        if (tfp) tfp->dump(main_time);
        main_time++;
    }
    
    if (tfp) {
        tfp->close();
        delete tfp;
    }
    
    delete top;
    return 0;
}
