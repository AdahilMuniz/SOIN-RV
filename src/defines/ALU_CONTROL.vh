//ALU Control
`define ALU_ADD   4'b0000
`define ALU_SUB   4'b1000
`define ALU_SLL   4'b0001
`define ALU_SLT   4'b0010
`define ALU_SLTU  4'b0011
`define ALU_XOR   4'b0100
`define ALU_SRL   4'b0101
`define ALU_SRA   4'b1101
`define ALU_OR    4'b0110
`define ALU_AND   4'b0111
`define ALU_LUI	  4'b1001
`define ALU_AUIPC 4'b1011	

//ALUOp
`define ALUOP_I_L   3'b000
`define ALUOP_B     3'b001
`define ALUOP_R     3'b010
`define ALUOP_I     3'b011
`define ALUOP_LUI   3'b100
`define ALUOP_AUIPC 3'b101