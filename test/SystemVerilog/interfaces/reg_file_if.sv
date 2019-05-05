import types_pkg::*;

interface reg_file_if(
						  data_t rd1,
						  data_t rd2,
						  data_t wd,
						  reg_t  rn1,
						  reg_t  rn2,
						  reg_t  wn,
						  logic  wen,
						  logic  clk,
						  logic  rstn
						 );

endinterface