import types_pkg::*;

interface memory_if(
					input data_t rdata, 
					input data_t wdata, 
					input data_t addr,
					input logic wen,
					input logic ren,
					input logic clk, 
					input logic rstn 
					);
endinterface