class instMemory;

	protected data_t mem [(`IM_DEPTH/4)-1:0];//Memory

	function new ();
		this.load();
	endfunction


	function data_t get_mem (data_t addr);
		data_t actual_addr;
		actual_addr = (addr/4)*4;
		return this.mem[addr];
	endfunction

	function void load ();
		$readmemh(`IM_FILE, this.mem);
	endfunction

endclass