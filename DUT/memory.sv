
module memory
        (
            input   wire            clk,
            input   wire            reset,

            input   wire            en,
            input   wire            we,
            input   wire    [3:0]   addr,
            input   wire    [7:0]   wdata,
            output  reg     [7:0]   rdata
        );

    logic   [7:0]   mem     [0:15];

  //initial for ( int i = 0; i < 16; ++i ) mem[i] = '1;

    always_ff @(posedge clk)
        if ( reset ) rdata <= '0;
        else if ( en ) begin
            if ( we )   mem[addr] <= wdata; // write
            else        rdata     <= mem[addr]; // read
        end

endmodule
