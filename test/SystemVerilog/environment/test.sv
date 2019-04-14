//@TODO:
//Create class to encpsulate the instruction item "traduction".
class test;

    //Interfaces
    virtual test_if vif;

    //Attributes
    instruction_item_t inst_item;//Instruction Item
    data_item_t data_trans;//Data Memory Transaction
    inst_monitor inst_monitor0;//Intruction Monitor
    data_monitor data_monitor0;//Data Monitor
    rv32i model;


    function new(virtual test_if vif, virtual memory_if vif_inst_mem, virtual memory_if vif_data_mem);
        this.vif           = vif;
        this.inst_monitor0 = new(vif_inst_mem);
        this.data_monitor0 = new(vif_data_mem);
        this.model         = new("test");
    endfunction

    task run();
        //Control Process communication
        semaphore mutex = new(1);
        
        fork
            begin : thread_inst_monitor
                forever begin 
                  mutex.get(1);
                  this.inst_monitor0.run();
                  this.inst_item = this.inst_monitor0.inst_item;
                  mutex.put(1);
                end
            end
            begin : thread_data_monitor
                forever begin 

                    this.data_monitor0.run();
                    this.data_trans = this.data_monitor0.data_trans;

                end
            end
            begin : thread_model
                forever begin 
                    mutex.get(1);
                    if(~vif.rstn) begin
                        model.reset();
                        $display("TEST: Waiting reset");
                        @(vif.rstn);
                    end
                    else begin 
                        this.model.instruction = this.inst_item.instruction;
                        this.model.rs1         = this.inst_item.rs1;
                        this.model.rs2         = this.inst_item.rs2;
                        this.model.rd          = this.inst_item.rd;
                        this.model.imm         = this.inst_item.imm;
                        this.model.run();
                    end
                    mutex.put(1);
                end
            end
        join_none

    endtask

endclass