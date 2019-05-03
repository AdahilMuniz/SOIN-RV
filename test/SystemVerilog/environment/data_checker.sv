class data_checker;

    static integer wrong_transactions = 0;
    static error_data_item_t error_table [$];

    function void check (data_item_t model_data_trans, data_item_t dut_data_trans, instruction_item_t input_instruction);
        bit flag;
        error_data_item_t error_item;
        if(model_data_trans.data !== model_data_trans.data) begin 
            flag = 1;
            error_item.error_champ[0] = 1;
        end
        if(model_data_trans.addr !== model_data_trans.addr) begin 
            flag = 1;
            error_item.error_champ[1] = 1;
        end
        if(model_data_trans.direction !== model_data_trans.direction) begin 
            flag = 1;
            error_item.error_champ[2] = 1;
        end

        if(flag) begin
            this.wrong_transactions++;
            error_item.model_result = model_data_trans;
            error_item.dut_result = dut_data_trans;
            error_item.input_instruction = input_instruction;
            this.error_table.push_back(error_item);
            this.print_error(input_instruction);
        end

    endfunction 

    function void print ();
        $display("=============================================");
        $display("================DATA ERRORS==================");
        $display("=============================================");
        if(error_table.size() > 0) begin
            $display("Number of Errors: %d\n", this.wrong_transactions);
            
            foreach(error_table[i]) begin
                $display("|Instruction: %s |[DUT]   Direction: %s  |[DUT]   Addr: %8x  |[DUT]   Data:%8x  \n",
                error_table[i].input_instruction.instruction, error_table[i].dut_result.direction, error_table[i].dut_result.addr, error_table[i].dut_result.data);
                $display("                 |[MODEL] Direction: %s  |[MODEL] Addr: %8x  |[MODEL] Data:%8x  \n",
                error_table[i].model_result.direction, error_table[i].model_result.addr, error_table[i].model_result.data);
            end
        end
        else begin 
            $display("Thre are no errors, we are going well =)");
        end
    endfunction 

    protected function void print_error (instruction_item_t input_instruction);
        $display("** DATA_ERROR\n Instruction:%s \n RS1: %2d RS2: %2d RD: %2d IMM: %10d\n",
            input_instruction.instruction,
            input_instruction.rs1,
            input_instruction.rs2,
            input_instruction.rd,
            signed'(input_instruction.imm));
    endfunction

endclass