`timescale 1ns / 1ps

//@TODO: Create test logic;
module DATA_MEMORY_tb;

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

	initial begin
		// Initialize Inputs
		i_Wd = 0;
		i_Addr = 0;
		i_Wen = 0;
		i_Ren = 0;
		i_clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

