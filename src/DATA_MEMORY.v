//@TODO: Fix it
module DATA_MEMORY(
    output [`WORD_SIZE-1:0] o_Rd,
    input  [`WORD_SIZE-1:0] i_Wd,
    input  [`WORD_SIZE-1:0] i_Addr,
    input  i_Wen,
    input  i_Ren,
    input  i_clk
    );

	parameter HEIGHT = `DM_DEPTH;//Memory height
	parameter FILE = `DM_FILE;

	reg [`WORD_SIZE-1:0] mem [HEIGHT-1:0];//Memory: Word: 4byte

	initial begin
		$readmemh(FILE, mem);//Initialize Memory
	end

	//Just one signal must be enabled (Wen or Ren) in one clock period(That's my solution),
	//So, when the two signal are active, just the 'i_Wen' is considered.
	always @(posedge i_clk) begin
		if (i_Wen) begin
			//mem[i_Addr+3] <= i_Wd[31:24];
			//mem[i_Addr+2] <= i_Wd[23:16];
			//mem[i_Addr+1] <= i_Wd[15:8];
			//mem[i_Addr] <= i_Wd[7:0];
			mem[i_Addr>>2] <= i_Wd;
		end
	end
	//This is temporary just to ignore the verilator warning
	assign o_Rd = i_Ren ? mem[(i_Addr>>2)] : 32'bx;
	//assign o_Rd = {mem[i_Addr+3], mem[i_Addr+2], mem[i_Addr+1], mem[i_Addr]};


endmodule
