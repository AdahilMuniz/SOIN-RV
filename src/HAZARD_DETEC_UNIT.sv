module HAZARD_DETEC_UNIT (
    output logic       o_stall,
    //Read register signals from ID stage
    input  reg_t       i_ID_rnum1,
    input  reg_t       i_ID_rnum2,
    //Read register signals from EX stage
    input  logic       i_EX_memRead,
    input  reg_t       i_EX_wnum,
    input  logic       i_EX_wen
);


    always @(*) begin
        //
        if (i_EX_memRead  == 1'b1 & (i_EX_wnum == i_ID_rnum1 | i_EX_wnum == i_ID_rnum2)) begin
            o_stall = 1'b1;
        end
        else begin
            o_stall = 1'b0;
        end
    end

endmodule