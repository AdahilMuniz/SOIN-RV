`include "types_pkg.svh"

import types_pkg::*;

//DEFINES
`include "ALU_CONTROL.svh"
`include "OPCODES_DEFINES.svh"
`include "PARAMETERS.svh"
`include "PROJECT_CONFIG.svh"

//RV32I Files
`include "ALU.sv"
`include "ALU_CONTROL.sv"
`include "DATA_MEMORY.sv"
`include "DATAPATH.sv"
`include "IMM_GENERATOR.sv"
`include "INSTRUCTION_MEMORY.sv"
`include "MAIN_CONTROL.sv"
`include "BRANCH_JUMP_CONTROL.sv"
`include "LOAD_STORE_UNIT.sv"
`include "REGISTER_FILE.sv"
`include "DATAPATH.sv"
`include "CORE.sv"