`timescale 1ns / 1ps
`define R_TEST//Read Test
`define W_TEST//Write Test

module DATA_MEMORY_tb;
	parameter HEIGHT = 256;//Memory height
	parameter FILE = "test.r32i";
	// Inputs
	reg [31:0] i_Wd;
	reg [31:0] i_Addr;
	reg i_Wen;
	reg i_Ren;
	reg i_clk;

	// Outputs
	wire [31:0] o_Rd;

	// Instantiate the Unit Under Test (UUT)
	DATA_MEMORY uut (
		.o_Rd(o_Rd), 
		.i_Wd(i_Wd), 
		.i_Addr(i_Addr), 
		.i_Wen(i_Wen), 
		.i_Ren(i_Ren), 
		.i_clk(i_clk)
	);

	integer i;
	reg [7:0] mem_test [HEIGHT-1:0];//Test Memory
	reg [31:0] Rd_test;//Test Rd

	initial begin
		$readmemh(FILE, mem_test);//Initialize Memory
		i_Wd = 0;
		i_Addr = 0;
		i_Wen = 0;
		i_Ren = 0;
		i_clk = 0;

		`ifdef R_TEST
		i_Ren = 1;
		for(i=0;i<HEIGHT/4;i = i+1) begin
			Rd_test = {mem_test[i_Addr+3], mem_test[i_Addr+2], mem_test[i_Addr+1], mem_test[i_Addr]};//Compose data read
			#10;
			if(o_Rd != Rd_test) begin
				$display("Interaction: ", i);
				$display("Read TEST: %B",Rd_test, "  Read: %B", o_Rd);
				$display("ERROR");
				$finish;
			end
			i_Addr = i_Addr+4;//Increment Addr
		end
		i_Ren = 0;
		i_Addr = 0;
		`endif

		`ifdef W_TEST
		for(i=0;i<HEIGHT/4;i = i+1) begin
			i_Wen = 1;
			i_Wd = $random%32;
			#10;
			i_Wen = 0;
			i_Ren = 1;
			#10;
			if(i_Wd !== o_Rd) begin
				$display("ERROR");
				$finish;
			end
			i_Ren = 0;
			i_Addr = i_Addr+4;//Increment Addr
		end
		`endif
		$finish;

	end  
    always begin
		#5 i_clk = ~i_clk;
	end

endmodule

