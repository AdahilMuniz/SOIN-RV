module CSR (
    output reg_t        o_rd,
    input  logic [11:0] i_addr,
    input  reg_t        i_wd,
    input               i_en,
    input  logic [2:0]  i_Funct3,
    input               i_clk,
    input               i_rstn
);

    //Read
    always@(*) begin
        case (i_addr)
            `MISA_ADDR: o_rd = {`MISA_MXL, {(`WORD_SIZE-28){1'b0}}, `MISA_EXTENSION}; 
            default : /* default */;
        endcase
    end


endmodule