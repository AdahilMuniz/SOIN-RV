class alu_t;

    protected logic zero;
    protected data_t result;

    function data_t operation(alu_operation_t op, data_t op1, data_t op2);
        case (op)
            ALU_ADD   : result = add(op1, op2);
            ALU_SUB   : result = sub(op1, op2);
            ALU_SLL   : result = sll(op1, op2);
            ALU_SLT   : result = slt(op1, op2);
            ALU_SLTU  : result = sltu(op1, op2);
            ALU_XOR   : result = xor_f(op1, op2);
            ALU_SRL   : result = srl(op1, op2);
            ALU_SRA   : result = sra(op1, op2);
            ALU_OR    : result = or_f(op1, op2);
            ALU_AND   : result = and_f(op1, op2);
            ALU_LUI   : result = lui(op2);
            ALU_AUIPC : result = auipc(op1, op2);
            default : /* default */;
        endcase

        if(result === 0) begin
            zero = 1;
        end

        return result;

    endfunction

    function data_t get_result ();
        return result;
    endfunction
 
    function data_t get_zero ();
        return zero;
    endfunction

    protected function data_t add(data_t op1, data_t op2);
        return op1+op2;
    endfunction

    protected function data_t sub(data_t op1, data_t op2);
        return op1-op2;
    endfunction

    protected function data_t or_f(data_t op1, data_t op2);
        return op1 | op2;
    endfunction

    protected function data_t and_f(data_t op1, data_t op2);
        return op1 & op2;
    endfunction

    protected function data_t xor_f(data_t op1, data_t op2);
        return op1 ^ op2;
    endfunction

    protected function data_t sll(data_t op1, data_t op2);
        return op1 << op2;
    endfunction

    protected function data_t slt(data_t op1, data_t op2);
        if(signed'(op1)<signed'(op2)) begin
            return 1;
        end
        else begin 
            return 0;
        end
    endfunction

    protected function data_t sltu(data_t op1, data_t op2);
        if(op1<op2) begin
            return 1;
        end
        else begin 
            return 0;
        end
    endfunction

    protected function data_t srl(data_t op1, data_t op2);
        return op1 >> op2;
    endfunction

    protected function data_t sra(data_t op1, data_t op2);
        return op1 >>> op2;
    endfunction

    protected function data_t lui(data_t op2);
        return op2<<12;
    endfunction

    protected function data_t auipc(data_t op1, data_t op2);
        return this.lui(op2) + op1;
    endfunction

endclass