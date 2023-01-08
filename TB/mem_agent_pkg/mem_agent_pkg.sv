`ifndef MEM_AGENT_PKG_SV
`define MEM_AGENT_PKG_SV
`include "uvm_macros.svh"
package mem_agent_pkg;
    import uvm_pkg::*;

    typedef enum bit {READ, WRITE} kind_e;

    `include "mem_seq_item.svh"
    `include "mem_sequencer.svh"
    `include "mem_driver.svh"
    `include "mem_monitor.svh"
    `include "mem_agent.svh"

endpackage
`endif
