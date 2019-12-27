`timescale 1ns/1ps 

`include "ALU_CONTROL.svh"
`include "OPCODES_DEFINES.svh"
`include "PARAMETERS.svh"
`include "PROJECT_CONFIG.svh"


`include "memory_if.sv"
`include "reg_file_if.sv"

`define CLK_PERIOD 40 //25MHz

//`define REGISTER_FILE_PATH dut.core.register_file
`define REGISTER_FILE_PATH dut.core.id_stage.register_file
`define DATA_MEMORY_PATH   dut.data_memory
`define INST_MEMORY_PATH   dut.instruction_memory
`define CORE_PATH          dut.core

import tb_pkg::*;

module tb;

    //Parameters
    parameter IM_FILE="dafault";

    //Classes
    test test0;

    //Inputs
    logic i_clk;
    logic i_rstn;

    //Interfaces
    bind `INST_MEMORY_PATH memory_if memory_if0(.clk(i_clk), .rstn(i_rstn), .addr(i_Addr), .rdata(o_Instruction)); //Binding: Instruction Memory Interface
    bind `DATA_MEMORY_PATH memory_if memory_if1(.clk(i_clk), .rstn(i_rstn), .addr(i_Addr), .rdata(o_Rd), .wdata(i_Wd), .ren(i_Ren), .wen(i_Wen)); //Binding: Data Memory Interface
    bind `REGISTER_FILE_PATH reg_file_if reg_file_if0(.clk(i_clk), .rstn(i_rstn), .rn1(i_Rnum1), .rn2(i_Rnum2), .wn(i_Wnum), .rd1(o_Rd1), .rd2(o_Rd2), .wd(i_Wd), .wen(i_Wen)); //Binding: Register File Interface
    test_if test_if0(.clk(i_clk), .rstn(i_rstn), .pc(`CORE_PATH.pc));
    //DUT
    DATAPATH #(IM_FILE) dut (
        .i_clk(i_clk),
        .i_rstn(i_rstn)
    );

    initial begin
        $display("IM_FILE: %s", IM_FILE);
        test0 = new(test_if0, `INST_MEMORY_PATH.memory_if0, `DATA_MEMORY_PATH.memory_if1, `REGISTER_FILE_PATH.reg_file_if0);
        i_clk = 1'b0;
        i_rstn = 1'b1;
        test0.run();
        $display("End Simulation");
        $finish;
    end

    //Clock generation
    always begin
        #(`CLK_PERIOD/2) i_clk = ~i_clk;
    end

    //Reset generation
    initial begin 
        #(`CLK_PERIOD)
        i_rstn = 1'b0;
        #(`CLK_PERIOD) 
        i_rstn = 1'b1;
    end
       
endmodule

