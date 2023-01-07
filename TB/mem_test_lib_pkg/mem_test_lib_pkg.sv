`ifndef MEM_TEST_LIB_PKG_SV
`define MEM_TEST_LIB_PKG_SV
`include "uvm_macros.svh"
package mem_test_lib_pkg;
    import uvm_pkg::*;

    import mem_env_pkg::*;
    import mem_sequence_lib_pkg::*;

    class mem_test extends uvm_test;

        `uvm_component_utils(mem_test)

        mem_env       env;
        mem_sequence  seq;

        function new(string name, uvm_component parent);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            env = mem_env     ::type_id::create("env", this);
            seq = mem_sequence::type_id::create("seq");
        endfunction

        task run_phase(uvm_phase phase);
            phase.raise_objection(this);
            seq.start(env.mem_agnt.sequencer);
            phase.drop_objection(this);
        endtask

    endclass

endpackage
`endif
