module FORWARDING_UNIT (
    output logic [1:0] o_foward1_sel,
    output logic [1:0] o_foward2_sel,
    //Read register numbers from EX stage
    input  reg_t       i_EX_rnum1,
    input  reg_t       i_EX_rnum2,
    //Write register number from MEM stage
    input  reg_t       i_MEM_wnum,
    input  logic       i_MEM_wen,
    //Write register number from WB stage
    input  reg_t       i_WB_wnum,
    input  logic       i_WB_wen
);


    always @(*) begin
        //First ALU Operand forwardin selector definition
        if (i_MEM_wen == 1'b1 & i_MEM_wnum != 0 & i_MEM_wnum == i_EX_rnum1) begin
            o_foward1_sel = 2'b10;
        end
        else if (i_WB_wen  == 1'b1 & 
                 i_WB_wnum != 0    & 
                 i_WB_wnum == i_EX_rnum1) begin
            o_foward1_sel = 2'b01;
        end
        else begin
            o_foward1_sel = 2'b00;
        end

        //Second ALU Operand forwardin selector definition
        if (i_MEM_wen == 1'b1 & i_MEM_wnum != 0 & i_MEM_wnum == i_EX_rnum2) begin
            o_foward2_sel = 2'b10;
        end
        else if (i_WB_wen  == 1'b1 & 
                 i_WB_wnum != 0    & 
                 i_WB_wnum == i_EX_rnum2) begin
            o_foward2_sel = 2'b01;
        end
        else begin
            o_foward2_sel = 2'b00;
        end
    end

endmodule