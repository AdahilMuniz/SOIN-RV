`timescale 1ns / 1ps

//@TODO: Create test logic;
module DATA_MEMORY_tb;

	// Inputs
	reg [31:0] Wd;
	reg [31:0] Addr;
	reg Wen;
	reg Ren;
	reg clk;

	// Outputs
	wire [31:0] Rd;

	// Instantiate the Unit Under Test (UUT)
	DATA_MEMORY uut (
		.Rd(Rd), 
		.Wd(Wd), 
		.Addr(Addr), 
		.Wen(Wen), 
		.Ren(Ren), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		Wd = 0;
		Addr = 0;
		Wen = 0;
		Ren = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

