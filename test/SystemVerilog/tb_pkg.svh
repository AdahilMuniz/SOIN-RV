package tb_pkg;
	parameter WORD_SIZE 	= 32;
	parameter MEM_SIZE  	= 256;
	parameter REG_FILE_SIZE = 15;

	typedef logic [WORD_SIZE -1:0] data_t;
	typedef logic [WORD_SIZE -1:0] addr_t;
	typedef enum logic [3:0] {ALU_ADD, ALU_SUB, ALU_SLL, ALU_SLT, ALU_SLTU, ALU_XOR, ALU_SRL, ALU_SRA, ALU_OR, ALU_AND, ALU_LUI, ALU_AUIPC} alu_operation_t;
	typedef enum logic [5:0] {ADDI, SLTI, SLTIU, ORI, XORI, ANDI, SLLI, SRLI, SRAI, JALR, LW, LB, LH, LBU, LHU, ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, LUI, AUIPC, JAL, SW, SB, SH, BEQ, BNE, BLT, BLTU, BGE, BGEU} instruction_t;
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

endpackage