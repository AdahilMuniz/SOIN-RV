class reg_file_checker;

    static integer wrong_transactions = 0;
    static error_reg_file_item_t error_table [$];

    function void check (reg_file_item_t model_reg_file_trans, reg_file_item_t dut_reg_file_trans, instruction_item_t input_instruction);
        bit flag = 0;
        error_reg_file_item_t error_item;

        foreach(model_reg_file_trans.data[i]) begin
            if(model_reg_file_trans.data[i] !== dut_reg_file_trans.data[i]) begin
                if(i === 0) begin
                    if(!(input_instruction.instruction_type inside {U_TYPE, J_TYPE})) begin
                        flag = 1;
                        error_item.error_champ[i] = 1;
                    end
                end
                else if(i === 1) begin
                    if(!(input_instruction.instruction_type inside {I_L_TYPE, I_TYPE , U_TYPE, J_TYPE})) begin
                        flag = 1;
                        error_item.error_champ[i] = 1;
                    end
                end
                else begin 
                    if(!(input_instruction.instruction_type inside {S_TYPE, B_TYPE})) begin
                        flag = 1;
                        error_item.error_champ[i] = 1;
                    end
                end
            end
        end

        foreach(model_reg_file_trans.regn[i]) begin
            if(model_reg_file_trans.regn[i] !== dut_reg_file_trans.regn[i]) begin
                if(i === 0) begin
                    if(!(input_instruction.instruction_type inside {U_TYPE, J_TYPE})) begin
                        flag = 1;
                        error_item.error_champ[i] = 1;
                    end
                end
                else if(i === 1) begin
                    if(!(input_instruction.instruction_type inside {I_L_TYPE, I_TYPE , U_TYPE, J_TYPE})) begin
                        flag = 1;
                        error_item.error_champ[i] = 1;
                    end
                end
                else begin 
                    if(!(input_instruction.instruction_type inside {S_TYPE, B_TYPE})) begin
                        flag = 1;
                        error_item.error_champ[i] = 1;
                    end
                end
            end
        end

        if(flag) begin
            this.wrong_transactions++;
            error_item.model_result      = model_reg_file_trans;
            error_item.dut_result        = dut_reg_file_trans;
            error_item.input_instruction = input_instruction;
            this.error_table.push_back(error_item);
            this.print_error (model_reg_file_trans, dut_reg_file_trans, input_instruction);
        end

    endfunction 

    function void print ();
        $display("=============================================");
        $display("================REG  ERRORS==================");
        $display("=============================================");
        if(error_table.size() > 0) begin
            logic [2:0] error_champ;
            $display("Number of Errors: %d\n", this.wrong_transactions);
            
            foreach(error_table[i]) begin
                $display("|Instruction: %s |[DUT]   Rn1: %2d  |[DUT]   Rd1: 0x%8x  |[DUT]   Rn2:%2d  |[DUT]   Rd2: 0x%8x  |[DUT]   Wn:%2d  |[DUT]   Wd: 0x%8x  \n",
                error_table[i].input_instruction.instruction, error_table[i].dut_result.regn[0], error_table[i].dut_result.data[0], error_table[i].dut_result.regn[1], error_table[i].dut_result.data[1],error_table[i].dut_result.regn[2], error_table[i].dut_result.data[2]);
                $display("                 |[MODEL] Rn1: %2d  |[MODEL] Rd1: 0x%8x  |[MODEL] Rn2:%2d  |[MODEL] Rd2: 0x%8x  |[MODEL] Wn:%2d  |[MODEL] Wd: 0x%8x  \n",
                error_table[i].model_result.regn[0], error_table[i].model_result.data[0], error_table[i].model_result.regn[1], error_table[i].model_result.data[1],error_table[i].model_result.regn[2], error_table[i].model_result.data[2]);
                error_champ = error_table[i].error_champ;
                foreach(error_champ[j]) begin
                    if(error_champ[j] === 1) begin
                        case (j)
                            'h0: $display("|There is an error in the RS1 field.");
                            'h1: $display("|There is an error in the RS2 field.");
                            'h2: $display("|There is an error in the RD  field.");
                            default : /* default */;
                        endcase
                    end
                end
                $display("\n");
            end
        end
        else begin 
            $display("Thre are no errors, we are going well =)");
        end
    endfunction 


    protected function void print_error (reg_file_item_t model_reg_file_trans, reg_file_item_t dut_reg_file_trans, instruction_item_t input_instruction);
        $display("** REG_FILE_ERROR\n Instruction:%s \n RS1: %2d RS2: %2d RD: %2d IMM: %8x\n",
            input_instruction.instruction,
            input_instruction.rs1,
            input_instruction.rs2,
            input_instruction.rd,
            signed'(input_instruction.imm)
            );
        $display("DUT Register File interface:\n Rn1:%2d   Rd1:%8x | Rn2:%2d   Rd2:%8x | Wn:%2d   Wd:%8x \n",
            dut_reg_file_trans.regn[0],
            dut_reg_file_trans.data[0],
            dut_reg_file_trans.regn[1],
            dut_reg_file_trans.data[1],
            dut_reg_file_trans.regn[2],
            dut_reg_file_trans.data[2]
            );
        $display("MODEL Register File interface:\n Rn1:%2d   Rd1:%8x | Rn2:%2d   Rd2:%8x | Wn:%d   Wd:%8x \n",
            model_reg_file_trans.regn[0],
            model_reg_file_trans.data[0],
            model_reg_file_trans.regn[1],
            model_reg_file_trans.data[1],
            model_reg_file_trans.regn[2],
            model_reg_file_trans.data[2]
            );

    endfunction

endclass