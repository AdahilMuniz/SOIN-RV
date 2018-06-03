`timescale 1ns / 1ps
`define INITIALIZE
`define R_TEST
//`define R_W_TEST

//@TODO: Review the Read and Write test;

module REGISTER_FILE_tb;

	// Inputs
	reg [4:0] Rnum1;
	reg [4:0] Rnum2;
	reg Wen;
	reg [4:0] Wnum;
	reg [31:0] Wd;
	reg clk;

	// Outputs
	wire [31:0] Rd1;
	wire [31:0] Rd2;

	// Instantiate the Unit Under Test (UUT)
	REGISTER_FILE uut (
		.Rd1(Rd1), 
		.Rd2(Rd2), 
		.Rnum1(Rnum1), 
		.Rnum2(Rnum2), 
		.Wen(Wen), 
		.Wnum(Wnum), 
		.Wd(Wd), 
		.clk(clk)
	);

	integer i,j;

	initial begin
		// Initialize Inputs
		
		clk = 0;

		`ifdef INITIALIZE
		Wen = 1;
		//Initilize registers(Write Test)
		for(i=1;i<32;i = i+1) begin
			Wnum = i;
			Wd = i;
			#10;
		end
		`endif

		`ifdef R_TEST
		Wen = 0;
		//Reading Test
		for(i=0;i<32;i = i+1) begin
			for(j=0;j<32;j=j+1) begin
				Rnum1 = i;
				Rnum2 = j;
				#10;
				if (Rd1 != i || Rd2 != j) begin
					$display("ERROR");
					$finish;
				end
			end
		end
		`endif

		`ifdef R_W_TEST
		Wen = 1;
		for(i=1;i<32;i = i+1) begin
			Wnum = i;
			j = i;//$random();
			Wd = j;
			Rnum1 = i;
			#10;
			if (Rd1 != j) begin
				$display("ERROR");
				$finish;
			end
		end
		`endif
		

		$finish;

	end
	always begin
		#5 clk = ~clk;
	end
      
endmodule

