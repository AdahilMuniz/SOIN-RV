`timescale 1ns / 1ps
`define TEST

//@TODO: Make a define file;

module INSTRUCTION_MEMORY(
    output [31:0] o_Instruction,
    input [31:0] i_Addr
    );

	parameter HEIGHT = 256;//Memory height

	reg [7:0] mem [HEIGHT-1:0];//Memory: Word: 1byte

	`ifdef TEST
	//This block is used for tests
	initial begin
		$readmemh("test.r32i", mem);//Initialize Memory
	end
	`endif

	assign o_Instruction = {mem[i_Addr+3], mem[i_Addr+2], mem[i_Addr+1], mem[i_Addr]};//One instruction has 32 bits



endmodule
