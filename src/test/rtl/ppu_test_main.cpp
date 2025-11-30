#include "Vppu_test.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);
    
    Vppu_test* top = new Vppu_test;
    
    VerilatedVcdC* tfp = nullptr;
    if (argc > 1 && std::string(argv[1]) == "--trace") {
        tfp = new VerilatedVcdC;
        top->trace(tfp, 99);
        tfp->open("ppu_test.vcd");
    }
    
    // Run simulation
    while (!Verilated::gotFinish() && main_time < 20000000) {
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
