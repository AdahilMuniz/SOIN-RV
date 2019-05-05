package types_pkg;

    //Defines
    `include "ALU_CONTROL.svh"
    `include "OPCODES_DEFINES.svh"
    `include "PARAMETERS.svh"
    `include "PROJECT_CONFIG.svh"

    typedef logic [4:0] reg_t;
    typedef logic [`WORD_SIZE -1:0] data_t;
    typedef logic [`WORD_SIZE -1:0] addr_t;
    typedef enum logic [3:0] {ALU_ADD, ALU_SUB, ALU_SLL, ALU_SLT, ALU_SLTU, ALU_XOR, ALU_SRL, ALU_SRA, ALU_OR, ALU_AND, ALU_LUI, ALU_AUIPC} alu_operation_t;
    typedef enum logic [5:0] {ADDI, SLTI, SLTIU, ORI, XORI, ANDI, SLLI, SRLI, SRAI, JALR, LW, LB, LH, LBU, LHU, ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, LUI, AUIPC, JAL, SW, SB, SH, BEQ, BNE, BLT, BLTU, BGE, BGEU, NO_INST} instruction_t;
    typedef enum logic [3:0] {R_TYPE, I_TYPE, I_L_TYPE, S_TYPE, B_TYPE, U_TYPE, J_TYPE, NO_TYPE} instruction_type_t;
    typedef enum logic       {READ, WRITE} direction_t;

    typedef struct {
        instruction_t instruction;
        instruction_type_t instruction_type;
        reg_t         rs1;
        reg_t         rs2;
        reg_t         rd;
        data_t        imm;
    }instruction_item_t;

    typedef struct {
        data_t      data;
        addr_t      addr;
        direction_t direction;
    }data_item_t;

    typedef struct {
        data_t     data[3];
        reg_t      regn[3];
    }reg_file_item_t;

    typedef struct{
        instruction_item_t input_instruction;
        data_item_t        model_result;
        data_item_t        dut_result;
        logic [2:0]        error_champ;
    }error_data_item_t;

    typedef struct{
        instruction_item_t     input_instruction;
        reg_file_item_t        model_result;
        reg_file_item_t        dut_result;
        logic [2:0]            error_champ;
    }error_reg_file_item_t;

endpackage
