`timescale 1ns/1ps 
`define CLK_PERIOD 40 //25MHz

module tb;

	//Inputs
	reg i_clk;
	reg i_rstn;

	DATAPATH dut (
		.i_clk(i_clk),
		.i_rstn(i_rstn)
	);

	initial begin
		i_clk = 1'b0;
	end

	//Clock generation
	always begin
		#(`CLK_PERIOD/2) i_clk = ~i_clk;
	end

	//Reset generation
	initial begin 
		#5;
		i_rstn <= 1'b0;
		#5;
		i_rstn <= 1'b1;
	end
      
endmodule

