`timescale 1ns / 1ps
`include "../defines/OPCODES_DEFINES.vh"

module MAIN_CONTROL(
    output reg o_Branch,
    output reg o_MemRead,
    output reg o_MemWrite,
    output reg o_MemToReg,
    output reg [1:0] o_ALUOp,
    output reg o_ALUSrc,
    output reg o_RegWrite,
    input [6:0] i_OPCode
    );

	always @(*) begin

		case(i_OPCode)
			`OP_R_TYPE : begin
				o_Branch = 0;
				o_MemRead = 0;
				o_MemWrite = 0;
				o_MemToReg = 0;
				o_ALUSrc = 0;
				o_RegWrite = 1;
				o_ALUOp = 2'b10;
			end

			`OP_I_TYPE : begin
				o_Branch = 0;
				o_MemRead = 0;
				o_MemWrite = 0;
				o_MemToReg = 0;
				o_ALUSrc = 1;
				o_RegWrite = 1;
				o_ALUOp = 2'b11;
			end

			`OP_I_L_TYPE : begin
				o_Branch = 0;
				o_MemRead = 1;
				o_MemWrite = 0;
				o_MemToReg = 1;
				o_ALUSrc = 1;
				o_RegWrite = 1;
				o_ALUOp = 2'b00;
			end

			`OP_S_TYPE : begin
				o_Branch = 0;
				o_MemRead = 0;
				o_MemWrite = 1;
				o_MemToReg = 1'bx; //Don't Care
				o_ALUSrc = 1;
				o_RegWrite = 0; 
				o_ALUOp = 2'b00;
			end

			`OP_B_TYPE : begin
				o_Branch = 1;
				o_MemRead = 0;
				o_MemWrite = 0;
				o_MemToReg = 1'bx; //Don't Care
				o_ALUSrc = 0;
				o_RegWrite = 0; 
				o_ALUOp = 2'b01;
			end

			default : begin
				o_Branch = 1'bx;
				o_MemRead = 1'bx;
				o_MemWrite = 1'bx;
				o_MemToReg = 1'bx; //Don't Care
				o_ALUSrc = 1'bx;
				o_RegWrite = 1'bx; 
				o_ALUOp = 2'bx;
			end

		endcase
	end

endmodule
