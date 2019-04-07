class regFile;
    protected static data_t x [REG_FILE_SIZE-1:0];

    function new ();
    	x[0] = 32'h0;
    endfunction

    function void set_reg(addr_t addr, data_t data);
        if(addr !== 0) begin 
        	x[addr] = data;
        end
    endfunction

    function data_t get_reg(addr_t addr);
        return x[addr];
    endfunction

endclass