`timescale 1ns / 1ps
`include "../defines/PARAMETERS.vh"

module DATAPATH(
		input i_clk
    );

	//Instruction Memory Signals
	wire [`WORD_SIZE:0] IM_instruction;
	wire [`WORD_SIZE:0] IM_addr;

	//Register File Signals
	wire [`WORD_SIZE:0] RF_rd1;
	wire [`WORD_SIZE:0] RF_rd2;
	wire [`WORD_SIZE:0] RF_rnum1;
	wire [`WORD_SIZE:0] RF_rnum2;
	wire [`WORD_SIZE:0] RF_wen;
	wire [`WORD_SIZE:0] RF_wnum;
	wire [`WORD_SIZE:0] RF_wd;


	//PC
	reg [`WORD_SIZE:0] pc;

	initial begin
		pc = 0;
	end

	always @(posedge i_clk) begin
		pc = pc + 1;
	end

	//Attributions

	assign IM_addr = pc; // PC to IM_addr

	//"Decode" instruction (Register File)
	assign RF_rnum1 = IM_instruction[19:15];
	assign RF_rnum2 = IM_instruction[24:20];
	assign RF_wnum  = IM_instruction[11:7];

	//Instruction Memory Instantiation
	INSTRUCTION_MEMORY instruction_memory (
		.o_Instruction(IM_instruction), 
		.i_Addr(IM_addr)
    );


	REGISTER_FILE register_file (
		.o_Rd1(RF_rd1), 
		.o_Rd2(RF_rd2), 
		.i_Rnum1(RF_rnum1), 
		.i_Rnum2(RF_rnum2), 
		.i_Wen(RF_wen), 
		.i_Wnum(RF_wnum), 
		.i_Wd(RF_wd), 
		.i_clk(i_clk)
    );

endmodule
