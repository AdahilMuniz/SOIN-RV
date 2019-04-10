class instMemory;

	protected data_t mem [(`IM_DEPTH/4)-1:0];//Memory
	protected string IM_FILE;

	function new (string IM_FILE = `IM_FILE);
		this.IM_FILE = IM_FILE;
		this.load();
	endfunction


	function data_t get_mem (data_t addr);
		data_t actual_addr;
		actual_addr = (addr/4);
		return this.mem[actual_addr];
	endfunction

	function void load ();
		$readmemh(this.IM_FILE, this.mem);
	endfunction

endclass