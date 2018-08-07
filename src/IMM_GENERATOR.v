`timescale 1ns / 1ps
`include "../defines/OPCODES_DEFINES.vh"

module IMM_GENERATOR(
    output [31:0] o_ExtendedImmediate,
    input [31:0] i_Instruction
    );

	reg [11:0] imm;

	always @(*) begin
		case(i_Instruction[6:0])
			`OP_I_L_TYPE : imm = i_Instruction[31:20];
			`OP_S_TYPE   : imm = {i_Instruction[31:25], i_Instruction[11:7]};
			`OP_B_TYPE   : imm = {i_Instruction[31], i_Instruction[7], i_Instruction[30:25], i_Instruction[11:8]};
			default      : imm = 12'bx;
		endcase
	end

	assign o_ExtendedImmediate = {{20{imm[11]}}, imm[11:0]};


endmodule
