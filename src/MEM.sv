module MEM (

    //Branch and Jump Control Signals
    output logic [1:0] o_BJC_result,
    input  logic [1:0] i_BJC_ctrl_jump,
    input  logic i_BJC_zero,

    //Load Store Unit Signals
    output logic  [3:0] o_LSU_range_select,
`ifndef YOSYS
    output data_t       o_LSU_data_load,
    input  data_t       i_LSU_rd,
`else 
    output logic [`WORD_SIZE -1:0] o_LSU_data_load,
    input  logic [`WORD_SIZE -1:0] i_LSU_rd,
`endif
    input logic  [1:0] i_LSU_low_addr,
    input logic        i_LSU_wen,
    input logic        i_LSU_ren,

    input logic  [2:0] i_Func3
);


    LOAD_STORE_UNIT load_store_unit(
        .o_range_select(o_LSU_range_select),
        .o_data_load(o_LSU_data_load),
        .i_rd(i_LSU_rd),
        .i_low_addr(i_LSU_low_addr),
        .i_Func3(i_Func3),
        .i_wen(i_LSU_wen),
        .i_ren(i_LSU_ren)
    );

    BRANCH_JUMP_CONTROL branch_jump_control(
        .o_B_J_result(o_BJC_result),
        .i_Ctrl_Jump(i_BJC_ctrl_jump),
        .i_Zero(i_BJC_zero),
        .i_Funct3(i_Func3)
    );

endmodule