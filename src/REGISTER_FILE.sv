//@TODO: Find a way to synthesise the reset

module REGISTER_FILE(
`ifndef YOSYS
    output data_t o_Rd1,
    output data_t o_Rd2,
    input  reg_t i_Rnum1,
    input  reg_t i_Rnum2,
`else 
    output logic [`WORD_SIZE -1:0] o_Rd1,
    output logic [`WORD_SIZE -1:0] o_Rd2,
    input  logic [4:0] i_Rnum1,
    input  logic [4:0] i_Rnum2,
`endif
    input  i_Wen,
`ifndef YOSYS
    input  reg_t i_Wnum,
    input  data_t i_Wd,
`else 
    input  logic [4:0] i_Wnum,
    input  logic [`WORD_SIZE -1:0] i_Wd,
`endif
    input  i_clk,
    input  i_rstn
    );

`ifndef YOSYS
    data_t x [`N_REG-1:0];//Registers [x0-x31]
`else 
    logic [`WORD_SIZE -1:0] x [`N_REG-1:0];//Registers [x0-x31]
`endif

	integer i; // Syntetizable?

//Initializing registers for tests
`ifdef TEST
    initial begin
        for(i=0;i<`N_REG;i=i+1) begin
            x[i] = i;
        end
    end
`endif

    //Reading is combinational
    //Read R0 return 0
    assign o_Rd1 = |i_Rnum1 ? x[i_Rnum1] : 0;
    assign o_Rd2 = |i_Rnum2 ? x[i_Rnum2] : 0;

    //Writing occurs just in the positive edge clk;
    always @(posedge i_clk) begin
`ifndef FPGA
        if(~i_rstn) begin
            for(i=0;i<`N_REG;i=i+1) begin
                x[i] <= 0;
            end
        end
        else begin 
`endif
            if (i_Wen) begin
                x[i_Wnum] <= i_Wd;
            end
`ifndef FPGA
        end
`endif

    end

endmodule
