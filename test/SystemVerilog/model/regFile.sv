class regFile;
    protected static data_t x [31:0];

    function new ();
    	integer i;
        for (i = 0; i < 32; i++) begin
            this.x[i] = i;
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