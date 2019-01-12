`timescale 1ns / 1ps
`include "../defines/PARAMETERS.vh"
`include "../defines/OPCODES_DEFINES.vh"

module IMM_GENERATOR(
    output [`WORD_SIZE-1:0] o_ExtendedImmediate,
    input [`WORD_SIZE-1:0] i_Instruction
    );

	reg [`WORD_SIZE-1:0] ExtendedImmediate;

	/*
	- Immediate Generator V1:
	- I did this parte like this before the U-Type insctructions implementation.

	reg [11:0] imm;
	
	always @(*) begin
		case(i_Instruction[6:0])
			`OP_I_TYPE   : imm = i_Instruction[31:20];
			`OP_I_L_TYPE : imm = i_Instruction[31:20];
			`OP_S_TYPE   : imm = {i_Instruction[31:25], i_Instruction[11:7]};
			`OP_B_TYPE   : imm = {i_Instruction[31], i_Instruction[7], i_Instruction[30:25], i_Instruction[11:8]};
			default      : imm = 12'bx;
		endcase
	end

	assign o_ExtendedImmediate = {{20{imm[11]}}, imm[11:0]};
	*/

	/*
	- Immediate Generator V2:
	- I did this parte like this to implement the U-Type insctructions. With this form
	-there is just one register instead of two.
	*/

	always @(*) begin
		case(i_Instruction[6:0])
			`OP_I_TYPE   : ExtendedImmediate = {{20{i_Instruction[31]}}, i_Instruction[31:20]};
			`OP_I_L_TYPE : ExtendedImmediate = {{20{i_Instruction[31]}}, i_Instruction[31:20]};
			`OP_S_TYPE   : ExtendedImmediate = {{20{i_Instruction[31]}}, i_Instruction[31:25], i_Instruction[11:7]};
			`OP_B_TYPE   : ExtendedImmediate = {{20{i_Instruction[31]}}, i_Instruction[31], i_Instruction[7], i_Instruction[30:25], i_Instruction[11:8]};
			`OP_LUI	     : ExtendedImmediate = {{12{i_Instruction[31]}}, i_Instruction[31:12]};
			`OP_AUIPC    : ExtendedImmediate = {{12{i_Instruction[31]}}, i_Instruction[31:12]};
			default      : ExtendedImmediate = 32'bx;
		endcase
	end

	assign o_ExtendedImmediate = ExtendedImmediate;

endmodule
