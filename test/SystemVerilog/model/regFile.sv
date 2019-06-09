class regFile;
    protected static data_t x [31:0];

    function new ();
        x[0] = 0;
    endfunction

    function void reset();
        foreach(x[i]) begin
            x[i] = 0;
        end
    endfunction

    function void set_reg(addr_t addr, data_t data);
        if(addr !== 0) begin 
        	this.x[addr] = data;
        end
    endfunction

    function data_t get_reg(addr_t addr);
        return this.x[addr];
    endfunction

endclass