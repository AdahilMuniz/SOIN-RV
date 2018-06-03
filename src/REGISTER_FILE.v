`timescale 1ns / 1ps

//@TODO: Make a define file;

module REGISTER_FILE(
    output [31:0] Rd1,
    output [31:0] Rd2,
    input [4:0] Rnum1,
    input [4:0] Rnum2,
    input Wen,
    input [4:0] Wnum,
    input [31:0] Wd,
    input clk
    );

	reg [31:0] x [31:0];//Registers [x0-x31]

	//Reading is combinational
	assign Rd1 = |Rnum1 ? x[Rnum1] : 0;
	assign Rd2 = |Rnum2 ? x[Rnum2] : 0;

	//Writing occurs just in the positive edge clk;
	always @(posedge clk) begin
		if (Wen) begin
			x[Wnum] = Wd;
		end
	end

endmodule

/*
		This module was built based on the Appendix A.7 of the COMPUTER ORGANIZATION AND DESIGN RISC-V EDITION book.
		In this way, when the reading of a register occurs in the same clock cycle that the writing in the same register, the returned value
	will be the value written in the earlier clock cycle.
		However, it's possible make changes to change this behavior.
*/
