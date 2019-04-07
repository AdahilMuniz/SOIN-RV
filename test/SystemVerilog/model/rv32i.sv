class rv32i;

    protected static data_t pc;
    protected static regFile reg_f;
    protected static alu_t alu;
    protected static instMemory imem;
    protected static dataMemory dmem;

    protected data_t instruction;
    protected logic [4:0]  rs1, rs2, rd;
    protected logic [11:0] imm;

    function new ();
        this.reg_f = new;
        this.alu = new;
        this.imem = new;
        this.dmem = new;
    endfunction 

    function void run_model ();
        instruction_t inst;
        this.fetch();
        inst = this.decode();
        this.execute(inst);
    endfunction

    function void fetch ();
        this.instruction = imem.get_mem(this.pc);
    endfunction

    function void execute(instruction_t inst);
        case (inst)
            ADDI  : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_ADD , this.reg_f.get_reg(this.rs1), this.imm));
            SLLI  : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLL , this.reg_f.get_reg(this.rs1), this.imm));
            SLTI  : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLT , this.reg_f.get_reg(this.rs1), this.imm));
            XORI  : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_XOR , this.reg_f.get_reg(this.rs1), this.imm));
            SRLI  : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SRL , this.reg_f.get_reg(this.rs1), this.imm));
            SRAI  : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SRA , this.reg_f.get_reg(this.rs1), this.imm));
            ORI   : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_OR  , this.reg_f.get_reg(this.rs1), this.imm));
            ANDI  : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_AND , this.reg_f.get_reg(this.rs1), this.imm));

            ADD   : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_ADD , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            SUB   : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SUB , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            SLL   : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLL , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            SLT   : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLT , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            SLTU  : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLTU, this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            XOR   : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_XOR , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            SRL   : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SRL , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            SRA   : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SRA , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            OR    : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_OR  , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));
            AND   : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_AND , this.reg_f.get_reg(this.rs1), this.reg_f.get_reg(this.rs2)));

            LUI   : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_LUI, null, this.imm));
            AUIPC : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_AUIPC, this.reg_f.get_reg(this.rs1), this.pc));

            BEQ   : this.beq (reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);
            BNE   : this.bne (reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);
            BLT   : this.blt (reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);
            BLTU  : this.bltu(reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);
            BGE   : this.beq (reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);
            BGEU  : this.bgeu(reg_f.get_reg(this.rs1), reg_f.get_reg(this.rs2), this.imm);

            LW    : this.reg_f.set_reg(this.rd, this.lw (reg_f.get_reg(this.rs1), this.imm));
            LH    : this.reg_f.set_reg(this.rd, this.lh (reg_f.get_reg(this.rs1), this.imm));
            LHU   : this.reg_f.set_reg(this.rd, this.lhu(reg_f.get_reg(this.rs1), this.imm));
            LB    : this.reg_f.set_reg(this.rd, this.lb (reg_f.get_reg(this.rs1), this.imm));
            LBU   : this.reg_f.set_reg(this.rd, this.lbu(reg_f.get_reg(this.rs1), this.imm));

            SW    : this.sw(this.reg_f.get_reg(rs1), this.reg_f.get_reg(rs2), this.imm);
            SH    : this.sw(this.reg_f.get_reg(rs1), this.reg_f.get_reg(rs2), this.imm);
            SB    : this.sw(this.reg_f.get_reg(rs1), this.reg_f.get_reg(rs2), this.imm);

            JAL   : this.reg_f.set_reg(this.rd, this.jal(this.imm));
            JALR  : this.reg_f.set_reg(this.rd, this.jalr(this.reg_f.get_reg(rs1), this.imm));


            default : /* default */;
        endcase

    endfunction

    function instruction_t decode();
        logic [6:0]  opcode = this.instruction[6:0];
        logic [2:0]  funct3;
        logic [6:0]  funct7;
        logic [4:0]  rs1, rs2, rd;
        logic [11:0] imm;
        instruction_t inst;

        case (opcode)
            `OP_R_TYPE : begin 
                rs1    = this.instruction[19:15];
                rs2    = this.instruction[24:20];
                rd     = this.instruction[11:7 ];
                funct3 = this.instruction[14:12];
                funct7 = this.instruction[31:25];
                case (funct7)
                    `F7_TYPE0: begin
                        case (funct3)
                            `F3_TYPE0: begin
                                inst = ADD;
                            end
                            `F3_TYPE1: begin
                                inst = SLL;
                            end
                            `F3_TYPE2: begin
                                inst = SLT;
                            end
                            `F3_TYPE3: begin
                                inst = SLTU;
                            end
                            `F3_TYPE4: begin
                                inst = XOR;
                            end
                            `F3_TYPE5: begin
                                inst = SRL;
                            end
                            `F3_TYPE6: begin
                                inst = OR;
                            end
                            `F3_TYPE7: begin
                                inst = XOR;
                            end
                            default : /* default */;
                        endcase
                    end
                    `F7_TYPE32: begin
                        case (funct3)
                            `F3_TYPE0: begin
                                inst = SUB;
                            end
                            `F3_TYPE5: begin
                                inst = SRA;
                            end
                            default : /* default */;
                        endcase
                    end
                    default : /* default */;
                endcase
            end
            `OP_I_TYPE : begin 
                rs1 = this.instruction[19:15];
                imm = this.instruction[24:20];
                rd  = this.instruction[11:7];
                funct3 = this.instruction[14:12];
                funct7 = this.instruction[31:25];
                case (funct3)
                    `F3_TYPE0: begin
                        inst = ADDI;
                    end
                    `F3_TYPE1: begin
                        imm  = this.instruction[24:20];
                        inst = SLLI;
                    end
                    `F3_TYPE2: begin
                        inst = SLTI;
                    end
                    `F3_TYPE3: begin
                        inst = SLTIU;
                    end
                    `F3_TYPE4: begin
                        inst = XORI;
                    end
                    `F3_TYPE5: begin
                        imm  = this.instruction[24:20];
                        case (funct7)
                            `F7_TYPE0: inst = SRLI;
                            `F7_TYPE0: inst = SRAI;
                            default : /* default */;
                        endcase
                        
                    end
                    `F3_TYPE6: begin
                        inst = ORI;
                    end
                    `F3_TYPE7: begin
                        inst = ANDI;
                    end
                    default : /* default */;
                endcase
            end
            `OP_I_L_TYPE : begin 
                rs1 = this.instruction[19:15];
                imm = this.instruction[24:20];
                rd  = this.instruction[11:7];
                funct3 = this.instruction[14:12];

                case (funct3)
                    `F3_TYPE0: begin
                        inst = LB;
                    end
                    `F3_TYPE1: begin
                        inst = LH;
                    end
                    `F3_TYPE2: begin
                        inst = LW;
                    end
                    `F3_TYPE4: begin
                        inst = LBU;
                    end
                    `F3_TYPE5: begin
                        inst = LHU;
                    end
                    default : /* default */;
                endcase

            end
            `OP_S_TYPE : begin 
                rs1 = this.instruction[19:15];
                imm = {this.instruction[31:25], this.instruction[11:7 ]};
                rd  = this.instruction[11:7 ];
                funct3 = this.instruction[14:12];

                case (funct3)
                    `F3_TYPE0: begin
                        inst = SB;
                    end
                    `F3_TYPE1: begin
                        inst = SH;
                    end
                    `F3_TYPE2: begin
                        inst = SW;
                    end
                    default : /* default */;
                endcase

            end
            `OP_B_TYPE : begin 
                rs1    = this.instruction[19:15];
                rs2    = this.instruction[24:20];
                imm    = {this.instruction[31], this.instruction[7], this.instruction[30:25], this.instruction[11:8]};
                funct3 = this.instruction[14:12];
                
                case (funct3)
                    `F3_TYPE0: begin
                        inst = BEQ;
                    end
                    `F3_TYPE1: begin
                        inst = BNE;
                    end
                    `F3_TYPE4: begin
                        inst = BLT;
                    end
                    `F3_TYPE5: begin
                        inst = BGE;
                    end
                    `F3_TYPE6: begin
                        inst = BLTU;
                    end
                    `F3_TYPE7: begin
                        inst = BGEU;
                    end
                    default : /* default */;
                endcase


            end
            `OP_JAL : begin 
                imm    = {this.instruction[31], this.instruction[19:12], this.instruction[20], this.instruction[30:21]};
                inst   = JAL;
            end
            `OP_JALR : begin 
                imm    = this.instruction[31:12];
                inst   = JALR;
            end

            `OP_LUI : begin 
                imm    = instruction[31:12];
                inst   = LUI;
            end
            `OP_AUIPC : begin 
                imm    = instruction[31:12];
                inst   = AUIPC;
            end
            default : /* default */;
        endcase
        
        return inst;

    endfunction

    function void update_pc();
        this.pc++;
    endfunction

    //BRANCHES
    protected function void beq(data_t rs1, data_t rs2, data_t imm);
        if(rs1 === rs2 ) begin 
            this.pc = this.pc + $signed(imm << 1);
        end
    endfunction

    protected function void bne(data_t rs1, data_t rs2, data_t imm);
        if(rs1 !== rs2 ) begin 
            this.pc = this.pc + $signed(imm[11:0] << 1);
        end
    endfunction

    protected function void bltu(data_t rs1, data_t rs2, data_t imm);
        if(rs1 < rs2 ) begin 
            this.pc = this.pc + $signed(imm[11:0] << 1);
        end
    endfunction

    protected function void blt(data_t rs1, data_t rs2, data_t imm);
        if($signed(rs1) === $signed(rs2) ) begin 
           this.pc = this.pc + $signed(imm[11:0] << 1);
        end
    endfunction

    protected function void bgeu(data_t rs1, data_t rs2, data_t imm);
        if(rs1 >= rs2 ) begin 
           this.pc = this.pc + $signed(imm[11:0] << 1);
        end
    endfunction

    protected function void bge(data_t rs1, data_t rs2, data_t imm);
        if($signed(rs1) >= $signed(rs2) ) begin 
           this.pc = this.pc + $signed(imm[11:0] << 1);
        end
    endfunction


    //LOAD
    protected function data_t lw(data_t rs1, data_t imm);
        return dmem.get_mem($signed(imm)+rs1);
    endfunction

    protected function data_t lh(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem($signed(imm)+rs1);
        temp_data = {{16{temp_data[31]}}, temp_data[15:0]};
        return temp_data;
    endfunction

    protected function data_t lb(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem($signed(imm)+rs1);
        temp_data = {{24{temp_data[31]}}, temp_data[7:0]};
        return temp_data;
    endfunction

    protected function data_t lhu(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem($signed(imm)+rs1);
        temp_data = {16'h0, temp_data[15:0]};
        return temp_data;
    endfunction

    protected function data_t lbu(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem($signed(imm)+rs1);
        temp_data = {24'h0, temp_data[7:0]};
        return temp_data;
    endfunction

    //Store
    protected function void sw(data_t rs1, data_t rs2, data_t imm);
        dmem.set_mem($signed(imm)+rs1, rs2);
    endfunction

    protected function void sh(data_t rs1, data_t rs2, data_t imm);
        data_t temp_data;
        temp_data = {{16{rs2[31]}}, rs2[15:0]};
        dmem.set_mem($signed(imm)+rs1, temp_data);
    endfunction

    protected function void sb(data_t rs1, data_t rs2, data_t imm);
        data_t temp_data;
        temp_data = {{24{rs2[31]}}, rs2[7:0]};
        dmem.set_mem($signed(imm)+rs1, temp_data);
    endfunction

    //JAL
    protected function data_t jal (data_t imm);
        data_t current_pc;
        current_pc = this.pc + 4;
        this.pc = this.pc + $signed(imm[11:0] << 1);
        return current_pc;
    endfunction 

    protected function data_t jalr (data_t rs1, data_t imm);
        data_t current_pc;
        current_pc = this.pc + 4;
        this.pc = this.pc + $signed(imm[11:0]) + $signed(rs1);
        return current_pc;
    endfunction 

endclass