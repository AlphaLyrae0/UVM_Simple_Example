class mem_agent extends uvm_agent;

    `uvm_component_utils(mem_agent)

    function new (string name, uvm_component parent);
        super.new(name, parent);
        this.analysis_port = new("analysis_port", this);
    endfunction : new

    uvm_analysis_port #(mem_seq_item) analysis_port;

    mem_driver    driver;
    mem_sequencer sequencer;
    mem_monitor   monitor;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if ( get_is_active() == UVM_ACTIVE ) begin
            sequencer = mem_sequencer::type_id::create("sequencer", this);
            driver    = mem_driver   ::type_id::create("driver"   , this);
        end

        monitor = mem_monitor::type_id::create("monitor", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        if( get_is_active() == UVM_ACTIVE ) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
        monitor.item_collected_port.connect(analysis_port);
    endfunction

endclass
