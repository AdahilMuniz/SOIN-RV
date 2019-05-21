module BRANCH_JUMP_CONTROL (
	output logic o_B_J_result,
	input  logic i_Branch,
	input  logic i_Jump,
	input  logic i_Zero,
	input  logic [2:0] i_Funct3
);

	always @(*) begin
		o_B_J_result = 1'b0;
		if(i_Branch) begin
			case (i_Funct3)
				`F3_TYPE0: o_B_J_result = i_Zero;
				`F3_TYPE1: o_B_J_result = ~i_Zero;
				default :  o_B_J_result = 1'b0;
			endcase
		end
		else if(i_Jump) begin
			o_B_J_result = 1'b1;
		end
	end

endmodule