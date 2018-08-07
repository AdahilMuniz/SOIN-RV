`timescale 1ns / 1ps

`include "../defines/PARAMETERS.vh"

module DATAPATH_tb;

	//Inputs
	reg i_clk;

	DATAPATH uut (
		.i_clk(i_clk)
	);

	initial begin
		i_clk = 0;
		#100;
	end
	always begin
		#5 i_clk = ~i_clk;
	end
      
endmodule

