`timescale 1ns / 1ps
`define TEST
//`define TEST_FILE//Test using the file functions

//@TODO: Initialize memory with file functions

module INSTRUCTION_MEMORY(
    output [31:0] o_Instruction,
    input [31:0] i_Addr
    );

	parameter HEIGHT = 256;//Memory height
	parameter FILE = "test2.r32i";

	reg [7:0] mem [HEIGHT-1:0];//Memory: Word: 1byte

	`ifdef TEST
	//This block is used for tests
	`ifdef TEST_FILE
	integer file;
	integer i, c = 0;
	`endif
	initial begin
		
		$readmemh(FILE, mem);//Initialize Memory
		`ifdef TEST_FILE
		file = $fopen(FILE, "r");
		c = $fgetc(file);
		while($feof(file)) begin
			mem[i] = c;
			i = i+1;
			c = $fgetc(file);
		end
		`endif
	end
	`endif

	assign o_Instruction = {mem[i_Addr+3], mem[i_Addr+2], mem[i_Addr+1], mem[i_Addr]};//One instruction has 32 bits



endmodule
