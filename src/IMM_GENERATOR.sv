module IMM_GENERATOR(
     output data_t o_ExtendedImmediate,
     input  data_t i_Instruction
     );

    data_t ExtendedImmediate;


    always @(*) begin
        case(i_Instruction[6:0])
            `OP_I_TYPE   : ExtendedImmediate = {{20{i_Instruction[31]}}, i_Instruction[31:20]};
            `OP_I_L_TYPE : ExtendedImmediate = {{20{i_Instruction[31]}}, i_Instruction[31:20]};
            `OP_S_TYPE   : ExtendedImmediate = {{20{i_Instruction[31]}}, i_Instruction[31:25], i_Instruction[11:7]};
            `OP_B_TYPE   : ExtendedImmediate = {{20{i_Instruction[31]}}, i_Instruction[31], i_Instruction[7], i_Instruction[30:25], i_Instruction[11:8]};
            `OP_LUI	     : ExtendedImmediate = {{12{i_Instruction[31]}}, i_Instruction[31:12]};
            `OP_AUIPC    : ExtendedImmediate = {{12{i_Instruction[31]}}, i_Instruction[31:12]};
            `OP_JAL      : ExtendedImmediate = {{12{i_Instruction[31]}}, i_Instruction[19:12], i_Instruction[20], i_Instruction[30:21]};
            default      : ExtendedImmediate = 32'b0;
        endcase
    end

    assign o_ExtendedImmediate = ExtendedImmediate;

endmodule
