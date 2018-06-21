`timescale 1ns / 1ps

//@TODO: Test

module DATA_MEMORY(
    output reg [31:0] o_Rd,
    input [31:0] i_Wd,
    input [31:0] i_Addr,
    input i_Wen,
    input i_Ren,
    input i_clk
    );

	parameter HEIGHT = 256;//Memory height

	reg [7:0] mem [HEIGHT:0];//Memory: Word: 4byte

	`ifdef TEST
	//This block is used for tests
	initial begin
		$readmemh("test.r32i", mem);//Initialize Memory
	end
	`endif

	//Just one signal must be enabled (Wen or Ren) in one clock period(That's my solution)
	always @(posedge i_clk) begin
		if (i_Wen) begin
			mem[i_Addr] <= i_Wd;
		end
		else if(i_Ren) begin
			o_Rd <= mem[i_Addr];
		end
	end



endmodule
