`timescale 1ns / 1ps

	//ALU Control Lines
	`define ALU_ADD  4'b0000
	`define ALU_SUB  4'b1000
	`define ALU_SLL  4'b0001
	`define ALU_SLT  4'b0010
	`define ALU_SLTU 4'b0011
	`define ALU_XOR  4'b0100
	`define ALU_SRL  4'b0101
	`define ALU_SRA  4'b1101
	`define ALU_OR   4'b0110
	`define ALU_AND  4'b0111	

	//Funct7
	`define F7_TYPE0 7'b0000000
	`define F7_TYPE32 7'b0100000

	//Funct3
	`define F3_TYPE0 3'b000
	`define F3_TYPE1 3'b001
	`define F3_TYPE2 3'b010
	`define F3_TYPE3 3'b011
	`define F3_TYPE4 3'b100
	`define F3_TYPE5 3'b101
	`define F3_TYPE6 3'b110
	`define F3_TYPE7 3'b111

	//ALUOp
	`define ALUOp_MEM 2'b00
	`define ALUOp_B 2'b01
	`define ALUOp_R 2'b10


module ALU_CONTROL(
    output reg [3:0] o_ALUControlLines,
    input [6:0] i_Funct7,
    input [2:0] i_Funct3,
    input [1:0] i_ALUOp
    );

	always @(*) begin
		case(i_ALUOp)
			`ALUOp_MEM : o_ALUControlLines <= `ALU_ADD;
			`ALUOp_B :  o_ALUControlLines <= `ALU_SUB;
			`ALUOp_R :
				case(i_Funct3)
					`F3_TYPE0 : 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines <= `ALU_ADD;
							`F7_TYPE32 : o_ALUControlLines <= `ALU_SUB;
						endcase
					`F3_TYPE1: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines <= `ALU_SLL;
						endcase
					`F3_TYPE2: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines <= `ALU_SLT;
						endcase
					`F3_TYPE3: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines <= `ALU_SLTU;
						endcase
					`F3_TYPE4: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines <= `ALU_XOR;
						endcase
					`F3_TYPE5: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines <= `ALU_SRL;
							`F7_TYPE32 : o_ALUControlLines <= `ALU_SRA;
						endcase
					`F3_TYPE6: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines <= `ALU_OR;
						endcase
					`F3_TYPE7: 
						case(i_Funct7)
							`F7_TYPE0 : o_ALUControlLines <= `ALU_AND;
						endcase
				endcase
		endcase
	end


endmodule
