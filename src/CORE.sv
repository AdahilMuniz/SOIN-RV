module CORE(
		output addr_t o_IM_addr,
		output data_t o_DM_wd,
		output addr_t o_DM_addr,
		output o_DM_wen,
		output o_DM_ren,

		input data_t i_IM_instruction,
		input data_t i_DM_rd,

		input i_clk,
		input i_rstn
    );


	//Register File Signals
	data_t RF_rd1;
	data_t RF_rd2;
	logic [4:0] RF_rnum1;
	logic [4:0] RF_rnum2;
	logic RF_wen;
	logic [4:0] RF_wnum;
	data_t RF_wd;

	//Immediate Generator Signals
	data_t IG_extendedImmediate;
	data_t IG_instruction;

	//Main Control Signals
	logic MC_branch;
	logic MC_memRead;
	logic MC_memWrite;
	logic MC_memToReg;
	logic [2:0] MC_ALUOp;
	logic MC_ALUSrc1;
	logic MC_ALUSrc2;
	logic MC_regWrite;
	logic [6:0] MC_OPCode;

    //ALU Control Signals
	logic [3:0] ALUC_ALUControlLines;
	logic [6:0] ALUC_Funct7;
	logic [2:0] ALUC_Funct3;
	logic [2:0] ALUC_ALUOP;

	//ALU Signals
	data_t ALU_Result;
	logic ALU_Zero;
	logic [3:0] ALU_Operation;
	data_t ALU_Op1;
	data_t ALU_Op2;

	//PC
	data_t pc;

	//AND Branch
	logic A_B;
	//SHIFT Branch
	data_t SH_B;
	//SUM Branch
	data_t S_B;

	/****PC Update****/
	initial begin
		pc = 0;
	end

	always @(posedge i_clk, negedge i_rstn) begin
		if(~i_rstn) begin
			pc <= 0;
		end
		else begin 
			if(A_B) begin
				pc <= S_B;
			end
			else begin
				pc <= pc + 4;
			end
		end
	end

	/****Attributions****/

	assign o_IM_addr = pc; // PC to IM_addr

	//"Decode" instruction (Register File)
	assign RF_rnum1 = i_IM_instruction[19:15];
	assign RF_rnum2 = i_IM_instruction[24:20];
	assign RF_wnum  = i_IM_instruction[11:7];

	//"Decode" instruction (Immediate)
	assign IG_instruction = i_IM_instruction;

	//"Decode" instruction (ALU Control)
	assign ALUC_Funct3 = i_IM_instruction[14:12];
	assign ALUC_Funct7 = i_IM_instruction[31:25];

	//"Decode" instruction (Main Control)
	assign MC_OPCode = i_IM_instruction[6:0];

	//Main Control Signals attributions
	assign RF_wen = MC_regWrite;
	assign ALUC_ALUOP = MC_ALUOp;

	//ALU Control Signals attributions
	assign ALU_Operation = ALUC_ALUControlLines;

	//Data Memory attributions
	assign o_DM_addr = ALU_Result;
	assign o_DM_wd   = RF_rd2;
	assign o_DM_wen  = MC_memWrite;
	assign o_DM_ren  = MC_memRead;


	/****Muxes****/
	
	//ALU Source 1
	assign ALU_Op1 = MC_ALUSrc1 ? pc:RF_rd1;
	//ALU Source 2
	assign ALU_Op2 = MC_ALUSrc2 ? IG_extendedImmediate:RF_rd2;
	//Write Data (Register File) Source
	assign RF_wd = MC_memToReg ? i_DM_rd:ALU_Result;

	/****AND-Branch****/
	assign A_B = MC_branch & ALU_Zero;
	/****SHIFT-Branch****/
	assign SH_B = IG_extendedImmediate<<1;
	/****SUM-Branch****/
	assign S_B = pc + SH_B; //we have to use $sigend()?

	REGISTER_FILE register_file (
		.o_Rd1(RF_rd1), 
		.o_Rd2(RF_rd2), 
		.i_Rnum1(RF_rnum1), 
		.i_Rnum2(RF_rnum2), 
		.i_Wen(RF_wen), 
		.i_Wnum(RF_wnum), 
		.i_Wd(RF_wd), 
		.i_clk(i_clk),
		.i_rstn(i_rstn)
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

    ALU_CONTROL alu_control (
	    .o_ALUControlLines(ALUC_ALUControlLines), 
	    .i_Funct7(ALUC_Funct7), 
	    .i_Funct3(ALUC_Funct3), 
	    .i_ALUOp(ALUC_ALUOP)
    );

    MAIN_CONTROL main_control (
    	.o_Branch(MC_branch), 
    	.o_MemRead(MC_memRead), 
    	.o_MemWrite(MC_memWrite), 
    	.o_MemToReg(MC_memToReg), 
    	.o_ALUOp(MC_ALUOp),
    	.o_ALUSrc1(MC_ALUSrc1),  
    	.o_ALUSrc2(MC_ALUSrc2), 
    	.o_RegWrite(MC_regWrite), 
    	.i_OPCode(MC_OPCode)
    );

endmodule
