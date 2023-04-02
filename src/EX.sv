module EX (

    //SUM Branch
`ifndef YOSYS
    output data_t o_S_B,
`else 
    output logic [`WORD_SIZE -1:0] o_S_B,
`endif

    //ALU Signals
    output logic o_ALU_Zero,
`ifndef YOSYS
    output data_t o_ALU_Result,
`else 
    output logic [`WORD_SIZE -1:0] o_ALU_Result,
`endif
    //Forward Selector
    output logic FORW_sel3,

    input i_ALU_sel_src1,
    input i_ALU_sel_src2,

    //ALU Control Signals
    logic [2:0] i_ALUC_ALUOP,

    //Func3 && Func7
    input logic [2:0] i_Funct3,
    input logic [6:0] i_Funct7,

    //PC
`ifndef YOSYS
    input data_t       i_pc,
`else
    input logic [`WORD_SIZE -1:0] i_pc,
`endif

    //Register File Signals
`ifndef YOSYS
    input data_t i_RF_rd1,
    input data_t i_RF_rd2,
`else 
    input logic [`WORD_SIZE -1:0] i_RF_rd1,
    input logic [`WORD_SIZE -1:0] i_RF_rd2,
`endif


    //Immediate Generator Signals
`ifndef YOSYS
    input data_t i_IG_extendedImmediate,
`else 
    input logic [`WORD_SIZE -1:0] i_IG_extendedImmediate,
`endif

    //Read register signals from EX stage
    input  reg_t       i_EX_rnum1,
    input  reg_t       i_EX_rnum2,
    //Write register signals from MEM stage
    input  reg_t       i_MEM_wnum,
    input  data_t      i_MEM_wd,
    input  logic       i_MEM_wen,
    //Write register signals from WB stage
    input  reg_t       i_WB_wnum,
    input  data_t      i_WB_wd,
    input  logic       i_WB_wen,
    //Write memory signals from MEM Stage
    input  logic       i_MEM_memWrite

);

    //SHIFT Branch
`ifndef YOSYS
    data_t SH_B;
`else 
    logic [`WORD_SIZE -1:0] SH_B;
`endif

    //ALU Signals
`ifndef YOSYS
    data_t ALU_Op1;
    data_t ALU_Op2;
`else 
    logic [`WORD_SIZE -1:0] ALU_Op1;
    logic [`WORD_SIZE -1:0] ALU_Op2;
`endif
    logic [3:0] ALU_Operation;

    //ALU Control Signals
    logic [3:0] ALUC_ALUControlLines;

    //Forwarding Unit Signals
    logic [1:0] FORW_sel1;
    logic [1:0] FORW_sel2;

    /****SHIFT-Branch****/
    assign SH_B = i_IG_extendedImmediate<<1;
    /****SUM-Branch****/
    assign o_S_B = i_pc + SH_B;

    //ALU Source 1
    assign ALU_Op1 = i_ALU_sel_src1     ? i_pc                  :
                     FORW_sel1 == 2'b10 ? i_MEM_wd              :
                     FORW_sel1 == 2'b01 ? i_WB_wd               :
                                         i_RF_rd1;
    //ALU Source 2
    assign ALU_Op2 = i_ALU_sel_src2     ? i_IG_extendedImmediate:
                     FORW_sel2 == 2'b10 ? i_MEM_wd              :
                     FORW_sel2 == 2'b01 ? i_WB_wd               :
                                         i_RF_rd2;
    //ALU Operation
    assign ALU_Operation = ALUC_ALUControlLines;

    ALU alu (
        .o_Result(o_ALU_Result), 
        .o_Zero(o_ALU_Zero), 
        .i_Operation(ALU_Operation), 
        .i_Op1(ALU_Op1), 
        .i_Op2(ALU_Op2)
    );


    ALU_CONTROL alu_control (
        .o_ALUControlLines(ALUC_ALUControlLines), 
        .i_Funct7(i_Funct7), 
        .i_Funct3(i_Funct3), 
        .i_ALUOp(i_ALUC_ALUOP)
    );

    FORWARDING_UNIT forwarding_unit (
        .o_foward1_sel(FORW_sel1),
        .o_foward2_sel(FORW_sel2),
        .o_foward3_sel(FORW_sel3),
        .i_EX_rnum1(i_EX_rnum1),
        .i_EX_rnum2(i_EX_rnum2),
        .i_MEM_wnum(i_MEM_wnum),
        .i_MEM_wen(i_MEM_wen),
        .i_WB_wnum(i_WB_wnum),
        .i_WB_wen(i_WB_wen),
        .i_MEM_memWrite(i_MEM_memWrite)
    );

endmodule