`timescale 1ns / 1ps

`include "../defines/OPCODES_DEFINES.vh"
`include "../defines/ALU_CONTROL.vh"

//ALUOp
`define ALUOP_I_L   3'b000
`define ALUOP_B     3'b001
`define ALUOP_R     3'b010
`define ALUOP_I     3'b011
`define ALUOP_LUI   3'b100
`define ALUOP_AUIPC 3'b101

module ALU_CONTROL(
    output reg [3:0] o_ALUControlLines,
    input [6:0] i_Funct7,
    input [2:0] i_Funct3,
    input [2:0] i_ALUOp
    );

	always @(*) begin
		case(i_ALUOp)
			`ALUOP_I_L : o_ALUControlLines = `ALU_ADD;
			`ALUOP_B :  o_ALUControlLines = `ALU_SUB;
			`ALUOP_R :
				case(i_Funct3)
					`F3_TYPE0 : 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines = `ALU_ADD;
							`F7_TYPE32 : o_ALUControlLines = `ALU_SUB;
							default : o_ALUControlLines = 4'bx;
						endcase
					`F3_TYPE1: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines = `ALU_SLL;
							default : o_ALUControlLines = 4'bx;
						endcase
					`F3_TYPE2: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines = `ALU_SLT;
							default : o_ALUControlLines = 4'bx;
						endcase
					`F3_TYPE3: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines = `ALU_SLTU;
							default : o_ALUControlLines = 4'bx;
						endcase
					`F3_TYPE4: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines = `ALU_XOR;
							default : o_ALUControlLines = 4'bx;
						endcase
					`F3_TYPE5: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines = `ALU_SRL;
							`F7_TYPE32 : o_ALUControlLines = `ALU_SRA;
							default : o_ALUControlLines = 4'bx;
						endcase
					`F3_TYPE6: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines = `ALU_OR;
							default : o_ALUControlLines = 4'bx;
						endcase
					`F3_TYPE7: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines = `ALU_AND;
							default : o_ALUControlLines = 4'bx;
						endcase
					default : o_ALUControlLines = 4'bx;
				endcase
			`ALUOP_I :
				case(i_Funct3)
					`F3_TYPE0: o_ALUControlLines = `ALU_ADD;
					`F3_TYPE1: o_ALUControlLines = `ALU_SLL;					
					`F3_TYPE2: o_ALUControlLines = `ALU_SLT;					
					`F3_TYPE3: o_ALUControlLines = `ALU_SLTU;				
					`F3_TYPE4: o_ALUControlLines = `ALU_XOR;
					`F3_TYPE5: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines = `ALU_SRL;
							`F7_TYPE32: o_ALUControlLines = `ALU_SRA;
						endcase
											
					`F3_TYPE6: o_ALUControlLines = `ALU_OR;				
					`F3_TYPE7: o_ALUControlLines = `ALU_AND;
					default : o_ALUControlLines = 4'bx;
				endcase
			`ALUOP_LUI : o_ALUControlLines = `ALU_LUI;
			default : o_ALUControlLines = 4'bx;
		endcase
	end


endmodule
