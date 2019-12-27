module IF ( 
    //PC
`ifndef YOSYS
    output data_t       o_pc,
`else
    output logic [`WORD_SIZE -1:0] o_pc,
`endif
    //SUM 4
`ifndef YOSYS
    data_t o_S_FOUR,
`else 
    logic [`WORD_SIZE -1:0] o_S_FOUR,
`endif

    input  logic  [1:0] i_sel,
`ifndef YOSYS
    input  data_t       i_sum_branch_r, //Sum Branch Result
    input  data_t       i_jalr_r, // JALR Result
`else 
    input  logic [`WORD_SIZE -1:0] i_sum_branch_r, //Sum Branch Result
    input  logic [`WORD_SIZE -1:0] i_jalr_r, // JALR Result
`endif
    input               i_clk,  // Clock
    input               i_rstn  // Asynchronous reset active low
);

    //PC
`ifndef YOSYS
    data_t pc;
`else 
    logic [`WORD_SIZE -1:0] pc;
`endif
    //MUX PC
`ifndef YOSYS
    data_t mux_pc;
`else 
    logic [`WORD_SIZE -1:0] mux_pc;
`endif

    /****PC Update****/
    always @(posedge i_clk) begin
        if(~i_rstn) begin
            pc <= 0;
        end
        else begin 
            pc <= mux_pc;
        end
    end

    /****SUM-4-PC****/
    assign o_S_FOUR = pc + 4;

    //PC Source
    assign mux_pc = i_sel[1] ? i_jalr_r : (i_sel[0] ? i_sum_branch_r : o_S_FOUR);

    //PC Output
    assign o_pc = pc;

endmodule