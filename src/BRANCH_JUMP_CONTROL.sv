module BRANCH_JUMP_CONTROL (
    output logic [1:0] o_B_J_result,
    input  logic i_Branch,
    input  logic i_Jump,
    input  logic i_Zero,
    input  logic [2:0] i_Funct3
);

    always @(*) begin
        o_B_J_result = 2'b0;
        //if(i_Branch) begin
        //    case (i_Funct3)
        //        `F3_TYPE0: o_B_J_result =  i_Zero;
        //        `F3_TYPE1: o_B_J_result = ~i_Zero;
        //        `F3_TYPE4: o_B_J_result = ~i_Zero;
        //        `F3_TYPE5: o_B_J_result =  i_Zero;
        //        `F3_TYPE6: o_B_J_result = ~i_Zero;
        //        `F3_TYPE7: o_B_J_result =  i_Zero;
        //        default :  o_B_J_result = 2'b0;
        //    endcase
        //end
        //else if(i_Jump) begin
        //    o_B_J_result = 2'b01;
        //end
        case ({i_Jump, i_Branch})
            2'b01: begin 
                case (i_Funct3)
                    `F3_TYPE0: o_B_J_result =  i_Zero;
                    `F3_TYPE1: o_B_J_result = ~i_Zero;
                    `F3_TYPE4: o_B_J_result = ~i_Zero;
                    `F3_TYPE5: o_B_J_result =  i_Zero;
                    `F3_TYPE6: o_B_J_result = ~i_Zero;
                    `F3_TYPE7: o_B_J_result =  i_Zero;
                    default :  o_B_J_result = 2'b0;
                endcase
            end
            2'b10: o_B_J_result = 2'b01;
            2'b11: o_B_J_result = 2'b11;
            default : o_B_J_result = 2'b0;
        endcase
    end

endmodule