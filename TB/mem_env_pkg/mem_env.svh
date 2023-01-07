class mem_env extends uvm_env;

    `uvm_component_utils(mem_env)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    mem_agent      mem_agnt;
    mem_scoreboard mem_scb ;
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mem_agnt = mem_agent     ::type_id::create("mem_agnt", this);
        mem_scb  = mem_scoreboard::type_id::create("mem_scb" , this);
    endfunction

    uvm_sequencer_base sqr;
    virtual function void connect_phase(uvm_phase phase);
        mem_agnt.analysis_port.connect(mem_scb.item_collected_export);
        sqr = mem_agnt.sequencer;
    endfunction

endclass
