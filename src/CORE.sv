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
    data_t S_FOUR [5];
`else 
    logic [`WORD_SIZE -1:0] S_FOUR[5];
`endif

    //Branch and Jump Control Signals
    logic [1:0] BJC_result;
    logic BJC_zero;


    //Register File Signals
`ifndef YOSYS
    data_t RF_rd1_id;
    data_t RF_rd2_id;
    data_t RF_rd1_ex;
    data_t RF_rd2_ex;
    data_t RF_rd2_mem;
    data_t RF_wd;
`else 
    logic [`WORD_SIZE -1:0] RF_rd1_id;
    logic [`WORD_SIZE -1:0] RF_rd2_id;
    logic [`WORD_SIZE -1:0] RF_rd1_ex;
    logic [`WORD_SIZE -1:0] RF_rd2_ex;
    logic [`WORD_SIZE -1:0] RF_rd2_mem;
    logic [`WORD_SIZE -1:0] RF_wd;
`endif
    logic [4:0] RF_wnum [4];
    logic RF_wen;

    //Immediate Generator Signals
`ifndef YOSYS
    data_t IG_extendedImmediate_id;
    data_t IG_extendedImmediate_ex;
    data_t IG_instruction;
`else 
    logic [`WORD_SIZE -1:0] IG_extendedImmediate_id;
    logic [`WORD_SIZE -1:0] IG_extendedImmediate_ex;
    logic [`WORD_SIZE -1:0] IG_instruction;
`endif

    //Main Control Signals
    logic [1:0] MC_ctrl_jump[3];
    logic MC_memRead[3];
    logic MC_memWrite[3];
    logic [1:0] MC_regSrc[4];
    logic [2:0] MC_ALUOp[2];
    logic MC_ALUSrc1[2];
    logic MC_ALUSrc2[2];
    logic MC_regWrite[4];
    logic MC_CSR_en[4];

    //ALU Signals
`ifndef YOSYS
    data_t ALU_Result_ex;
    data_t ALU_Result_mem;
    data_t ALU_Result_wb;
    data_t ALU_Op1;
    data_t ALU_Op2;
`else 
    logic [`WORD_SIZE -1:0] ALU_Result_ex;
    logic [`WORD_SIZE -1:0] ALU_Result_mem;
    logic [`WORD_SIZE -1:0] ALU_Result_wb;
    logic [`WORD_SIZE -1:0] ALU_Op1;
    logic [`WORD_SIZE -1:0] ALU_Op2;
`endif
    logic ALU_Zero;
    logic [3:0] ALU_Operation;


    //ALU Control Signals
    logic [2:0] ALUC_ALUOP;

    //Load Store Unit Signals
`ifndef YOSYS
    data_t       LSU_data_load_mem;
    data_t       LSU_data_load_wb;
    data_t       LSU_rd;
`else 
    logic [`WORD_SIZE -1:0] LSU_data_load_mem;
    logic [`WORD_SIZE -1:0] LSU_data_load_wb;
    logic [`WORD_SIZE -1:0] LSU_rd;
`endif
    logic  [3:0] LSU_range_select;
    logic  [1:0] LSU_low_addr;

    //CSR
`ifndef YOSYS
    data_t   CSR_rd[4];
`else 
    logic [WORD_SIZE-1:0]  CSR_rd[4];
`endif
    logic        CSR_en;

    //Decode Signals
    logic [6:0] funct7_id;
    logic [2:0] funct3_id;

    logic [6:0] funct7_ex;
    logic [2:0] funct3_ex;

    logic [2:0] funct3_mem;

    logic [6:0] opcode;

    //PC
`ifndef YOSYS
    data_t pc [3];
`else 
    logic [`WORD_SIZE -1:0] pc [3];
`endif
    
    //SUM Branch
`ifndef YOSYS
    data_t S_B_ex;
    data_t S_B_if;
`else 
    logic [`WORD_SIZE -1:0] S_B_ex;
    logic [`WORD_SIZE -1:0] S_B_if;
`endif

    //JALR Result
`ifndef YOSYS
    data_t JALR_RESULT;
`else 
    logic [`WORD_SIZE -1:0] JALR_RESULT;
`endif


    //IF/ID Registers
`ifndef YOSYS
        data_t IM_instruction_id;
`else 
        logic [`WORD_SIZE -1:0] IM_instruction_id;
`endif

    /****Attributions****/

    assign o_IM_addr = pc[0]; // PC to IM_addr

    //"Decode" instruction (Immediate)
    assign IG_instruction = i_IM_instruction;

    //"Decode" instruction (CSR)
    assign CSR_addr = i_IM_instruction[31:20];

    //Main Control Signals attributions
    assign RF_wen = MC_regWrite[3];

    //CSR
    assign CSR_en = MC_CSR_en[3];

    //Load Store Unit Attributions
    assign LSU_rd  = i_DM_rd;

    //Data Memory attributions
    assign o_DM_addr = ALU_Result_mem;
    assign o_DM_wd   = RF_rd2_mem;
    assign o_DM_wen  = LSU_range_select;
    assign o_DM_ren  = MC_memRead[2];

    /***JALR_RESULT***/
    assign JALR_RESULT = {ALU_Result_mem[`WORD_SIZE-1:1], 1'b0};
    
    IF if_stage (
       .o_pc(pc[0]),
       .o_S_FOUR(S_FOUR[0]),

       .i_sel(BJC_result),
       .i_sum_branch_r(S_B_if),
       .i_jalr_r(JALR_RESULT),
       .i_clk(i_clk),
       .i_rstn(i_rstn)
    );

    ID id_stage (

      //Decode Signals
      .o_Funct7(funct7_id),
      .o_Funct3(funct3_id),
      .o_OPCode(opcode),
      
      .o_CSR_rd(CSR_rd[0]),
      .i_CSR_en(CSR_en),

      .o_IG_extendedImmediate(IG_extendedImmediate_id),

      .o_RF_rd1(RF_rd1_id),
      .o_RF_rd2(RF_rd2_id),
      .o_RF_wnum(RF_wnum[0]),

      .i_RF_wd(RF_wd),
      .i_RF_wnum(RF_wnum[3]),
      .i_RF_wen(RF_wen),

      .i_instruction(IM_instruction_id),
      .i_clk(i_clk),
      .i_rstn(i_rstn)
    );

    EX ex_stage (
      .o_S_B(S_B_ex),
    
      .o_ALU_Zero(ALU_Zero),
      .o_ALU_Result(ALU_Result_ex),
      //.o_CSR_rd(CSR_rd),
      //.i_CSR_en(CSR_en),
    
      .i_Funct3(funct3_ex),
      .i_Funct7(funct7_ex),
    
      .i_ALU_sel_src1(MC_ALUSrc1[1]),
      .i_ALU_sel_src2(MC_ALUSrc2[1]),

      .i_ALUC_ALUOP(MC_ALUOp[1]),
    
      .i_pc(pc[2]),
    
      .i_RF_rd1(RF_rd1_ex),
      .i_RF_rd2(RF_rd2_ex),
    
      .i_IG_extendedImmediate(IG_extendedImmediate_ex)
    );

    MEM mem_stage (
        //Branch and Jump Control Signals
        .o_BJC_result(BJC_result),
        .i_BJC_ctrl_jump(MC_ctrl_jump[2]),
        .i_BJC_zero(BJC_zero),

        //Load Store Unit Signals
        .o_LSU_range_select(LSU_range_select),
        .o_LSU_data_load(LSU_data_load_mem),
        .i_LSU_rd(LSU_rd),
        .i_LSU_low_addr(LSU_low_addr),
        .i_LSU_wen(MC_memWrite[2]),
        .i_LSU_ren(MC_memRead[2]),

        .i_Func3(funct3_mem)
    );

    WB wb_stage (
    .o_RF_wd(RF_wd),
    .i_regSrc(MC_regSrc[3]),

    .i_CSR_rd(CSR_rd[3]),
    .i_S_FOUR(S_FOUR[4]),
    .i_LSU_data_load(LSU_data_load_wb),
    .i_ALU_Result(ALU_Result_wb)

    );

    MAIN_CONTROL main_control (
        .o_Ctrl_Jump(MC_ctrl_jump[0]),
        .o_MemRead(MC_memRead[0]), 
        .o_MemWrite(MC_memWrite[0]), 
        .o_RegSrc(MC_regSrc[0]), 
        .o_ALUOp(MC_ALUOp[0]),
        .o_ALUSrc1(MC_ALUSrc1[0]),  
        .o_ALUSrc2(MC_ALUSrc2[0]), 
        .o_RegWrite(MC_regWrite[0]), 
        .o_CSR_en(MC_CSR_en[0]),
        .i_OPCode(opcode)
    );

    //Pipeline
    always_ff @(posedge i_clk) begin : pipeline
        if(~i_rstn) begin

            pc[1]                   <= 0;//ID
            pc[2]                   <= 0;//EX

            S_FOUR[1]               <= 0;//ID
            S_FOUR[2]               <= 0;//EX
            S_FOUR[3]               <= 0;//MEM
            S_FOUR[4]               <= 0;//WB

            RF_wnum[1]              <= 0;//EX
            RF_wnum[2]              <= 0;//MEM
            RF_wnum[3]              <= 0;//ID

            CSR_rd[1]               <= 0;//EX
            CSR_rd[2]               <= 0;//MEM
            CSR_rd[3]               <= 0;//WB

            //IF
            S_B_if                  <= 0;

            //ID
            IM_instruction_id       <= 0;
            
            //EX
            funct7_ex               <= 0;
            funct3_ex               <= 0;
            RF_rd1_ex               <= 0;
            RF_rd2_ex               <= 0;
            IG_extendedImmediate_ex <= 0;

            //MEM
            funct3_mem              <= 0;
            RF_rd2_mem              <= 0;
            BJC_zero                <= 0;
            ALU_Result_mem          <= 0;

            //WB
            LSU_data_load_wb        <= 0;
            ALU_Result_wb           <= 0;

            //Main Control pipeline
            MC_ctrl_jump[1]         <= 0;
            MC_ctrl_jump[2]         <= 0;

            MC_memRead[1]           <= 0;
            MC_memRead[2]           <= 0;

            MC_memWrite[1]          <= 0;
            MC_memWrite[2]          <= 0;

            MC_regSrc[1]            <= 0;
            MC_regSrc[2]            <= 0;
            MC_regSrc[3]            <= 0;
            MC_regSrc[4]            <= 0;

            MC_ALUOp[1]             <= 0;

            MC_ALUSrc1[1]           <= 0;
            MC_ALUSrc2[1]           <= 0;

            MC_regWrite[1]          <= 0;
            MC_regWrite[2]          <= 0;
            MC_regWrite[3]          <= 0;

            MC_CSR_en[1]            <= 0;
            MC_CSR_en[2]            <= 0;
            MC_CSR_en[3]            <= 0;

        end else begin
            //PC Pipeline
            pc[1]                   <= pc[0];// IF to ID
            pc[2]                   <= pc[1];// ID to EX

            S_FOUR[1]               <= S_FOUR[0];// IF to ID
            S_FOUR[2]               <= S_FOUR[1];// ID to EX
            S_FOUR[3]               <= S_FOUR[2];// EX to MEM
            S_FOUR[4]               <= S_FOUR[3];// MEM to WB

            //Write Register Number
            RF_wnum[1]              <= RF_wnum[0];//ID to EX
            RF_wnum[2]              <= RF_wnum[1];//EX to MEM
            RF_wnum[3]              <= RF_wnum[2];//MEM to ID

            //CSR rd
            CSR_rd[1]               <= CSR_rd[0];//ID to EX
            CSR_rd[2]               <= CSR_rd[1];//EX to MEM
            CSR_rd[3]               <= CSR_rd[2];//MEM to WB

            //IF to ID
            IM_instruction_id       <= i_IM_instruction;

            //ID to EX
            funct7_ex               <= funct7_id;
            funct3_ex               <= funct3_id;
            RF_rd1_ex               <= RF_rd1_id;
            RF_rd2_ex               <= RF_rd2_id;
            IG_extendedImmediate_ex <= IG_extendedImmediate_id;

            //EX to MEM
            funct3_mem              <= funct3_ex;
            RF_rd2_mem              <= RF_rd2_ex;
            BJC_zero                <= ALU_Zero;
            LSU_low_addr            <= ALU_Result_ex[1:0];
            ALU_Result_mem          <= ALU_Result_ex;

            //MEM to WB
            LSU_data_load_wb        <= LSU_data_load_mem;
            ALU_Result_wb           <= ALU_Result_mem;

            //EX to IF
            S_B_if                  <= S_B_ex;

            //Main Control Pipeline
            MC_ctrl_jump[1]         <= MC_ctrl_jump[0];
            MC_ctrl_jump[2]         <= MC_ctrl_jump[1];

            MC_memRead[1]           <= MC_memRead[0];
            MC_memRead[2]           <= MC_memRead[1];

            MC_memWrite[1]          <= MC_memWrite[0];
            MC_memWrite[2]          <= MC_memWrite[1];

            MC_regSrc[1]            <= MC_regSrc[0];
            MC_regSrc[2]            <= MC_regSrc[1];
            MC_regSrc[3]            <= MC_regSrc[2];
            MC_regSrc[4]            <= MC_regSrc[3];

            MC_ALUOp[1]             <= MC_ALUOp[0];

            MC_ALUSrc1[1]           <= MC_ALUSrc1[0];
            MC_ALUSrc2[1]           <= MC_ALUSrc2[0];

            MC_regWrite[1]          <= MC_regWrite[0];
            MC_regWrite[2]          <= MC_regWrite[1];
            MC_regWrite[3]          <= MC_regWrite[2];

            MC_CSR_en[1]            <= MC_CSR_en[0];
            MC_CSR_en[2]            <= MC_CSR_en[1];
            MC_CSR_en[3]            <= MC_CSR_en[2];

        end
    end

endmodule