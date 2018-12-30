`timescale 1ns / 1ps

`include "../defines/OPCODES_DEFINES.vh"
`include "../defines/ALU_CONTROL.vh"
`include "../defines/PARAMETERS.vh"
//@TODO:
// - To use one single adder for ADD, SUB, SLT and AUIPC;
module ALU(
	output reg [`WORD_SIZE-1:0] o_Result,
	output o_Zero,
	input [3:0] i_Operation,
	input [`WORD_SIZE-1:0] i_Op1,
	input [`WORD_SIZE-1:0] i_Op2
    );



	always @(*) begin
		case (i_Operation)
			`ALU_ADD   : o_Result = i_Op1 + i_Op2;
			`ALU_SUB   : o_Result = i_Op1 - i_Op2;
			`ALU_SLL   : o_Result = i_Op1 << i_Op2[4:0];
			`ALU_SLT   : o_Result = $signed(i_Op1) < $signed(i_Op2);
			`ALU_SLTU  : o_Result = i_Op1 < i_Op2;
			`ALU_XOR   : o_Result = i_Op1 ^ i_Op2;
			`ALU_SRL   : o_Result = i_Op1 >> i_Op2[4:0];
			`ALU_SRA   : o_Result = i_Op1 >>> i_Op2[4:0];
			`ALU_OR    : o_Result = i_Op1 | i_Op2;
			`ALU_AND   : o_Result = i_Op1 & i_Op2;
			`ALU_LUI   : o_Result = {i_Op2<<12, {12{1'b0}}};
			`ALU_AUIPC : o_Result = {i_Op2<<12, {12{1'b0}}} + i_Op1;
			default    : o_Result = 32'bx;
		endcase
		/*
		if (o_Result == 0) begin
			o_Zero = 1'b1;
		end
		else begin
			o_Zero = 1'b0;
		end*/
	end
	
	assign o_Zero = o_Result ? 0:1;

endmodule
