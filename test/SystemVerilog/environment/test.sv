//`include "memory_if.sv"

class test;

    //virtual memory_if vif_inst_mem;
    //virtual memory_if vif_data_mem;

    inst_minitor inst_monitor0;

    function new(virtual memory_if vif_inst_mem, virtual memory_if vif_data_mem);
        //this.vif_inst_mem = vif_inst_mem;
        //this.vif_data_mem = vif_data_mem;
        this.inst_monitor0 = new(vif_inst_mem.monitor);
    endfunction

    task run();
        fork
            begin : thread_inst_monitor
                forever begin 
                    this.inst_monitor0.run();
                end
            end
        join
    endtask

endclass