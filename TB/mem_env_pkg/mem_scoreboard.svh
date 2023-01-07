class mem_scoreboard extends uvm_scoreboard;

    uvm_analysis_imp#(mem_seq_item, mem_scoreboard) item_collected_export;

    `uvm_component_utils(mem_scoreboard)

    logic   [7:0]   mem [0:15];

    function new (string name, uvm_component parent);
        super.new(name, parent);
        for ( int i = 0; i < 16; ++i ) mem[i] = '1;
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item_collected_export = new("item_collected_export", this);
    endfunction

    virtual function void write(mem_seq_item pkt);
        if ( !pkt.we ) begin
            assert ( pkt.rdata == mem[pkt.addr] )
                `uvm_info (get_type_name(), $sformatf("read  addr : %0h rdata : %0h", pkt.addr, pkt.rdata), UVM_MEDIUM)
            else
                `uvm_error(get_type_name(), $sformatf("read  data mismatch. addr : %0h rdata : %0h Expected : %0h", pkt.addr, pkt.rdata, mem[pkt.addr]))
        end
        else begin
            `uvm_info(get_type_name(), $sformatf("write addr : %0h wdata : %0h", pkt.addr, pkt.wdata), UVM_MEDIUM)
            mem[pkt.addr] = pkt.wdata;
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask

endclass
