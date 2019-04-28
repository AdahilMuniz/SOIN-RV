class reg_file_monitor;

    //Virtual Interface
    virtual reg_file_if vif;

    //Attributes
    reg_file_item_t reg_trans;

    function new (virtual reg_file_if vif);
        this.vif = vif;
    endfunction

    task run();
        //if(this.vif.rstn) begin
        //    $display("REG_FILE_MONITOR: Waiting reset");
        //    @(this.vif.rstn);
        //end
        this.mount();
    endtask 


    protected task mount();
        @(this.vif.clk);
        if(this.vif.wen) begin
            this.reg_trans.data[2] = this.vif.wd;
            this.reg_trans.regn[2] = this.vif.wn;
        end

        this.reg_trans.data[0] = this.vif.rd1;
        this.reg_trans.regn[0] = this.vif.rn1;
        this.reg_trans.data[1] = this.vif.rd2;
        this.reg_trans.regn[1] = this.vif.rn2;

        $display("Reg File Transaction: \n Rn1:%d   Rd1:%d | Rn2:%d   Rd2:%d | Wn:%d   Wd:%d \n",
        this.reg_trans.regn[0],
        this.reg_trans.data[0],
        this.reg_trans.regn[1],
        this.reg_trans.data[1],
        this.reg_trans.regn[2],
        this.reg_trans.data[2],
        );

    endtask


endclass