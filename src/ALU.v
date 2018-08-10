`timescale 1ns / 1ps

`include "../defines/OPCODES_DEFINES.vh"
`include "../defines/ALU_CONTROL.vh"
`include "../defines/PARAMETERS.vh"

module ALU(
	output reg [`WORD_SIZE-1:0] o_Result,
	output o_Zero,
	input [3:0] i_Operation,
	input [`WORD_SIZE-1:0] i_Op1,
	input [`WORD_SIZE-1:0] i_Op2
    );



	always @(*) begin
		case (i_Operation)
			`ALU_ADD : o_Result = i_Op1 + i_Op2;
			`ALU_SUB : o_Result = i_Op1 - i_Op2;
			`ALU_SLL : o_Result = i_Op1 << i_Op2[4:0];
			`ALU_SLT : o_Result = $signed(i_Op1) < $signed(i_Op2);
			`ALU_SLTU: o_Result = i_Op1 < i_Op2;
			`ALU_XOR : o_Result = i_Op1 ^ i_Op2;
			`ALU_SRL : o_Result = i_Op1 >> i_Op2[4:0];
			`ALU_SRA : o_Result = i_Op1 >>> i_Op2[4:0];
			`ALU_OR  : o_Result = i_Op1 | i_Op2;
			`ALU_AND : o_Result = i_Op1 & i_Op2;
			default  : o_Result = 32'bx;
		endcase
	end


endmodule