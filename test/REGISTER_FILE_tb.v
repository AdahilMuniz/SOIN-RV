`timescale 1ns / 1ps
`define INITIALIZE
`define R_TEST
`define R_W_TEST

module REGISTER_FILE_tb;

	// Inputs
	reg [4:0] i_Rnum1;
	reg [4:0] i_Rnum2;
	reg i_Wen;
	reg [4:0] i_Wnum;
	reg [31:0] i_Wd;
	reg i_clk;

	// Outputs
	wire [31:0] o_Rd1;
	wire [31:0] o_Rd2;

	// Instantiate the Unit Under Test (UUT)
	REGISTER_FILE uut (
		.o_Rd1(o_Rd1), 
		.o_Rd2(o_Rd2), 
		.i_Rnum1(i_Rnum1), 
		.i_Rnum2(i_Rnum2), 
		.i_Wen(i_Wen), 
		.i_Wnum(i_Wnum), 
		.i_Wd(i_Wd), 
		.i_clk(i_clk)
	);

	integer i,j;
	integer last, current;

	initial begin
		// Initialize Inputs
		
		i_clk = 0;

		`ifdef INITIALIZE
		i_Wen = 1;
		//Initilize registers(Write Test)
		for(i=1;i<32;i = i+1) begin
			i_Wnum = i;
			i_Wd = i;
			#10;
		end
		`endif

		`ifdef R_TEST
		i_Wen = 0;
		//Reading Test
		for(i=0;i<32;i = i+1) begin
			for(j=0;j<32;j=j+1) begin
				i_Rnum1 = i;
				i_Rnum2 = j;
				#10;
				if (o_Rd1 != i || o_Rd2 != j) begin
					$display("ERROR");
					$finish;
				end
			end
		end
		`endif

		`ifdef R_W_TEST
		//Read and Write in the same clock period.
		i_Wen = 1;
		for(i=1;i<32;i = i+1) begin
			i_Rnum1 = i;//First, the value in the register is read
			#1;//Delay to read the value of the current register.
			last = o_Rd1;
			//Write the register
			i_Wnum = i;
			current = $random()%32;
			i_Wd = current;
			//Read the register
			i_Rnum1 = i;
			//The value need to be the same of the last, because when a reading occurs in the same clock period than a writing
			//the returned value is the value of the last posedge clock.
			if (o_Rd1 != last) begin
				$display("ERROR");
				$finish;
			end
			#9;
		end
		`endif

		$finish;

	end
	always begin
		#5 i_clk = ~i_clk;
	end
      
endmodule

