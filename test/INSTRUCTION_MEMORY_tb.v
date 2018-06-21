`timescale 1ns / 1ps

module INSTRUCTION_MEMORY_tb;
	parameter HEIGHT = 256;
	parameter FILE = "test.r32i";
	// Inputs
	reg [31:0] i_Addr;

	// Outputs
	wire [31:0] o_Instruction;

	// Instantiate the Unit Under Test (UUT)
	INSTRUCTION_MEMORY #(HEIGHT)uut (
		.o_Instruction(o_Instruction), 
		.i_Addr(i_Addr)
	);

	integer i;
	reg [7:0] mem_test [HEIGHT-1:0];//Test Memory
	reg [31:0] instruction_test;//Test Instruction
	initial begin
		$readmemh(FILE, mem_test);//Initialize Memory
		i_Addr = 0;
		for(i=0;i<HEIGHT/4;i = i+1) begin
			instruction_test = {mem_test[i_Addr+3], mem_test[i_Addr+2], mem_test[i_Addr+1], mem_test[i_Addr]};//Compose Instruction
			if(o_Instruction != instruction_test) begin
				$display("Interaction: ", i);
				$display("Instruction TEST: %B",instruction_test, "  Instruction: %B", o_Instruction);
				$display("ERROR");
				$finish;
			end
			i_Addr = i_Addr+4;//Increment Addr
			#1;
		end
		$finish;
	end
      
endmodule

