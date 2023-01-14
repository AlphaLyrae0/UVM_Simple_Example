`ifndef MEM_SEQUENCE_LIB_PKG_SV
`define MEM_SEQUENCE_LIB_PKG_SV
`include "uvm_macros.svh"
package mem_sequence_lib_pkg;
    import uvm_pkg::*;

    import mem_agent_pkg::*;

    class mem_sequence extends uvm_sequence#(mem_seq_item);

        `uvm_object_utils(mem_sequence)

        function new(string name = "mem_sequence");
            super.new(name);
        endfunction

        int rep_times = 64;

        virtual task body();
            repeat ( rep_times) begin
              //`uvm_create(req)
              //req.randomize();
              //`uvm_send(req)
                `uvm_do(req)
              //this.start_item(req);
              //this.req.randomize();
              //this.finish_item(req)
              //get_response(rsp);
            end
        endtask

    endclass

endpackage
`endif
