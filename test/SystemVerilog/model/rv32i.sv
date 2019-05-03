class rv32i;

    static data_t pc;
    static regFile reg_f;
    static alu_t alu;
    static instMemory imem;
    static dataMemory dmem;

    data_t instruction_encoded;
    instruction_t instruction;
    logic [4:0]  rs1, rs2, rd;
    data_t imm;

    data_item_t data_trans;
    reg_file_item_t reg_file_trans;

    function new (string IM_FILE);
        this.pc = 0;
        this.reg_f = new;
        this.alu = new;
        this.imem = new(IM_FILE);
        this.dmem = new;
    endfunction 

    //Control Methods
    function void run ();
        this.execute();
        this.update_pc();
    endfunction

    function void reset ();
        this.pc = 0;
    endfunction

    //Get Methods
    function data_t get_reg(logic [4:0] rx);
        return this.reg_f.get_reg(rx);
    endfunction

    function data_t get_mem(data_t addr);
        return this.dmem.get_mem(addr);
    endfunction

    //Simulation Methods

    protected function void execute();
        this.reg_file_trans.regn[2] = this.rd;
        this.reg_file_trans.regn[1] = this.rs2;
        this.reg_file_trans.regn[0] = this.rs1;

        this.reg_file_trans.data[1] = this.reg_f.get_reg(rs2);
        this.reg_file_trans.data[0] = this.reg_f.get_reg(rs1);

        case (this.instruction)
            ADDI  : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_ADD , this.reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_ADD , this.reg_f.get_reg(this.rs1), this.imm));
            end
            SLLI  : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_SLL , this.reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLL , this.reg_f.get_reg(this.rs1), this.imm));
            end
            SLTI  : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_SLT , this.reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLT , this.reg_f.get_reg(this.rs1), this.imm));
            end
            SLTIU : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_SLTU , this.reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLTU, this.reg_f.get_reg(this.rs1), this.imm));
            end
            XORI  : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_XOR , this.reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_XOR , this.reg_f.get_reg(this.rs1), this.imm));
            end
            SRLI  : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_SRL , this.reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SRL , this.reg_f.get_reg(this.rs1), this.imm));
            end
            SRAI  : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_SRA , this.reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SRA , this.reg_f.get_reg(this.rs1), this.imm));
            end
            ORI   : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_OR , this.reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_OR  , this.reg_f.get_reg(this.rs1), this.imm));
            end
            ANDI  : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_AND , this.reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_AND , this.reg_f.get_reg(this.rs1), this.imm));
            end

            ADD   : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_ADD , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2));
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_ADD , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            end
            SUB   : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_SUB , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2));
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SUB , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            end
            SLL   : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_SLL , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2));
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLL , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            end
            SLT   : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_SLT , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2));
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLT , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            end
            SLTU  : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_SLTU , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2));
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLTU, this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            end
            XOR   : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_XOR , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2));
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_XOR , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            end
            SRL   : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_SRL , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2));
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SRL , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            end
            SRA   : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_SRA , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2));
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SRA , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            end
            OR    : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_OR , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2));
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_OR  , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            end
            AND   : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_AND , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2));
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_AND , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            end

            LUI   : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_LUI, null, this.imm);
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_LUI, null, this.imm));
            end
            AUIPC : begin
                this.reg_file_trans.data[2] = this.alu.operation(ALU_AUIPC, this.reg_f.get_reg(this.rs1), this.pc); 
                this.reg_f.set_reg(this.rd, this.alu.operation(ALU_AUIPC, this.reg_f.get_reg(this.rs1), this.pc));
            end

            BEQ   : this.beq (reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);
            BNE   : this.bne (reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);
            BLT   : this.blt (reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);
            BLTU  : this.bltu(reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);
            BGE   : this.beq (reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);
            BGEU  : this.bgeu(reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);

            LW    : begin 
                this.reg_file_trans.data[2] = this.lw (reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.lw (reg_f.get_reg(this.rs1), this.imm));
            end
            LH    : begin 
                this.reg_file_trans.data[2] = this.lh (reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.lh (reg_f.get_reg(this.rs1), this.imm));
            end
            LHU   : begin 
                this.reg_file_trans.data[2] = this.lhu (reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.lhu(reg_f.get_reg(this.rs1), this.imm));
            end
            LB    : begin 
                this.reg_file_trans.data[2] = this.lb (reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.lb (reg_f.get_reg(this.rs1), this.imm));
            end
            LBU   : begin 
                this.reg_file_trans.data[2] = this.lbu (reg_f.get_reg(this.rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.lbu(reg_f.get_reg(this.rs1), this.imm));
            end

            SW    : this.sw(this.reg_f.get_reg(rs1), this.reg_f.get_reg(rs2), this.imm);
            SH    : this.sh(this.reg_f.get_reg(rs1), this.reg_f.get_reg(rs2), this.imm);
            SB    : this.sb(this.reg_f.get_reg(rs1), this.reg_f.get_reg(rs2), this.imm);

            JAL   : begin
                this.reg_file_trans.data[2] = this.jal(this.imm);
                this.reg_f.set_reg(this.rd, this.jal(this.imm));
            end
            JALR  : begin
                this.reg_file_trans.data[2] = this.jalr(this.reg_f.get_reg(rs1), this.imm);
                this.reg_f.set_reg(this.rd, this.jalr(this.reg_f.get_reg(rs1), this.imm));
            end


            default : /* default */;
        endcase

    endfunction

    function void update_pc();
        this.pc = this.pc+4;
    endfunction

    //BRANCHES
    protected function void beq(data_t rs1, data_t rs2, data_t imm);
        if(rs1 === rs2 ) begin 
            this.pc = this.pc + signed'(imm << 1);
        end
    endfunction

    protected function void bne(data_t rs1, data_t rs2, data_t imm);
        if(rs1 !== rs2 ) begin 
            this.pc = this.pc + signed'(imm[11:0] << 1);
        end
    endfunction

    protected function void bltu(data_t rs1, data_t rs2, data_t imm);
        if(rs1 < rs2 ) begin 
            this.pc = this.pc + signed'(imm[11:0] << 1);
        end
    endfunction

    protected function void blt(data_t rs1, data_t rs2, data_t imm);
        if(signed'(rs1) === signed'(rs2) ) begin 
           this.pc = this.pc + signed'(imm[11:0] << 1);
        end
    endfunction

    protected function void bgeu(data_t rs1, data_t rs2, data_t imm);
        if(rs1 >= rs2 ) begin 
           this.pc = this.pc + signed'(imm[11:0] << 1);
        end
    endfunction

    protected function void bge(data_t rs1, data_t rs2, data_t imm);
        if(signed'(rs1) >= signed'(rs2) ) begin 
           this.pc = this.pc + signed'(imm[11:0] << 1);
        end
    endfunction


    //LOAD
    protected function data_t lw(data_t rs1, data_t imm);
        data_trans.addr      = signed'(imm)+rs1;
        data_trans.direction = READ;
        data_trans.data      = dmem.get_mem(signed'(imm)+rs1);

        return data_trans.data;
    endfunction

    protected function data_t lh(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem(signed'(imm)+rs1);
        temp_data = {{16{temp_data[31]}}, temp_data[15:0]};

        data_trans.addr      = signed'(imm)+rs1;
        data_trans.direction = READ;
        data_trans.data      = temp_data;

        return temp_data;
    endfunction

    protected function data_t lb(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem(signed'(imm)+rs1);
        temp_data = {{24{temp_data[31]}}, temp_data[7:0]};

        data_trans.addr      = signed'(imm)+rs1;
        data_trans.direction = READ;
        data_trans.data      = temp_data;

        return temp_data;
    endfunction

    protected function data_t lhu(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem(signed'(imm)+rs1);
        temp_data = {16'h0, temp_data[15:0]};

        data_trans.addr      = signed'(imm)+rs1;
        data_trans.direction = READ;
        data_trans.data      = temp_data;

        return temp_data;
    endfunction

    protected function data_t lbu(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem(signed'(imm)+rs1);
        temp_data = {24'h0, temp_data[7:0]};

        data_trans.addr      = signed'(imm)+rs1;
        data_trans.direction = READ;
        data_trans.data      = temp_data;

        return temp_data;
    endfunction

    //Store
    protected function void sw(data_t rs1, data_t rs2, data_t imm);
        data_trans.data      = rs2;
        data_trans.addr      = signed'(imm)+rs1;
        data_trans.direction = WRITE;

        dmem.set_mem(signed'(imm)+rs1, rs2);
    endfunction

    protected function void sh(data_t rs1, data_t rs2, data_t imm);
        data_t temp_data;
        temp_data = {{16{rs2[31]}}, rs2[15:0]};
        data_trans.data      = temp_data;
        data_trans.addr      = signed'(imm)+rs1;
        data_trans.direction = WRITE;

        dmem.set_mem(signed'(imm)+rs1, temp_data);
    endfunction

    protected function void sb(data_t rs1, data_t rs2, data_t imm);
        data_t temp_data;
        temp_data = {{24{rs2[31]}}, rs2[7:0]};
        data_trans.data      = temp_data;
        data_trans.addr      = signed'(imm)+rs1;
        data_trans.direction = WRITE;

        dmem.set_mem(signed'(imm)+rs1, temp_data);
    endfunction

    //JAL
    protected function data_t jal (data_t imm);
        data_t current_pc;
        current_pc = this.pc + 4;
        this.pc = this.pc + signed'(imm[11:0] << 1);
        return current_pc;
    endfunction 

    protected function data_t jalr (data_t rs1, data_t imm);
        data_t current_pc;
        current_pc = this.pc + 4;
        this.pc = this.pc + signed'(imm[11:0]) + signed'(rs1);
        return current_pc;
    endfunction 

endclass