//@TODO:
//      Think about concurrent reading and writing
class data_monitor;

    //Virtual Interface
    virtual memory_if.monitor vif;

    //Attributes
    data_item_t data_trans;

    function new (virtual memory_if.monitor vif);
        this.vif = vif;
    endfunction

    task run();
        if(this.vif.rstn) begin
            $display("DATA_MONITOR: Waiting reset");
            @(this.vif.rstn);
        end
        this.mount();
    endtask 


    protected task mount();
        @(this.vif.addr);
        this.data_trans.addr = this.vif.addr;
        if(this.vif.ren) begin
            this.data_trans.data      = this.vif.rdata;
            this.data_trans.direction = READ;

            $display("Data Transaction: \n Direction: %s \n Data: %8x Addr: %8x \n",
            this.data_trans.direction,
            this.data_trans.data,
            this.data_trans.addr);
        end
        else if (this.vif.wen) begin
            this.data_trans.data      = this.vif.wdata;
            this.data_trans.direction = WRITE;

            $display("Data Transaction: \n Direction: %s \n Data: %8x Addr: %8x \n",
            this.data_trans.direction,
            this.data_trans.data,
            this.data_trans.addr);
        end

    endtask


endclass