import types_pkg::*;

interface memory_if(
					data_t rdata, 
					data_t wdata, 
					data_t addr,
					logic wen,
					logic ren,
					logic clk, 
					logic rstn 
					);


    modport monitor (input rdata, wdata, addr, wen, ren, clk, rstn);

    modport memory  (output rdata, input wdata, addr, wen, ren, clk, rstn);

endinterface