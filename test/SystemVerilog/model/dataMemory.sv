class dataMemory;

	protected static data_t mem [(`DM_DEPTH/4)-1:0];//Memory

	function new ();
		this.load();
	endfunction

	function void reset();
        foreach(mem[i]) begin
            mem[i] = 0;
        end
    endfunction


	function data_t get_mem (data_t addr);
		data_t actual_addr;
		actual_addr = addr>>2;
		if(actual_addr > (`DM_DEPTH/4)-1) begin
			return 32'h0;
		end
		return this.mem[actual_addr];
	endfunction

	function void set_mem (data_t addr, data_t data);
		data_t actual_addr;
		actual_addr = addr>>2;
		this.mem[actual_addr] = data;
	endfunction

	function void load ();
		$readmemh(`DM_FILE, this.mem);
	endfunction

endclass