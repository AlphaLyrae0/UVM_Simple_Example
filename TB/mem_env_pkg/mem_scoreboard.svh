class mem_scoreboard extends uvm_scoreboard;

    uvm_analysis_imp#(mem_seq_item, mem_scoreboard) item_collected_export;

    `uvm_component_utils(mem_scoreboard)

    function new (string name, uvm_component parent);
        super.new(name, parent);
      //for ( int i = 0; i < 16; ++i ) mem[i] = '1;
    endfunction

    logic   [7:0]   mem [0:15];
    int rd_cnt, wr_cnt, err_cnt;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item_collected_export = new("item_collected_export", this);
    endfunction

    virtual function void write(mem_seq_item pkt);
        `uvm_info (get_type_name(), $sformatf("Received Transaction : \n%s", pkt.sprint()), UVM_MEDIUM)
        case (pkt.acc)
            READ  : begin
                rd_cnt++;
                if ( pkt.data === mem[pkt.addr] )
                    `uvm_info (get_type_name(), $sformatf("read  addr : %0h rdata : %0h", pkt.addr, pkt.data), UVM_MEDIUM)
                else begin
                    err_cnt++;
                    `uvm_error(get_type_name(), $sformatf("read  data mismatch. addr : %0h rdata : %0h Expected : %0h", pkt.addr, pkt.data, mem[pkt.addr]))
                end
            end
            WRITE : begin
                wr_cnt++;
                `uvm_info(get_type_name(), $sformatf("write addr : %0h wdata : %0h", pkt.addr, pkt.data), UVM_MEDIUM)
                mem[pkt.addr] = pkt.data;
            end
        endcase
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask

    virtual function void report_phase(uvm_phase phase);
        string msg = "\n  ======================================";
        msg = {msg,  "\n    Total Memeory Access Result"};
        msg = {msg,  "\n  ======================================"};
        msg = {msg, $sformatf("\n    Write Access : %d",wr_cnt)};
        msg = {msg, $sformatf("\n    Read  Access : %d (Mismatch %0d)",rd_cnt, err_cnt)};
        msg = {msg,  "\n  --------------------------------------"};
        msg = {msg, $sformatf("\n    Total        : %d",wr_cnt+rd_cnt)};
        msg = {msg,  "\n  ======================================"};
        `uvm_info(get_type_name(), msg, UVM_MEDIUM)
        if (rd_cnt == 0)
            `uvm_error(get_type_name(), "No Memory Read Access Took Place. Check The Test")
    endfunction

endclass
