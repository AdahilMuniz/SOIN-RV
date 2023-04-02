module FORWARDING_UNIT (
    output logic [1:0] o_foward1_sel,
    output logic [1:0] o_foward2_sel,
    output logic       o_foward3_sel,
    //Read register signals from EX stage
    input  reg_t       i_EX_rnum1,
    input  reg_t       i_EX_rnum2,
    //Write register signals from MEM stage
    input  reg_t       i_MEM_wnum,
    input  logic       i_MEM_wen,
    //Write register signals from WB stage
    input  reg_t       i_WB_wnum,
    input  logic       i_WB_wen,
    //Write memory signals from MEM Stage
    input  logic       i_MEM_memWrite
);


    always @(*) begin
        //First ALU Operand forwarding selector definition
        if (i_MEM_wen == 1'b1 & i_MEM_wnum != 0 & i_MEM_wnum == i_EX_rnum1) begin
            o_foward1_sel = 2'b10;
        end
        else if (i_WB_wen  == 1'b1 & 
                 i_WB_wnum != 1'b0 & 
                 i_WB_wnum == i_EX_rnum1) begin
            o_foward1_sel = 2'b01;
        end
        else begin
            o_foward1_sel = 2'b00;
        end

        //Second ALU Operand forwarding selector definition
        if (i_MEM_wen == 1'b1 & i_MEM_wnum != 0 & i_MEM_wnum == i_EX_rnum2) begin
            o_foward2_sel = 2'b10;
        end
        else if (i_WB_wen  == 1'b1 & 
                 i_WB_wnum != 1'b0 & 
                 i_WB_wnum == i_EX_rnum2) begin
            o_foward2_sel = 2'b01;
        end
        else begin
            o_foward2_sel = 2'b00;
        end

        //Write data memory fowarding selector definition
        if (i_WB_wen  == 1'b1       &
            i_WB_wnum != 1'b0       &
            i_WB_wnum == i_EX_rnum2 &
            i_MEM_memWrite == 1'b1) begin
            o_foward3_sel = 1'b1;
        end
        else begin
            o_foward3_sel = 1'b0;
        end
    end

endmodule