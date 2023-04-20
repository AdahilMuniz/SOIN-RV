module CSR (
`ifndef YOSYS
    output data_t       o_rd,
    input  data_t       i_wd,
`else 
    output logic [`WORD_SIZE-1:0]  o_rd,
    input  logic [`WORD_SIZE-1:0]  i_wd,
`endif
    input  logic [11:0] i_addr,
    input               i_en,
    input  logic [2:0]  i_Funct3,
    input               i_clk,
    input               i_rstn
);

    //Read
    always@(*) begin
        if(i_en) begin //Is it better do the selection or let the output floating?
            case (i_addr)
                `MISA_ADDR: o_rd = {`MISA_MXL, {(`WORD_SIZE-28){1'b0}}, `MISA_EXTENSION}; 
                default : o_rd = 'h0;
            endcase
        end
        else begin
            o_rd = 'h0;
        end
    end


endmodule