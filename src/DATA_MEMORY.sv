//@TODO: Fix it
module DATA_MEMORY(
`ifndef YOSYS
    output data_t o_Rd,
    input  data_t i_Wd,
    input  addr_t i_Addr,
`else 
    output logic [`WORD_SIZE -1:0] o_Rd,
    input  logic [`WORD_SIZE -1:0] i_Wd,
    input  logic [`WORD_SIZE -1:0] i_Addr,
`endif
    
    input  i_Wen,
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
        if (i_Wen) begin
            mem[i_Addr>>2] <= i_Wd;
        end
    end
    
    assign o_Rd = i_Ren ? mem[(i_Addr>>2)] : 32'b0;


endmodule
