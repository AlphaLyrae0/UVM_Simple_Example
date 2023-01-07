
`include "uvm_macros.svh"
module mem_testbench;

    import uvm_pkg::*;

    import mem_test_lib_pkg::*;

    bit     clk;
    always #5   clk = ~clk;

    bit     reset = 1;
    initial #20 reset =0;

    mem_if mif(.clk, .reset);

    memory DUT
        (
            .clk    (mif.clk),
            .reset  (mif.reset),
            .en     (mif.en),
            .we     (mif.we),
            .addr   (mif.addr),
            .wdata  (mif.wdata),
            .rdata  (mif.rdata)
        );

    initial begin 
        $dumpfile("dump.vcd"); $dumpvars;
        uvm_config_db#(virtual mem_if)::set(uvm_root::get(), "*", "vif", mif);
        run_test();
    end

endmodule
