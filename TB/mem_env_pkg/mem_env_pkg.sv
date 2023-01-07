`ifndef MEM_ENV_PKG_SV
`define MEM_ENV_PKG_SV
`include "uvm_macros.svh"
package mem_env_pkg;
    import uvm_pkg::*;

    import mem_agent_pkg::*;

    `include "mem_scoreboard.svh"
    `include "mem_env.svh"

endpackage
`endif
