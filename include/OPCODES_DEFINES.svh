//OPCodes Defines

`define OP_R_TYPE   7'b0110011 //R-Type OPCode
`define OP_I_TYPE   7'b0010011 //I-Type OPCode
`define OP_I_L_TYPE 7'b0000011 //I-Type (Load) OPCode
`define OP_S_TYPE   7'b0100011 //S-Type OPCode
`define OP_B_TYPE   7'b1100011 //B-Type OPCode
`define OP_JAL      7'b1101111 //JAL OPCode
`define OP_JALR     7'b1100111 //JALR OPCode
`define OP_LUI      7'b0110111 //LUI OPCode
`define OP_AUIPC    7'b0010111 //AUIPC OPCode
`define OP_SYSTEM   7'b1110011 //AUIPC OPCode

//Funct7 Defines
`define F7_TYPE0 7'b0000000
`define F7_TYPE32 7'b0100000

//Funct3 Defines
`define F3_TYPE0 3'b000
`define F3_TYPE1 3'b001
`define F3_TYPE2 3'b010
`define F3_TYPE3 3'b011
`define F3_TYPE4 3'b100
`define F3_TYPE5 3'b101
`define F3_TYPE6 3'b110
`define F3_TYPE7 3'b111