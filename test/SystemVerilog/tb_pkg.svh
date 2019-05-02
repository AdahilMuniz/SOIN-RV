package tb_pkg;

	import types_pkg::*;

	//Defines
	`include "ALU_CONTROL.vh"
	`include "OPCODES_DEFINES.vh"
	`include "PARAMETERS.vh"
	`include "PROJECT_CONFIG.vh"

	//Model classes
	`include "alu.sv"
	`include "instMemory.sv"
	`include "dataMemory.sv"
	`include "regFile.sv"
	`include "rv32i.sv"

	//Test environment classes
	`include "inst_monitor.sv"
	`include "data_monitor.sv"
	`include "reg_file_monitor.sv"
	`include "data_checker.sv"
	`include "reg_file_checker.sv"
	`include "test.sv"

endpackage