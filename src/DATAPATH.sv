module DATAPATH(
        input i_clk,
        input i_rstn
    );

    //Parametersa
    parameter IM_FILE = `IM_FILE;

    //Instruction Memory Signals
    data_t IM_instruction;
    addr_t IM_addr;

    //Data Memory Signals
    data_t       DM_rd;
    data_t       DM_wd;
    addr_t 		 DM_addr;
    logic  [3:0] DM_wen;
    logic        DM_ren;

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

    DATA_MEMORY_V2 #(`DM_DEPTH, `DM_FILE) data_memory (
        .o_Rd(DM_rd), 
        .i_Wd(DM_wd), 
        .i_Addr(DM_addr), 
        .i_Wen(DM_wen), 
        .i_Ren(DM_ren), 
        .i_clk(i_clk)
    );

endmodule
