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


    //SUM 4
`ifndef YOSYS
    data_t S_FOUR;
`else 
    logic [`WORD_SIZE -1:0] S_FOUR;
`endif

    //Branch and Jump Control Signals
    logic [1:0] BJC_result;
    logic BJC_zero;


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


    //ALU Control Signals
    logic [2:0] ALUC_ALUOP;

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

    //CSR
`ifndef YOSYS
    data_t   CSR_rd;
`else 
    logic [WORD_SIZE-1:0]  CSR_rd;
`endif
    logic        CSR_en;

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
    
    //SUM Branch
`ifndef YOSYS
    data_t S_B;
`else 
    logic [`WORD_SIZE -1:0] S_B;
`endif

    //JALR Result
`ifndef YOSYS
    data_t JALR_RESULT;
`else 
    logic [`WORD_SIZE -1:0] JALR_RESULT;
`endif


    /****Attributions****/

    assign o_IM_addr = pc; // PC to IM_addr

    //"Decode" instruction (Register File)
    assign RF_rnum1 = i_IM_instruction[19:15];
    assign RF_rnum2 = i_IM_instruction[24:20];
    assign RF_wnum  = i_IM_instruction[11:7];

    //"Decode" instruction (Immediate)
    assign IG_instruction = i_IM_instruction;

    //"Decode" instruction (CSR)
    assign CSR_addr = i_IM_instruction[31:20];

    //Main Control Signals attributions
    assign ALUC_ALUOP = MC_ALUOp;
    assign RF_wen = MC_regWrite;

    //CSR
    assign CSR_en = MC_CSR_en;

    //Branch and Jump Control Attributions
    assign BJC_zero = ALU_Zero;

    //Load Store Unit Attributions
    assign LSU_rd  = i_DM_rd;
    assign LSU_low_addr = ALU_Result[1:0];

    //Data Memory attributions
    assign o_DM_addr = ALU_Result;
    assign o_DM_wd   = RF_rd2;
    assign o_DM_wen  = LSU_range_select;
    assign o_DM_ren  = MC_memRead;

    /***JALR_RESULT***/
    assign JALR_RESULT = {ALU_Result[`WORD_SIZE-1:1], 1'b0};
    
    IF if_stage (
       .o_pc(pc),
       .o_S_FOUR(S_FOUR),

       .i_sel(BJC_result),
       .i_sum_branch_r(S_B),
       .i_jalr_r(JALR_RESULT),
       .i_clk(i_clk),
       .i_rstn(i_rstn)
    );

    ID id_stage (

      //Decode Signals
      .o_Funct7(Funct7),
      .o_Funct3(Funct3),
      .o_OPCode(OPCode),
      
      .o_CSR_rd(CSR_rd),
      .i_CSR_en(CSR_en),

      .o_IG_extendedImmediate(IG_extendedImmediate),

      .o_RF_rd1(RF_rd1),
      .o_RF_rd2(RF_rd2),
      .i_RF_wd(RF_wd),
      .i_RF_wen(RF_wen),

      .i_instruction(i_IM_instruction),
      .i_clk(i_clk),
      .i_rstn(i_rstn)
    );

    EX ex_stage (
      .o_S_B(S_B),
    
      .o_ALU_Zero(ALU_Zero),
      .o_ALU_Result(ALU_Result),
      //.o_CSR_rd(CSR_rd),
      //.i_CSR_en(CSR_en),
    
      .i_Funct3(Funct3),
      .i_Funct7(Funct7),
    
      .i_ALU_sel_src1(MC_ALUSrc1),
      .i_ALU_sel_src2(MC_ALUSrc2),

      .i_ALUC_ALUOP(ALUC_ALUOP),
    
      .i_pc(pc),
    
      .i_RF_rd1(RF_rd1),
      .i_RF_rd2(RF_rd2),
    
      .i_IG_extendedImmediate(IG_extendedImmediate)
    );

    MEM mem_stage (
        //Branch and Jump Control Signals
        .o_BJC_result(BJC_result),
        .i_BJC_ctrl_jump(MC_ctrl_jump),
        .i_BJC_zero(BJC_zero),

        //Load Store Unit Signals
        .o_LSU_range_select(LSU_range_select),
        .o_LSU_data_load(LSU_data_load),
        .i_LSU_rd(LSU_rd),
        .i_LSU_low_addr(LSU_low_addr),
        .i_LSU_wen(MC_memWrite),
        .i_LSU_ren(MC_memRead),

        .i_Func3(Funct3)
    );

    WB wb_stage (
    .o_RF_wd(RF_wd),
    .i_regSrc(MC_regSrc),

    .i_CSR_rd(CSR_rd),
    .i_S_FOUR(S_FOUR),
    .i_LSU_data_load(LSU_data_load),
    .i_ALU_Result(ALU_Result)

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

endmodule