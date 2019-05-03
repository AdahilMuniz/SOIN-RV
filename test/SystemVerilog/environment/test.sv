class test;

    //Interfaces
    virtual test_if vif;

    //Attributes
    instruction_item_t inst_item;//Instruction Item
    data_item_t dut_data_trans;//Data Memory Transaction from DUT
    data_item_t model_data_trans;//Data Memory Transaction from model
    reg_file_item_t dut_reg_file_trans; //Reg File Transaction from DUT
    reg_file_item_t model_reg_file_trans;//Reg File Transaction from model

    inst_monitor inst_monitor0;//Intruction Monitor
    data_monitor data_monitor0;//Data Monitor
    reg_file_monitor reg_file_monitor0;//Register File Monitor

    data_checker data_checker0;
    reg_file_checker reg_file_checker0;
   
    rv32i model;


    function new(virtual test_if vif, virtual memory_if vif_inst_mem, virtual memory_if vif_data_mem, virtual reg_file_if vif_reg_file);
        this.vif           = vif;

        this.inst_monitor0     = new(vif_inst_mem);
        this.data_monitor0     = new(vif_data_mem);
        this.reg_file_monitor0 = new(vif_reg_file);

        this.data_checker0     = new();
        this.reg_file_checker0 = new();

        this.model             = new("test");
    endfunction

    task run();
        //Control Process communication
        semaphore mutex = new(1);
        event     get_data, check_data;
        event     get_reg, check_reg;
        
        fork
            begin : thread_inst_monitor
                forever begin 
                  mutex.get(1);
                  this.inst_monitor0.run();
                  this.inst_item = this.inst_monitor0.inst_item;
                  if(this.inst_item.instruction == NO_INST) begin
                      $display("No instruction fetch");
                      //Is it the best way?
                      break;
                  end
                  -> get_data;
                  -> get_reg;
                  mutex.put(1);
                end
            end
            begin : thread_data_monitor
                forever begin 
                    @(get_data);
                    this.data_monitor0.run();
                    this.dut_data_trans = this.data_monitor0.data_trans;
                    ->check_data;
                end
            end
            begin : thread_reg_file_monitor
                forever begin 
                    @(get_reg);
                    this.reg_file_monitor0.run();
                    this.dut_reg_file_trans = this.reg_file_monitor0.reg_trans;
                    ->check_reg;
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

                        this.model_data_trans     = this.model.data_trans;
                        this.model_reg_file_trans = this.model.reg_file_trans;
                    end
                    mutex.put(1);
                end
            end

            begin : thread_data_checker
                forever begin 
                    @(check_data);
                    this.data_checker0.check(this.model_data_trans, this.dut_data_trans, this.inst_item);
                end
            end

            begin : thread_reg_checker
                forever begin 
                    @(check_reg);
                    this.reg_file_checker0.check(this.model_reg_file_trans, this.dut_reg_file_trans, this.inst_item);
                end
            end

        join_any

        this.data_checker0.print();
        this.reg_file_checker0.print();

    endtask

endclass