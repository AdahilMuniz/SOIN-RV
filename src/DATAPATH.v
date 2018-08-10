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
	wire [4:0] RF_rnum1;
	wire [4:0] RF_rnum2;
	wire RF_wen;
	wire [4:0] RF_wnum;
	wire [`WORD_SIZE:0] RF_wd;

	//Immediate Generator Signals
	wire [`WORD_SIZE:0] IG_extendedImmediate;
	wire [`WORD_SIZE:0] IG_instruction;

	//Main Control Signals
	wire MC_branch;
	wire MC_memRead;
	wire MC_memWrite;
	wire MC_memToReg;
    wire [1:0] MC_ALUOp;
    wire MC_ALUSrc;
    wire MC_regWrite;
    wire [6:0] MC_OPCode;

    //ALU Control Signals
	wire [3:0] ALUC_ALUControlLines;
	wire [6:0] ALUC_Funct7;
	wire [2:0] ALUC_Funct3;
	wire [1:0] ALUC_ALUO;

	//ALU Signals
	wire [`WORD_SIZE-1:0] ALU_Result;
	wire ALU_Zero;
	wire [3:0] ALU_Operation;
	wire [`WORD_SIZE-1:0] ALU_Op1;
	wire [`WORD_SIZE-1:0] ALU_Op2;

	//PC
	reg [`WORD_SIZE:0] pc;

	initial begin
		pc = 0;
	end

	always @(posedge i_clk) begin
		pc = pc + 1;
	end

	/****Attributions****/

	assign IM_addr = pc; // PC to IM_addr

	//"Decode" instruction (Register File)
	assign RF_rnum1 = IM_instruction[19:15];
	assign RF_rnum2 = IM_instruction[24:20];
	assign RF_wnum  = IM_instruction[11:7];

	//"Decode" instruction (Immediate)
	assign IG_Instruction = IM_instruction;

	//Main Control Signals attributions
	assign RF_wen = MC_regWrite;

	//ALU Source 1
	assign ALU_Op1 = RF_rd1;


	/****Muxes****/
	//ALU Source 2
	assign ALU_Op2 = MC_ALUSrc ? IG_extendedImmediate:RF_rd2;


	//Instruction Memory Instantiation
	INSTRUCTION_MEMORY #(`IM_DEPTH, `IM_FILE)instruction_memory (
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

    IMM_GENERATOR imm_generator (
	    .o_ExtendedImmediate(IG_extendedImmediate), 
	    .i_Instruction(IG_instruction)
    );

    ALU alu (
	    .o_Result(ALU_Result), 
	    .o_Zero(ALU_Zero), 
	    .i_Operation(ALU_Operation), 
	    .i_Op1(ALU_Op1), 
	    .i_Op2(ALU_Op2)
    );



endmodule