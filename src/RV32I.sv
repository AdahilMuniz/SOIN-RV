//DEFINES
`include "PROJECT_CONFIG.svh"
`include "ALU_CONTROL.svh"
`include "OPCODES_DEFINES.svh"
`include "PARAMETERS.svh"
`include "CSR_DEFINES.svh"

`ifndef YOSYS
`include "types_pkg.svh"
import types_pkg::*;
`endif

//RV32I Files
`include "FORWARDING_UNIT.sv"
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

`include "IF.sv"
`include "ID.sv"
`include "EX.sv"
`include "MEM.sv"
`include "WB.sv"

`include "CORE.sv"

`include "DATAPATH.sv"