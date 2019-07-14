//@TODO: Fix it

module DATA_MEMORY_V2(
`ifndef YOSYS
    output data_t o_Rd,
    input  data_t i_Wd,
    input  addr_t i_Addr,
`else 
    output logic [`WORD_SIZE -1:0] o_Rd,
    input  logic [`WORD_SIZE -1:0] i_Wd,
    input  logic [`WORD_SIZE -1:0] i_Addr,
`endif
    input  [3:0]i_Wen,
    input  i_Ren,
    input  i_clk
    );
    parameter HEIGHT = `DM_DEPTH;//Memory height
    parameter FILE = `DM_FILE;
    
`ifndef YOSYS
    data_t mem [HEIGHT-1:0];//Memory: Word: 4byte
`else 
    logic [`WORD_SIZE -1:0] mem [HEIGHT-1:0];//Memory: Word: 4byte
`endif

    initial begin
        $readmemh(FILE, mem);//Initialize Memory
    end

    always @(posedge i_clk) begin
        if (|i_Wen) begin
            case(i_Wen)
                //Byte 
                4'b1000 : mem[i_Addr>>2][31:24] <= i_Wd;
                4'b0100 : mem[i_Addr>>2][23:16] <= i_Wd;
                4'b0010 : mem[i_Addr>>2][15:8]  <= i_Wd;
                4'b0001 : mem[i_Addr>>2][7:0]   <= i_Wd;
                //Half-Word
                4'b1100 : mem[i_Addr>>2][31:16] <= i_Wd;
                4'b0110 : mem[i_Addr>>2][23:8]  <= i_Wd;
                4'b0011 : mem[i_Addr>>2][15:0]  <= i_Wd;
                //Word
                4'b1111 : mem[i_Addr>>2]        <= i_Wd;

                default : mem[i_Addr>>2]        <= i_Wd;
            endcase
        end
    end

    assign o_Rd = i_Ren ? mem[(i_Addr>>2)] : 32'b0;

endmodule
