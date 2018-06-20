`timescale 1ns / 1ps

module INSTRUCTION_MEMORY_tb;
	parameter HEIGHT = 256;
	// Inputs
	reg [31:0] Addr;

	// Outputs
	wire [31:0] Instruction;

	// Instantiate the Unit Under Test (UUT)
	INSTRUCTION_MEMORY #(HEIGHT)uut (
		.Instruction(Instruction), 
		.Addr(Addr)
	);

	integer i;
	reg [7:0] mem_test [WIDTH-1:0];//Test Memory
	reg [31:0] instruction_test;//Test Instruction
	initial begin
		$readmemh("test.r32i", mem_test);//Initialize Memory
		Addr = 0;
		for(i=0;i<64;i = i+1) begin
			instruction_test = {mem_test[Addr+3], mem_test[Addr+2], mem_test[Addr+1], mem_test[Addr]};//Compose Instruction
			if(Instruction != instruction_test) begin
				$display("Interaction: ", i);
				$display("Instruction TESTE: %B",instruction_test, "  Instruction: %B", Instruction);
				$display("ERROR");
				$finish;
			end
			Addr = Addr+4;//Increment Addr
			#1;
		end
		$finish;
	end
      
endmodule

