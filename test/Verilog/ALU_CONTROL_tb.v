`timescale 1ns / 1ps

/*
	This testbench is just for visualization.
*/

module ALU_CONTROL_tb;

	// Inputs
	reg [6:0] i_Funct7;
	reg [2:0] i_Funct3;
	reg [1:0] i_ALUOp;

	// Outputs
	wire [3:0] o_ALUControlLines;

	// Instantiate the Unit Under Test (UUT)
	ALU_CONTROL uut (
		.o_ALUControlLines(o_ALUControlLines), 
		.i_Funct7(i_Funct7), 
		.i_Funct3(i_Funct3), 
		.i_ALUOp(i_ALUOp)
	);


	integer i,j;

	initial begin
		#1;
		i_Funct7 = 0;
		for (i=0;i<8;i=i+1)begin
			i_Funct3 = i;
			for (j=0;j<3;j=j+1) begin
				i_ALUOp = j;
				#1;
			end
		end

		i_Funct7 = 32;
		for (i=0;i<8;i=i+1)begin
			i_Funct3 = i;
			for (j=0;j<3;j=j+1) begin
				i_ALUOp = j;
				#1;
			end
		end

		$finish;
	end
      
endmodule

