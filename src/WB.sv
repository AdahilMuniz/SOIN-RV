module WB (

`ifndef YOSYS
    output data_t o_RF_wd,
`else 
    output logic [`WORD_SIZE -1:0] o_RF_wd,
`endif
    input logic [1:0] i_regSrc,

`ifndef YOSYS
    input data_t i_CSR_rd,
    input data_t i_S_FOUR,
    input data_t i_LSU_data_load,
    input data_t i_ALU_Result
`else 
    input logic [`WORD_SIZE-1:0] i_CSR_rd,
    input logic [`WORD_SIZE-1:0] i_S_FOUR,
    input logic [`WORD_SIZE-1:0] i_LSU_data_load,
    input logic [`WORD_SIZE-1:0] i_ALU_Result
`endif
);


    //Write Data (Register File) Source
    assign o_RF_wd = i_regSrc[1] ? (i_regSrc[0] ? i_CSR_rd:i_S_FOUR) : 
                                  (i_regSrc[0] ? i_LSU_data_load  : i_ALU_Result);

endmodule