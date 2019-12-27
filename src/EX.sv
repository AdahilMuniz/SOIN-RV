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
    input data_t i_IG_extendedImmediate
`else 
    input logic [`WORD_SIZE -1:0] i_IG_extendedImmediate
`endif

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

    //Branch and Jump Control Signals
    //logic [1:0] BJC_result;

    /****SHIFT-Branch****/
    assign SH_B = i_IG_extendedImmediate<<1;
    /****SUM-Branch****/
    assign o_S_B = i_pc + SH_B;

    //ALU Source 1
    assign ALU_Op1 = i_ALU_sel_src1 ? i_pc:i_RF_rd1;
    //ALU Source 2
    assign ALU_Op2 = i_ALU_sel_src2 ? i_IG_extendedImmediate:i_RF_rd2;
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

    /*BRANCH_JUMP_CONTROL branch_jump_control(
        .o_B_J_result(BJC_result),
        .i_Ctrl_Jump(i_BJC_ctrl_jump),
        .i_Zero(o_ALU_Zero),
        .i_Funct3(i_Funct3)
    );*/

endmodule