module MAIN_CONTROL(
    output logic o_Branch,
    output logic o_MemRead,
    output logic o_MemWrite,
    output logic o_MemToReg,
    output logic [2:0] o_ALUOp,
    output logic o_ALUSrc1,
    output logic o_ALUSrc2,
    output logic o_RegWrite,
    input  [6:0] i_OPCode
    );

	always @(*) begin

		case(i_OPCode)
			`OP_R_TYPE : begin
				o_Branch   = 1'b0;
				o_MemRead  = 1'b0;
				o_MemWrite = 1'b0;
				o_MemToReg = 1'b0;
				o_ALUSrc1  = 1'b0;
				o_ALUSrc2  = 1'b0;
				o_RegWrite = 1'b1;
				o_ALUOp    = 3'b010;
			end

			`OP_I_TYPE : begin
				o_Branch   = 1'b0;
				o_MemRead  = 1'b0;
				o_MemWrite = 1'b0;
				o_MemToReg = 1'b0;
				o_ALUSrc1  = 1'b0;
				o_ALUSrc2  = 1'b1;
				o_RegWrite = 1'b1;
				o_ALUOp    = 3'b011;
			end

			`OP_I_L_TYPE : begin
				o_Branch   = 1'b0;
				o_MemRead  = 1'b1;
				o_MemWrite = 1'b0;
				o_MemToReg = 1'b1;
				o_ALUSrc1  = 1'b0;
				o_ALUSrc2  = 1'b1;
				o_RegWrite = 1'b1;
				o_ALUOp    = 3'b000;
			end

			`OP_S_TYPE : begin
				o_Branch   = 1'b0;
				o_MemRead  = 1'b0;
				o_MemWrite = 1'b1;
				o_MemToReg = 1'b0;
				o_ALUSrc1  = 1'b0;
				o_ALUSrc2  = 1'b1;
				o_RegWrite = 1'b0; 
				o_ALUOp    = 3'b000;
			end

			`OP_B_TYPE : begin
				o_Branch   = 1'b1;
				o_MemRead  = 1'b0;
				o_MemWrite = 1'b0;
				o_MemToReg = 1'b0;
				o_ALUSrc1  = 1'b0;
				o_ALUSrc2  = 1'b0;
				o_RegWrite = 1'b0; 
				o_ALUOp    = 3'b001;
			end

			`OP_LUI : begin
				o_Branch   = 1'b0;
				o_MemRead  = 1'b0;
				o_MemWrite = 1'b0;
				o_MemToReg = 1'b0;
				o_ALUSrc1  = 1'b0;
				o_ALUSrc2  = 1'b1;
				o_RegWrite = 1'b1; 
				o_ALUOp    = 3'b100;
			end

			`OP_AUIPC : begin
				o_Branch   = 1'b0;
				o_MemRead  = 1'b0;
				o_MemWrite = 1'b0;
				o_MemToReg = 1'b0;
				o_ALUSrc1  = 1'b1;
				o_ALUSrc2  = 1'b1;
				o_RegWrite = 1'b1; 
				o_ALUOp    = 3'b101;
			end

			default : begin
				o_Branch   = 1'b0;
				o_MemRead  = 1'b0;
				o_MemWrite = 1'b0;
				o_MemToReg = 1'b0;
				o_ALUSrc1  = 1'b0;
				o_ALUSrc2  = 1'b0;
				o_RegWrite = 1'b0; 
				o_ALUOp    = 3'b0;
			end

		endcase
	end

endmodule
