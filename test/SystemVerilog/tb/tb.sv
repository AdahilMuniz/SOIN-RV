`timescale 1ns/1ps 
`define CLK_PERIOD 40 //25MHz

`define INST_MEM_PATH dut.instruction_memory

module tb;

	import tb_pkg::*;

	rv32i model;

	//Inputs
	reg i_clk;
	reg i_rstn;

	DATAPATH dut (
		.i_clk(i_clk),
		.i_rstn(i_rstn)
	);

	//initial begin
	//	model = new;
	//	forever begin
	//		if(~i_rstn) begin
	//			model.reset_model();
	//		end
	//		@(posedge i_clk);
	//		model.run_model();
	//	end
	//end

	always @(posedge i_clk or negedge i_rstn) begin
		if(~i_rstn) begin
			model.reset_model();
		end else begin
			model.run_model();
		end
	end

	initial begin
		model = new;
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

