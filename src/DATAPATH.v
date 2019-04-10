module DATAPATH(
		input i_clk,
		input i_rstn
    );

	//Parametersa
	parameter IM_FILE = `IM_FILE;

	//Instruction Memory Signals
	wire [`WORD_SIZE-1:0] IM_instruction;
	wire [`WORD_SIZE-1:0] IM_addr;

	//Data Memory Signals
	wire [`WORD_SIZE-1:0] DM_rd;
	wire [`WORD_SIZE-1:0] DM_wd;
	wire [`WORD_SIZE-1:0] DM_addr;
	wire DM_wen;
	wire DM_ren;

	CORE core (
		.o_IM_addr(IM_addr),
		.o_DM_wd(DM_wd),
		.o_DM_addr(DM_addr),
		.o_DM_wen(DM_wen),
		.o_DM_ren(DM_ren),

		.i_IM_instruction(IM_instruction),
		.i_DM_rd(DM_rd),

		.i_clk(i_clk),
		.i_rstn(i_rstn)
	);

	INSTRUCTION_MEMORY #(`IM_DEPTH, IM_FILE) instruction_memory (
		.o_Instruction(IM_instruction), 
		.i_Addr(IM_addr)
    );

    DATA_MEMORY #(`DM_DEPTH, `DM_FILE) data_memory (
	    .o_Rd(DM_rd), 
	    .i_Wd(DM_wd), 
	    .i_Addr(DM_addr), 
	    .i_Wen(DM_wen), 
	    .i_Ren(DM_ren), 
	    .i_clk(i_clk)
    );

endmodule
