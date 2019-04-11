class dataMemory;

	protected data_t mem [(`DM_DEPTH/4)-1:0];//Memory

	function new ();
		this.load();
	endfunction


	function data_t get_mem (data_t addr);
		data_t actual_addr;
		actual_addr = addr>>2;
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