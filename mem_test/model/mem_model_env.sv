class mem_model_env extends uvm_env;
    mem_agent      mem_agnt;
    mem_scoreboard mem_scb;

    `uvm_component_utils(mem_model_env)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        $display("!!!!!!!!!!mem_model_env run_phase!!!!!!!!!!!!");
        super.build_phase(phase);

        mem_agnt = mem_agent::type_id::create("mem_agnt", this);
        mem_scb  = mem_scoreboard::type_id::create("mem_scb", this);
    endfunction
  
    function void connect_phase(uvm_phase phase);
        mem_agnt.monitor.item_collected_port.connect(mem_scb.item_collected_export);
    endfunction

endclass
