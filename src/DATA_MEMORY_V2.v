//@TODO: Fix it
/*
		This Data Memory version has a signal 'i_Wen' with 4 bits. The signal
	is used to select the byte or word/halfword of the memory that will be written.
*/

module DATA_MEMORY_V2(
    output reg [`WORD_SIZE-1:0] o_Rd,
    input [`WORD_SIZE-1:0] i_Wd,
    input [`WORD_SIZE-1:0] i_Addr,
    input [3:0]i_Wen,
    input i_Ren,
    input i_clk
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
			case(i_Wen) 
				4'b1000 : mem[i_Addr>>2][31:24] <= i_Wd[31:24];
				4'b0100 : mem[i_Addr>>2][23:16] <= i_Wd[23:16];
				4'b0010 : mem[i_Addr>>2][15:8] <= i_Wd[15:8];
				4'b0001 : mem[i_Addr>>2][7:0] <= i_Wd[7:0];
				default: 
					if (&i_Wen) begin
						mem[i_Addr>>2] <= i_Wd;
					end
					else if(&i_Wen[2:0]) begin
						mem[i_Addr>>2][23:0] <= i_Wd[23:0];
					end
					else if(&i_Wen[1:0]) begin
						mem[i_Addr>>2][15:0] <= i_Wd[15:0];
					end
			endcase
		end
		else if(i_Ren) begin
			o_Rd <= mem[i_Addr>>2];
		end
	end

endmodule
