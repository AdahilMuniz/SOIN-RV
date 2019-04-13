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

	always @(posedge i_clk) begin
		if (i_Wen) begin
			mem[i_Addr>>2] <= i_Wd;
		end
	end
	
	assign o_Rd = i_Ren ? mem[(i_Addr>>2)] : 32'bx;


endmodule
