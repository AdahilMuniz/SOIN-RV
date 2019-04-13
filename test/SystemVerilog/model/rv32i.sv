class rv32i;

    protected static data_t pc;
    protected static regFile reg_f;
    protected static alu_t alu;
    protected static instMemory imem;
    protected static dataMemory dmem;


    data_t instruction_encoded;
    instruction_t instruction;
    logic [4:0]  rs1, rs2, rd;
    data_t imm;

    function new (string IM_FILE);
        this.pc = 0;
        this.reg_f = new;
        this.alu = new;
        this.imem = new(IM_FILE);
        this.dmem = new;
    endfunction 

    //Control Methods
    function void run_model ();
        this.fetch();
        this.decode();
        this.execute();
        this.update_pc();
    endfunction

    function void reset_model ();
        this.pc = 0;
    endfunction

    //Get Methods

    function data_t get_pc ();
        return this.pc;
    endfunction 

    function data_t get_instruction ();
        return this.instruction_encoded;
    endfunction 

    function data_t get_reg(logic [4:0] rx);
        return this.reg_f.get_reg(rx);
    endfunction

    function data_t get_mem(data_t addr);
        return this.dmem.get_mem(addr);
    endfunction

    function reg [4:0] get_rd ();
        return this.rd;
    endfunction

    function reg [4:0] get_rs1 ();
        return this.rs1;
    endfunction

    function reg [4:0] get_imm ();
        return this.imm;
    endfunction

    //Simulation Methods

    protected function void fetch ();
        this.instruction_encoded = imem.get_mem(this.pc);
    endfunction

    protected function void execute();
        case (this.instruction)
            ADDI  : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_ADD , this.reg_f.get_reg(this.rs1), this.imm));
            SLLI  : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLL , this.reg_f.get_reg(this.rs1), this.imm));
            SLTI  : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLT , this.reg_f.get_reg(this.rs1), this.imm));
            SLTIU : this.reg_f.set_reg(this.rd, this.alu.operation(ALU_SLTU, this.reg_f.get_reg(this.rs1), this.imm));
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
            SH    : this.sh(this.reg_f.get_reg(rs1), this.reg_f.get_reg(rs2), this.imm);
            SB    : this.sb(this.reg_f.get_reg(rs1), this.reg_f.get_reg(rs2), this.imm);

            JAL   : this.reg_f.set_reg(this.rd, this.jal(this.imm));
            JALR  : this.reg_f.set_reg(this.rd, this.jalr(this.reg_f.get_reg(rs1), this.imm));


            default : /* default */;
        endcase

    endfunction

    protected function void decode();
        logic [6:0]  opcode = this.instruction_encoded[6:0];
        logic [2:0]  funct3;
        logic [6:0]  funct7;
        //logic [4:0]  rs1, rs2, rd;
        //logic [11:0] imm;

        case (opcode)
            `OP_R_TYPE : begin 
                this.rs1    = this.instruction_encoded[19:15];
                this.rs2    = this.instruction_encoded[24:20];
                this.rd     = this.instruction_encoded[11:7 ];
                funct3 = this.instruction_encoded[14:12];
                funct7 = this.instruction_encoded[31:25];
                case (funct7)
                    `F7_TYPE0: begin
                        case (funct3)
                            `F3_TYPE0: begin
                                this.instruction = ADD;
                            end
                            `F3_TYPE1: begin
                                this.instruction = SLL;
                            end
                            `F3_TYPE2: begin
                                this.instruction = SLT;
                            end
                            `F3_TYPE3: begin
                                this.instruction = SLTU;
                            end
                            `F3_TYPE4: begin
                                this.instruction = XOR;
                            end
                            `F3_TYPE5: begin
                                this.instruction = SRL;
                            end
                            `F3_TYPE6: begin
                                this.instruction = OR;
                            end
                            `F3_TYPE7: begin
                                this.instruction = AND;
                            end
                            default : /* default */;
                        endcase
                    end
                    `F7_TYPE32: begin
                        case (funct3)
                            `F3_TYPE0: begin
                                this.instruction = SUB;
                            end
                            `F3_TYPE5: begin
                                this.instruction = SRA;
                            end
                            default : /* default */;
                        endcase
                    end
                    default : /* default */;
                endcase
            end
            `OP_I_TYPE : begin 
                this.rs1 = this.instruction_encoded[19:15];
                this.imm = 32'(signed'(this.instruction_encoded[31:20]));
                this.rd  = this.instruction_encoded[11:7];
                funct3 = this.instruction_encoded[14:12];
                funct7 = this.instruction_encoded[31:25];
                case (funct3)
                    `F3_TYPE0: begin
                        this.instruction = ADDI;
                    end
                    `F3_TYPE1: begin
                        this.imm  = 32'(signed'(this.instruction_encoded[24:20]));
                        this.instruction = SLLI;
                    end
                    `F3_TYPE2: begin
                        this.instruction = SLTI;
                    end
                    `F3_TYPE3: begin
                        this.instruction = SLTIU;
                    end
                    `F3_TYPE4: begin
                        this.instruction = XORI;
                    end
                    `F3_TYPE5: begin
                        this.imm  = 32'(signed'(this.instruction_encoded[24:20]));
                        case (funct7)
                            `F7_TYPE0: this.instruction = SRLI;
                            `F7_TYPE0: this.instruction = SRAI;
                            default : /* default */;
                        endcase
                        
                    end
                    `F3_TYPE6: begin
                        this.instruction = ORI;
                    end
                    `F3_TYPE7: begin
                        this.instruction = ANDI;
                    end
                    default : /* default */;
                endcase
            end
            `OP_I_L_TYPE : begin 
                this.rs1 = this.instruction_encoded[19:15];
                this.imm = 32'(signed'(this.instruction_encoded[24:20]));
                this.rd  = this.instruction_encoded[11:7];
                funct3   = this.instruction_encoded[14:12];

                case (funct3)
                    `F3_TYPE0: begin
                        this.instruction = LB;
                    end
                    `F3_TYPE1: begin
                        this.instruction = LH;
                    end
                    `F3_TYPE2: begin
                        this.instruction = LW;
                    end
                    `F3_TYPE4: begin
                        this.instruction = LBU;
                    end
                    `F3_TYPE5: begin
                        this.instruction = LHU;
                    end
                    default : /* default */;
                endcase

            end
            `OP_S_TYPE : begin 
                this.rs1 = this.instruction_encoded[19:15];
                this.rs2 = this.instruction_encoded[24:20];
                this.imm = 32'(signed'({this.instruction_encoded[31:25], this.instruction_encoded[11:7 ]}));
                this.rd  = this.instruction_encoded[11:7 ];
                funct3 = this.instruction_encoded[14:12];

                case (funct3)
                    `F3_TYPE0: begin
                        this.instruction = SB;
                    end
                    `F3_TYPE1: begin
                        this.instruction = SH;
                    end
                    `F3_TYPE2: begin
                        this.instruction = SW;
                    end
                    default : /* default */;
                endcase

            end
            `OP_B_TYPE : begin 
                this.rs1    = this.instruction_encoded[19:15];
                this.rs2    = this.instruction_encoded[24:20];
                this.imm    = 32'(signed'({this.instruction_encoded[31], this.instruction_encoded[7], this.instruction_encoded[30:25], this.instruction_encoded[11:8]}));
                funct3 = this.instruction_encoded[14:12];
                
                case (funct3)
                    `F3_TYPE0: begin
                        this.instruction = BEQ;
                    end
                    `F3_TYPE1: begin
                        this.instruction = BNE;
                    end
                    `F3_TYPE4: begin
                        this.instruction = BLT;
                    end
                    `F3_TYPE5: begin
                        this.instruction = BGE;
                    end
                    `F3_TYPE6: begin
                        this.instruction = BLTU;
                    end
                    `F3_TYPE7: begin
                        this.instruction = BGEU;
                    end
                    default : /* default */;
                endcase


            end
            `OP_JAL : begin 
                this.imm    = signed'({this.instruction_encoded[31], this.instruction_encoded[19:12], this.instruction_encoded[20], this.instruction_encoded[30:21]});
                this.instruction   = JAL;
            end
            `OP_JALR : begin 
                this.imm    = signed'(this.instruction_encoded[31:12]);
                this.instruction   = JALR;
            end

            `OP_LUI : begin 
                this.imm    = instruction_encoded[31:12];
                this.instruction   = LUI;
            end
            `OP_AUIPC : begin 
                this.imm    = instruction_encoded[31:12];
                this.instruction   = AUIPC;
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
        return dmem.get_mem(signed'(imm)+rs1);
    endfunction

    protected function data_t lh(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem(signed'(imm)+rs1);
        temp_data = {{16{temp_data[31]}}, temp_data[15:0]};
        return temp_data;
    endfunction

    protected function data_t lb(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem(signed'(imm)+rs1);
        temp_data = {{24{temp_data[31]}}, temp_data[7:0]};
        return temp_data;
    endfunction

    protected function data_t lhu(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem(signed'(imm)+rs1);
        temp_data = {16'h0, temp_data[15:0]};
        return temp_data;
    endfunction

    protected function data_t lbu(data_t rs1, data_t imm);
        data_t temp_data;
        temp_data = dmem.get_mem(signed'(imm)+rs1);
        temp_data = {24'h0, temp_data[7:0]};
        return temp_data;
    endfunction

    //Store
    protected function void sw(data_t rs1, data_t rs2, data_t imm);
        dmem.set_mem(signed'(imm)+rs1, rs2);
    endfunction

    protected function void sh(data_t rs1, data_t rs2, data_t imm);
        data_t temp_data;
        temp_data = {{16{rs2[31]}}, rs2[15:0]};
        dmem.set_mem(signed'(imm)+rs1, temp_data);
    endfunction

    protected function void sb(data_t rs1, data_t rs2, data_t imm);
        data_t temp_data;
        temp_data = {{24{rs2[31]}}, rs2[7:0]};
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