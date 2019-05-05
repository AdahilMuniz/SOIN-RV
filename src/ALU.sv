//@TODO:
// - To use one single adder for ADD, SUB, SLT and AUIPC;

module ALU(
	output data_t o_Result,
	output o_Zero,
	input  [3:0] i_Operation,
	input  data_t i_Op1,
	input  data_t i_Op2
    );



	always @(*) begin
		case (i_Operation)
			`ALU_ADD   : o_Result = i_Op1 + i_Op2;
			`ALU_SUB   : o_Result = i_Op1 - i_Op2;
			`ALU_SLL   : o_Result = i_Op1 << i_Op2[4:0];
			`ALU_SLT   : o_Result = {{`WORD_SIZE-1{1'b0}},$signed(i_Op1) < $signed(i_Op2)};
			`ALU_SLTU  : o_Result = {{`WORD_SIZE-1{1'b0}},i_Op1 < i_Op2};
			`ALU_XOR   : o_Result = i_Op1 ^ i_Op2;
			`ALU_SRL   : o_Result = i_Op1 >> i_Op2[4:0];
			`ALU_SRA   : o_Result = i_Op1 >>> i_Op2[4:0];
			`ALU_OR    : o_Result = i_Op1 | i_Op2;
			`ALU_AND   : o_Result = i_Op1 & i_Op2;
			`ALU_LUI   : o_Result = {i_Op2[19:0], {12{1'b0}}};
			`ALU_AUIPC : o_Result = {i_Op2[19:0], {12{1'b0}}} + i_Op1;
			default    : o_Result = 32'bx;
		endcase
	end
	
	assign o_Zero = o_Result == 0;

endmodule
