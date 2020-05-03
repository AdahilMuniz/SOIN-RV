`define WORD_SIZE 32
`define INST_SIZE 32

`define BYTE_SIZE 8
`define HALF_SIZE `WORD_SIZE/2

`define DM_DEPTH  32768 //Data Memory depth
`define IM_DEPTH  32768 //Instruction Memory depth

`define DM_FILE "../../../sw/RV32I/I_Type_Test.rv32i" //File tha initialize Data Memory
`ifndef YOSYS
`define IM_FILE "../../../sw/RV32I/I_Type_Test.rv32i" //File that initializes Instruction Memory
`endif

`define N_REG 32
//`define TEST