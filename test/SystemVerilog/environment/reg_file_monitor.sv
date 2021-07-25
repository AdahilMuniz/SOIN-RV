class reg_file_monitor;

    //Virtual Interface
    virtual reg_file_if vif;

    //Attributes
    reg_file_item_t reg_trans;

    function new (virtual reg_file_if vif);
        this.vif = vif;
    endfunction

    task run_in_if(); //Monitor the input interface
        @(this.vif.wen);
        if(~this.vif.rstn) begin
            $display("REG_FILE_MONITOR: Reset");
        end
        else begin
            this.mount();
        end
    endtask

    task run_out_if(); //Monitor the output interface
        @(this.vif.rn1, this.vif.rn2);
        if(~this.vif.rstn) begin
            $display("REG_FILE_MONITOR: Reset");
        end
        else begin
            this.mount();
        end
    endtask

    task run(); //Monitor the output interface
        //@(this.vif.rn1, this.vif.rn2, this.vif.wen);
        //@(this.vif.rn1, this.vif.rn2);
        @(this.vif.clk);
        if(~this.vif.rstn) begin
            $display("REG_FILE_MONITOR: Reset");
        end
        else begin
            this.mount();
        end
    endtask

    protected task mount();
        @(posedge this.vif.clk);
        /*
        if(this.vif.wen) begin
            this.reg_trans.data[2] = this.vif.wd;
            this.reg_trans.regn[2] = this.vif.wn;
        end
        */
        if (this.vif.wen) begin
            this.reg_trans.direction = WRITE;
        end
        else begin 
            this.reg_trans.direction = READ;
        end
        this.reg_trans.data[2] = this.vif.wd;
        this.reg_trans.regn[2] = this.vif.wn;

        this.reg_trans.data[0] = this.vif.rd1;
        this.reg_trans.regn[0] = this.vif.rn1;
        this.reg_trans.data[1] = this.vif.rd2;
        this.reg_trans.regn[1] = this.vif.rn2;

        $display("Reg File Transaction: \n Rn1:%d   Rd1:%8x | Rn2:%d   Rd2:%8x | Wn:%d   Wd:%8x  Wen:%d \n",
        this.reg_trans.regn[0],
        this.reg_trans.data[0],
        this.reg_trans.regn[1],
        this.reg_trans.data[1],
        this.reg_trans.regn[2],
        this.reg_trans.data[2],
        this.reg_trans.direction,
        );

    endtask


endclass