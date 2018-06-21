`timescale 1ns / 1ps

/*
		This module was built based on the Appendix A.7 of the COMPUTER ORGANIZATION AND DESIGN RISC-V EDITION book.
		In this way, when the reading of a register occurs in the same clock cycle that the writing in the same register, the returned value
	will be the value written in the earlier clock cycle.
		However, it's possible make changes to change this behavior.
*/

module REGISTER_FILE(
    output [31:0] o_Rd1,
    output [31:0] o_Rd2,
    input [4:0] i_Rnum1,
    input [4:0] i_Rnum2,
    input i_Wen,
    input [4:0] i_Wnum,
    input [31:0] i_Wd,
    input i_clk
    );

	reg [31:0] x [31:0];//Registers [x0-x31]

	//Reading is combinational
	assign o_Rd1 = |i_Rnum1 ? x[i_Rnum1] : 0;
	assign o_Rd2 = |i_Rnum2 ? x[i_Rnum2] : 0;

	//Writing occurs just in the positive edge clk;
	always @(posedge i_clk) begin
		if (i_Wen) begin
			x[i_Wnum] = i_Wd;
		end
	end

endmodule
