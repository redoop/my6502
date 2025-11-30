#include "Vnes_module_test.h"
#include "verilated.h"

vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Vnes_module_test* top = new Vnes_module_test;
    
    while (!Verilated::gotFinish() && main_time < 200000000) {
        top->eval();
        main_time++;
    }
    
    delete top;
    return 0;
}
