//`include "types_pkg.svh"
import types_pkg::*;

interface reg_file_if(
						  input data_t rd1,
						  input data_t rd2,
						  input data_t wd,
						  input reg_t  rn1,
						  input reg_t  rn2,
						  input reg_t  wn,
						  input logic  wen,
						  input logic  clk,
						  input logic  rstn
						 );

endinterface