//@TODO: Use one adder and a mux to select the source
module CORE(
`ifndef YOSYS
        output addr_t       o_IM_addr,
        output data_t       o_DM_wd,
        output addr_t       o_DM_addr,
`else 
        output logic [`WORD_SIZE -1:0] o_IM_addr,
        output logic [`WORD_SIZE -1:0] o_DM_wd,
        output logic [`WORD_SIZE -1:0] o_DM_addr,
`endif
        output logic  [3:0] o_DM_wen,
        output              o_DM_ren,

`ifndef YOSYS
        input data_t i_IM_instruction,
        input data_t i_DM_rd,
`else 
        input logic [`WORD_SIZE -1:0] i_IM_instruction,
        input logic [`WORD_SIZE -1:0] i_DM_rd,
`endif
        input i_clk,
        input i_rstn
    );


    //Register File Signals
`ifndef YOSYS
    data_t RF_rd1;
    data_t RF_rd2;
    data_t RF_wd;
`else 
    logic [`WORD_SIZE -1:0] RF_rd1;
    logic [`WORD_SIZE -1:0] RF_rd2;
    logic [`WORD_SIZE -1:0] RF_wd;
`endif
    logic [4:0] RF_rnum1;
    logic [4:0] RF_rnum2;
    logic RF_wen;
    logic [4:0] RF_wnum;

    //Immediate Generator Signals
`ifndef YOSYS
    data_t IG_extendedImmediate;
    data_t IG_instruction;
`else 
    logic [`WORD_SIZE -1:0] IG_extendedImmediate;
    logic [`WORD_SIZE -1:0] IG_instruction;
`endif

    //Main Control Signals
    logic [1:0] MC_ctrl_jump;
    logic MC_memRead;
    logic MC_memWrite;
    logic [1:0] MC_regSrc;
    logic [2:0] MC_ALUOp;
    logic MC_ALUSrc1;
    logic MC_ALUSrc2;
    logic MC_regWrite;
    logic MC_CSR_en;

    //ALU Control Signals
    logic [3:0] ALUC_ALUControlLines;
    logic [2:0] ALUC_ALUOP;

    //ALU Signals
`ifndef YOSYS
    data_t ALU_Result;
    data_t ALU_Op1;
    data_t ALU_Op2;
`else 
    logic [`WORD_SIZE -1:0] ALU_Result;
    logic [`WORD_SIZE -1:0] ALU_Op1;
    logic [`WORD_SIZE -1:0] ALU_Op2;
`endif
    logic ALU_Zero;
    logic [3:0] ALU_Operation;

    //Branch and Jump Control Signals
    logic [1:0] BJC_result;
    logic [1:0] BJC_ctrl_jump;
    logic BJC_zero;

    //Load Store Unit Signals
`ifndef YOSYS
    data_t       LSU_data_load;
    data_t       LSU_rd;
`else 
    logic [`WORD_SIZE -1:0] LSU_data_load;
    logic [`WORD_SIZE -1:0] LSU_rd;
`endif
    logic  [3:0] LSU_range_select;
    logic  [1:0] LSU_low_addr;
    logic        LSU_wen;
    logic        LSU_ren;

    //CSR
`ifndef YOSYS
    data_t   CSR_rd;
    data_t   CSR_wd;
`else 
    logic [`WORD_SIZE-1:0]  CSR_rd;
    logic [`WORD_SIZE-1:0]  CSR_wd;
`endif
    logic [11:0] CSR_addr;
    logic        CSR_en;
    logic [2:0]  CSR_Funct3;


    //Decode Signals
    logic [6:0] Funct7;
    logic [2:0] Funct3;
    logic [6:0] OPCode;

    //PC
`ifndef YOSYS
    data_t pc;
`else 
    logic [`WORD_SIZE -1:0] pc;
`endif
    //MUX PC
`ifndef YOSYS
    data_t mux_pc;
`else 
    logic [`WORD_SIZE -1:0] mux_pc;
`endif

    //SHIFT Branch
`ifndef YOSYS
    data_t SH_B;
`else 
    logic [`WORD_SIZE -1:0] SH_B;
`endif
    
    //SUM Branch
`ifndef YOSYS
    data_t S_B;
`else 
    logic [`WORD_SIZE -1:0] S_B;
`endif

    //SUM 4
`ifndef YOSYS
    data_t S_FOUR;
`else 
    logic [`WORD_SIZE -1:0] S_FOUR;
`endif

    //JALR Result
`ifndef YOSYS
    data_t JALR_RESULT;
`else 
    logic [`WORD_SIZE -1:0] JALR_RESULT;
`endif

    /****PC Update****/
    //initial begin
    //	pc = 0;
    //end

    always @(posedge i_clk) begin
        if(~i_rstn) begin
            pc <= 0;
        end
        else begin 
            pc <= mux_pc;
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

    //"Decode" instruction (F7 and F3)
    assign Funct3 = i_IM_instruction[14:12];
    assign Funct7 = i_IM_instruction[31:25];

    //"Decode" instruction (Main Control)
    assign OPCode = i_IM_instruction[6:0];

    //"Decode" instruction (CSR)
    assign CSR_addr = i_IM_instruction[31:20];

    //Main Control Signals attributions
    assign RF_wen = MC_regWrite;
    assign ALUC_ALUOP = MC_ALUOp;

    //ALU Control Signals attributions
    assign ALU_Operation = ALUC_ALUControlLines;

    //Data Memory attributions
    assign o_DM_addr = ALU_Result;
    assign o_DM_wd   = RF_rd2;
    assign o_DM_wen  = LSU_range_select;
    assign o_DM_ren  = MC_memRead;

    //Branch and Jump Control Attributions
    assign BJC_zero      = ALU_Zero;
    assign BJC_ctrl_jump = MC_ctrl_jump;

    //Load Store Unit Attributions
    assign LSU_rd  = i_DM_rd;
    assign LSU_wen = MC_memWrite;
    assign LSU_ren = MC_memRead;
    assign LSU_low_addr = ALU_Result[1:0];

    //CSR
    assign CSR_en = MC_CSR_en;
    assign CSR_wd = RF_rd1;

    /****Muxes****/
    
    //ALU Source 1
    assign ALU_Op1 = MC_ALUSrc1 ? pc:RF_rd1;
    //ALU Source 2
    assign ALU_Op2 = MC_ALUSrc2 ? IG_extendedImmediate:RF_rd2;
    //Write Data (Register File) Source
    assign RF_wd = MC_regSrc[1] ? (MC_regSrc[0] ? CSR_rd:S_FOUR) : 
                                  (MC_regSrc[0] ? LSU_data_load  : ALU_Result);
    //PC Source
    assign mux_pc = BJC_result[1] ? JALR_RESULT : (BJC_result[0] ? S_B : S_FOUR);

    /****SHIFT-Branch****/
    assign SH_B = IG_extendedImmediate<<1;
    /****SUM-Branch****/
    assign S_B = pc + SH_B;
    /****SUM-4-PC****/
    assign S_FOUR = pc + 4;
    /***JALR_RESULT***/
    assign JALR_RESULT = {ALU_Result[`WORD_SIZE-1:1], 1'b0};

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
        .i_Funct7(Funct7), 
        .i_Funct3(Funct3), 
        .i_ALUOp(ALUC_ALUOP)
    );

    MAIN_CONTROL main_control (
        .o_Ctrl_Jump(MC_ctrl_jump),
        .o_MemRead(MC_memRead), 
        .o_MemWrite(MC_memWrite), 
        .o_RegSrc(MC_regSrc), 
        .o_ALUOp(MC_ALUOp),
        .o_ALUSrc1(MC_ALUSrc1),  
        .o_ALUSrc2(MC_ALUSrc2), 
        .o_RegWrite(MC_regWrite), 
        .o_CSR_en(MC_CSR_en),
        .i_OPCode(OPCode)
    );

    BRANCH_JUMP_CONTROL branch_jump_control(
        .o_B_J_result(BJC_result),
        .i_Ctrl_Jump(BJC_ctrl_jump),
        .i_Zero(BJC_zero),
        .i_Funct3(Funct3)
    );

    LOAD_STORE_UNIT load_store_unit(
        .o_range_select(LSU_range_select),
        .o_data_load(LSU_data_load),
        .i_rd(LSU_rd),
        .i_low_addr(LSU_low_addr),
        .i_Func3(Funct3),
        .i_wen(LSU_wen),
        .i_ren(LSU_ren)
    );

    CSR csr (
        .o_rd(CSR_rd),
        .i_addr(CSR_addr),
        .i_wd(CSR_wd),
        .i_en(CSR_en),
        .i_Funct3(Funct3),
        .i_clk(i_clk),
        .i_rstn(i_rstn)
    );

endmodule
