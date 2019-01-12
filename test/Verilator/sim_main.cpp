#include "VDATAPATH.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
  int i;
  int clk;
  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  VDATAPATH* top = new VDATAPATH;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("datapath.vcd");
  // initialize simulation inputs
  top->i_clk = 1;
  // run simulation for 100 clock periods
  for (i=0; i<20; i++) {
    // dump variables into VCD file and toggle clock
    for (clk=0; clk<2; clk++) {
      tfp->dump (2*i+clk);
      top->i_clk = !top->i_clk;
      top->eval ();
    }
    if (Verilated::gotFinish())  exit(0);
  }
  tfp->close();
  exit(0);
}