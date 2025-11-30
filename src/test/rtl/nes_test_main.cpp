#include "Vnes_unit_test.h"
#include "verilated.h"

vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    
    Vnes_unit_test* top = new Vnes_unit_test;
    
    // Run simulation
    while (!Verilated::gotFinish() && main_time < 100000000) {
        top->eval();
        main_time++;
    }
    
    delete top;
    return 0;
}
