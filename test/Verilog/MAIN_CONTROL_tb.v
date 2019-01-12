`timescale 1ns / 1ps


//OPCodes
`define OP_R_TYPE 7'b0110011
`define OP_I_TYPE 7'b0010011
`define OP_I_L_TYPE 7'b0000011
`define OP_S_TYPE 7'b0100011
`define OP_B_TYPE 7'b1100011

module MAIN_CONTROL_tb;

	// Inputs
	reg [6:0] i_OPCode;

	// Outputs
	wire o_Branch;
	wire o_MemRead;
	wire o_MemWrite;
	wire o_MemToReg;
	wire [1:0] o_ALUOp;
	wire o_ALUSrc;
	wire o_RegWrite;

	// Instantiate the Unit Under Test (UUT)
	MAIN_CONTROL uut (
		.o_Branch(o_Branch), 
		.o_MemRead(o_MemRead), 
		.o_MemWrite(o_MemWrite), 
		.o_MemToReg(o_MemToReg), 
		.o_ALUOp(o_ALUOp), 
		.o_ALUSrc(o_ALUSrc), 
		.o_RegWrite(o_RegWrite), 
		.i_OPCode(i_OPCode)
	);

	initial begin
		#1;
		i_OPCode = `OP_R_TYPE;
		#1;
		i_OPCode = `OP_I_TYPE;
		#1;
		i_OPCode = `OP_I_L_TYPE;
		#1;
		i_OPCode = `OP_S_TYPE;
		#1;
		i_OPCode = `OP_B_TYPE;
		#1;
		$finish;

	end
      
endmodule

