module LOAD_STORE_UNIT (
    output logic  [3:0] o_range_select,
`ifndef YOSYS
    output data_t       o_data_load,
    input  data_t       i_rd,
`else 
    output logic [`WORD_SIZE -1:0] o_data_load,
    input  logic [`WORD_SIZE -1:0] i_rd,
`endif
    input  logic  [1:0] i_low_addr,
    input  logic  [2:0] i_Func3,
    input  logic        i_wen,
    input  logic        i_ren
);

    always @(*) begin
        
        o_range_select = 4'b0000;
        o_data_load = 'h0;

        if(i_wen) begin
            case (i_Func3)
                `F3_TYPE0: begin //SB
                    case (i_low_addr)
                        2'b00   : o_range_select = 4'b0001;
                        2'b01   : o_range_select = 4'b0010;
                        2'b10   : o_range_select = 4'b0100;
                        2'b11   : o_range_select = 4'b1000;
                        default : o_range_select = 4'b0000;
                    endcase
                end
                `F3_TYPE1: begin //SH
                    case (i_low_addr)
                        2'b00   : o_range_select = 4'b0011;
                        2'b01   : o_range_select = 4'b0110;
                        2'b10   : o_range_select = 4'b1100;
                        //2'b11 -> Misaligned
                        default : o_range_select = 4'b0000;
                    endcase
                end
                `F3_TYPE2: o_range_select = 4'b1111; // SW

                default : o_range_select = 4'b0000;
            endcase
        end
        else if(i_ren) begin
            case (i_Func3)
                `F3_TYPE0: o_data_load = {{(`WORD_SIZE-`BYTE_SIZE){i_rd[(i_low_addr*`BYTE_SIZE+`BYTE_SIZE)-1]}}, i_rd[i_low_addr*`BYTE_SIZE +: `BYTE_SIZE]};
                `F3_TYPE1: o_data_load = {{(`HALF_SIZE){i_rd[(i_low_addr*`BYTE_SIZE+`HALF_SIZE)-1]}}, i_rd[i_low_addr*`BYTE_SIZE +: `HALF_SIZE]};
                `F3_TYPE2: o_data_load = i_rd;
                `F3_TYPE4: o_data_load = {{(`WORD_SIZE-`BYTE_SIZE){1'b0}}, i_rd[i_low_addr*`BYTE_SIZE +: `BYTE_SIZE]};
                `F3_TYPE5: o_data_load = {{(`HALF_SIZE){1'b0}}, i_rd[i_low_addr*`BYTE_SIZE +: `HALF_SIZE]};

                default : o_data_load = 'h0;
            endcase
        end
    end


endmodule

// 0000 0000 0000 0100

// bs = 0100