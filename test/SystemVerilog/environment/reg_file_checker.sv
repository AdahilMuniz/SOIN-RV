//@TODO: Workaround the Wn comparation
//       Create print function

class reg_file_checker;

    static integer wrong_transactions;
    static error_reg_file_item_t error_table [$];

    function void check (reg_file_item_t model_reg_file_trans, reg_file_item_t dut_reg_file_trans, instruction_item_t input_instruction);
        bit flag;
        error_reg_file_item_t error_item;

        foreach(model_reg_file_trans.data[i]) begin
            if(model_reg_file_trans.data[i] !== dut_reg_file_trans.data[i]) begin
                if(i === 1) begin
                    if(!(input_instruction.instruction_type inside {I_L_TYPE, I_TYPE , U_TYPE, J_TYPE})) begin
                        flag = 1;
                        error_item.error_champ[i] = 1;
                    end
                end
                else begin 
                    flag = 1;
                    error_item.error_champ[i] = 1;
                end
            end
        end

        foreach(model_reg_file_trans.regn[i]) begin
            if(model_reg_file_trans.regn[i] !== dut_reg_file_trans.regn[i]) begin
                if(i === 1) begin
                    if(!(input_instruction.instruction_type inside {I_L_TYPE, I_TYPE , U_TYPE, J_TYPE})) begin
                        flag = 1;
                        error_item.error_champ[i] = 1;
                    end
                end
                else if(i === 2) begin
                    if(!(input_instruction.instruction_type inside {S_TYPE, B_TYPE})) begin
                        flag = 1;
                        error_item.error_champ[i] = 1;
                    end
                end
                else begin 
                    flag = 1;
                    error_item.error_champ[i] = 1;
                end
            end
        end

        if(flag) begin
            this.wrong_transactions++;
            error_item.model_result      = model_reg_file_trans;
            error_item.dut_result        = dut_reg_file_trans;
            error_item.input_instruction = input_instruction;

            $display("** REG_FILE_ERROR\n Instruction:%s \n RS1: %2d RS2: %2d RD: %2d IMM: %10d\n
                     DUT Register File interface:\n Rn1:%d   Rd1:%d | Rn2:%d   Rd2:%d | Wn:%d   Wd:%d \n
                     MODEL Register File interface:\n Rn1:%d   Rd1:%d | Rn2:%d   Rd2:%d | Wn:%d   Wd:%d \n",
            input_instruction.instruction,
            input_instruction.rs1,
            input_instruction.rs2,
            input_instruction.rd,
            signed'(input_instruction.imm),
            dut_reg_file_trans.regn[0],
            dut_reg_file_trans.data[0],
            dut_reg_file_trans.regn[1],
            dut_reg_file_trans.data[1],
            dut_reg_file_trans.regn[2],
            dut_reg_file_trans.data[2],
            model_reg_file_trans.regn[0],
            model_reg_file_trans.data[0],
            model_reg_file_trans.regn[1],
            model_reg_file_trans.data[1],
            model_reg_file_trans.regn[2],
            model_reg_file_trans.data[2]);
        end

       this.error_table.push_back(error_item);

    endfunction 

endclass