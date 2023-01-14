class mem_driver extends uvm_driver #(mem_seq_item);

    `uvm_component_utils(mem_driver)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    protected virtual mem_if vif;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if ( !uvm_config_db#(virtual mem_if)::get(this, "", "vif", vif) ) begin
            `uvm_fatal("NO_VIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        vif.en = 1'b0;
        @(negedge vif.reset);
        @(negedge vif.clk);
        forever begin
          //this.seq_item_port.get(req);
            this.seq_item_port.get_next_item(req);
            vif.en    = 1'b1; //req.en;
            vif.we    = 1'b0;
            vif.wdata =   '0;
            vif.addr  = req.addr;
            if (req.acc == WRITE) begin
                vif.we    = 1'b1;
                vif.wdata = req.data;
            end
            @(negedge vif.clk);
            vif.en = 1'b0;
            if (req.acc == READ) begin
                @(negedge vif.clk);
                req.data = vif.rdata;
            end
            this.seq_item_port.item_done();
          //rsp = RSP::type_id::create("rsp");
          //rsp.set_id_info(req);
          //rsp.data = vif.rdata;
          //seq_item_port.put(rsp);
        end
    endtask

endclass
