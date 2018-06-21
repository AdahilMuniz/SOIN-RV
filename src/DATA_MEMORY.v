`timescale 1ns / 1ps
`define TEST

module DATA_MEMORY(
    output reg [31:0] o_Rd,
    input [31:0] i_Wd,
    input [31:0] i_Addr,
    input i_Wen,
    input i_Ren,
    input i_clk
    );

	parameter HEIGHT = 256;//Memory height
	parameter FILE = "test.r32i";

	reg [7:0] mem [HEIGHT-1:0];//Memory: Word: 4byte

	`ifdef TEST
	//This block is used for tests
	initial begin
		$readmemh(FILE, mem);//Initialize Memory
	end
	`endif

	//Just one signal must be enabled (Wen or Ren) in one clock period(That's my solution)
	always @(posedge i_clk) begin
		if (i_Wen) begin
			mem[i_Addr+3] <= i_Wd[31:24];
			mem[i_Addr] <= i_Wd[23:16];
			mem[i_Addr] <= i_Wd[15:8];
			mem[i_Addr] <= i_Wd[7:0];
		end
		else if(i_Ren) begin
			o_Rd <= {mem[i_Addr+3], mem[i_Addr+2], mem[i_Addr+1], mem[i_Addr]};
		end
	end



endmodule
