//@TODO:
//Create class to encpsulate the instruction item "traduction".
class test;

    //virtual memory_if vif_inst_mem;
    //virtual memory_if vif_data_mem;

    //Attributes
    instruction_item_t inst_item;//Instruction Item
    inst_minitor inst_monitor0;//Intruction Monitor
    rv32i model;


    function new(virtual memory_if vif_inst_mem, virtual memory_if vif_data_mem);
        //this.vif_inst_mem = vif_inst_mem;
        //this.vif_data_mem = vif_data_mem;
        this.inst_monitor0 = new(vif_inst_mem.monitor);
        this.model         = new("test");
    endfunction

    task run();
        //Control Race Condition
        semaphore mutex = new(1);//Mutex
        fork
            begin : thread_inst_monitor
                forever begin 
                    mutex.get(1);
                    this.inst_monitor0.run();
                    this.inst_item = this.inst_monitor0.inst_item;
                    mutex.put(1);
                end
            end
            begin : thread_model
                forever begin 
                    mutex.get(1);
                    this.model.instruction = this.inst_item.instruction;
                    this.model.rs1         = this.inst_item.rs1;
                    this.model.rs2         = this.inst_item.rs2;
                    this.model.rd          = this.inst_item.rd;
                    this.model.imm         = this.inst_item.imm;
                    mutex.put(1);
                    this.model.run();
                end
            end

        join
    endtask

endclass