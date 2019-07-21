//DEFINES
`include "PROJECT_CONFIG.svh"
`include "ALU_CONTROL.svh"
`include "OPCODES_DEFINES.svh"
`include "PARAMETERS.svh"
`include "CSR_DEFINES.svh"

//RV32I Files
`include "ALU.sv"
`include "ALU_CONTROL.sv"
`include "IMM_GENERATOR.sv"
`include "INSTRUCTION_MEMORY.sv"
`include "DATA_MEMORY_V2.sv"
`include "MAIN_CONTROL.sv"
`include "BRANCH_JUMP_CONTROL.sv"
`include "LOAD_STORE_UNIT.sv"
`include "REGISTER_FILE.sv"
`include "CSR.sv"
`include "DATAPATH.sv"
`include "CORE.sv"

module wrapper(
        output logic [2:0] LEDS,
        input i_clk
    );

    //Parameters
    parameter IM_FILE = `IM_FILE;

    //Instruction Memory Signals
    logic [`WORD_SIZE -1:0] IM_instruction;
    logic [`WORD_SIZE -1:0] IM_addr;

    //Data Memory Signals

    logic [`WORD_SIZE -1:0] DM_rd;
    logic [`WORD_SIZE -1:0] DM_wd;
    logic [`WORD_SIZE -1:0] DM_addr;
    logic  [3:0] DM_wen;
    logic        DM_ren;

    logic rstn;

    assign rstn = 1; //HACK: While the the board pins are not attached

    always @(posedge i_clk) begin 
        if(DM_wen == 4'b1111) begin
            LEDS <= DM_wd[2:0];
        end
    end

    CORE core (
        .o_IM_addr(IM_addr),
        .o_DM_wd(DM_wd),
        .o_DM_addr(DM_addr),
        .o_DM_wen(DM_wen),
        .o_DM_ren(DM_ren),

        .i_IM_instruction(IM_instruction),
        .i_DM_rd(DM_rd),

        .i_clk(i_clk),
        .i_rstn(rstn)
    );

    INSTRUCTION_MEMORY #(`IM_DEPTH, IM_FILE) instruction_memory (
        .o_Instruction(IM_instruction), 
        .i_Addr(IM_addr)
    );

endmodule





