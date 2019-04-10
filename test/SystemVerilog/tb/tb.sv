`timescale 1ns/1ps 

`include "ALU_CONTROL.vh"
`include "OPCODES_DEFINES.vh"
`include "PARAMETERS.vh"
`include "PROJECT_CONFIG.vh"

`define CLK_PERIOD 40 //25MHz

`define REGISTER_FILE_PATH dut.core.register_file
`define DATA_MEMORY_PATH dut.data_memory

module tb;

    import tb_pkg::*;

    //Parameters
    parameter IM_FILE="dafault";

    rv32i model;

    //Inputs
    reg i_clk;
    reg i_rstn;

    //Testbench Attributes
    //string IM_FILE;

    task verification();
        begin 
            case (model.instruction_encoded[6:0])
                `OP_R_TYPE : begin 
                    if(`REGISTER_FILE_PATH.x[model.rd] !== model.get_reg(model.rd)) begin
                        $display("dut.x[%d] = %d, model.x[%d] = %d", model.get_rd(), `REGISTER_FILE_PATH.x[model.get_rd()], model.get_rd(),  model.get_reg(model.get_rd()));
                        $display("|R-type| **ERROR ");
                    end
                end
            
                `OP_I_TYPE : begin 
                    if(`REGISTER_FILE_PATH.x[model.get_rd()] !== model.get_reg(model.get_rd())) begin
                        $display("dut.x[%d] = %d, model.x[%d] = %d", model.get_rd(), `REGISTER_FILE_PATH.x[model.get_rd()], model.get_rd(),  model.get_reg(model.get_rd()));
                        $display("|I-type| **ERROR ");
                    end
                end
            
                `OP_I_L_TYPE : begin 
                    if(`REGISTER_FILE_PATH.x[model.get_rd()] !== model.get_reg(model.get_rd())) begin
                        $display("dut.x[%d] = %d, model.x[%d] = %d", model.get_rd(), `REGISTER_FILE_PATH.x[model.get_rd()], model.get_rd(),  model.get_reg(model.get_rd()));
                        $display("|I_L-type| **ERROR ");
                    end
                end
                `OP_S_TYPE : begin
                    if(`DATA_MEMORY_PATH.mem[model.get_imm()+model.get_rs1()] !== model.get_mem(model.get_imm()+model.get_rs1())) begin
                        $display("dut.x[%d] = %d, model.x[%d] = %d", model.get_rd(), `REGISTER_FILE_PATH.x[model.get_rd()], model.get_rd(),  model.get_reg(model.get_rd()));
                        $display("|I_L-type| **ERROR ");
                    end
                end
            
                `OP_B_TYPE : begin 
                end
            
                `OP_JAL : begin            
                 end
            
                `OP_JALR : begin 
                end
            
                `OP_LUI : begin 
                end
                `OP_AUIPC : begin 
                end
                default : /* default */;
            endcase
        end
    endtask

    DATAPATH #(IM_FILE) dut (
        .i_clk(i_clk),
        .i_rstn(i_rstn)
    );

    always @(posedge i_clk or negedge i_rstn) begin
        if(~i_rstn) begin
            model.reset_model();
        end else begin
            verification();
            model.run_model();
        end
    end

    initial begin
        $display("IM_FILE: %s", IM_FILE);
        model = new(IM_FILE);
        i_clk = 1'b0;
    end

    //Clock generation
    always begin
        #(`CLK_PERIOD/2) i_clk = ~i_clk;
    end

    //Reset generation
    initial begin 
        #5;
        i_rstn <= 1'b0;
        #5;
        i_rstn <= 1'b1;
    end
       
endmodule

