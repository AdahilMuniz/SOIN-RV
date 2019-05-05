//@TODO: Fix it
module DATA_MEMORY(
    output data_t o_Rd,
    input  data_t i_Wd,
    input  addr_t i_Addr,
    input  i_Wen,
    input  i_Ren,
    input  i_clk
    );

	parameter HEIGHT = `DM_DEPTH;//Memory height
	parameter FILE = `DM_FILE;

	data_t mem [HEIGHT-1:0];//Memory: Word: 4byte

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
