class data_checker;

    static integer wrong_transactions;
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
            wrong_transactions++;
            error_item.model_result = model_data_trans;
            error_item.dut_result = dut_data_trans;
            error_item.input_instruction = input_instruction;

            $display("** DATA_ERROR\n Instruction:%s \n RS1: %2d RS2: %2d RD: %2d IMM: %10d\n",
            input_instruction.instruction,
            input_instruction.rs1,
            input_instruction.rs2,
            input_instruction.rd,
            signed'(input_instruction.imm));
        end

       this.error_table.push_back(error_item);

    endfunction 

endclass