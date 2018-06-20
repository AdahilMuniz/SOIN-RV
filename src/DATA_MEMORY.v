`timescale 1ns / 1ps

//@TODO: Test

module DATA_MEMORY(
    output reg [31:0] Rd,
    input [31:0] Wd,
    input [31:0] Addr,
    input Wen,
    input Ren,
    input clk
    );

	parameter HEIGHT = 256;//Memory height

	reg [31:0] mem [HEIGHT:0];//Memory: Word: 4byte

	//Just one signal must be enabled Wen or Ren in one clock period(That's my solution)
	always @(posedge clk) begin
		if (Wen) begin
			mem[Addr] <= Wd;
		end
		else if(Ren) begin
			Rd <= mem[Addr];
		end
	end



endmodule
