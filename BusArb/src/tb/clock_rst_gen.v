// Module:  clock_rst_gen
// Author:  Gheorghe Stefan
// Date:    06.03.2020

module clock_rst_gen#(
    parameter CLOCK_PERIOD = 5,
    parameter RST_DELAY = 30,
    parameter RST_DURATION = 2
)(
    output reg clk,
    output reg reset
);

    initial
    begin
        clk = 'b0;
    end

    always #(CLOCK_PERIOD)  clk  = ~clk;

    initial
    begin
        reset <= 'b0;
        repeat(RST_DELAY) @(posedge clk);
        reset <= 'b1;
        repeat(RST_DURATION) @(posedge clk);
        reset <= 'b0;
    end

endmodule // clock_rst_gen

