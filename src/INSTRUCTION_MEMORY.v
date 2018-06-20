`timescale 1ns / 1ps
`define TEST

//@TODO: Make a define file;

module INSTRUCTION_MEMORY(
    output [31:0] Instruction,
    input [31:0] Addr
    );

	parameter HEIGHT = 256;//Memory height

	reg [7:0] mem [HEIGHT-1:0];//Memory: Word: 1byte

	`ifdef TEST
	//This block is used for tests
	initial begin
		$readmemh("test.r32i", mem);//Initialize Memory
	end
	`endif

	assign Instruction = {mem[Addr+3], mem[Addr+2], mem[Addr+1], mem[Addr]};//One instruction has 32 bit



endmodule
