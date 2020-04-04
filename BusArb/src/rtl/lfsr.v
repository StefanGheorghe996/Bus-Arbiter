// Module:  lfsr
// Author:  Gheorghe Stefan
// Date:    31.03.2020

module lfsr#(
    parameter SEED = 5'b00011 // At least one bit must be equal to 1
)(
    input clk,
    input rst,
    input enable,
    output rq
);

    // The implemented LFSR consists of 5 registers
    // It is used to generate an radom request pulse

    // Internal registers

    reg [4:0] d;

    always @(posedge clk or posedge rst) begin
        if(rst) 
        begin
            d[0] <= SEED[0];
            d[1] <= SEED[1];
            d[2] <= SEED[2];
            d[3] <= SEED[3];
            d[4] <= SEED[4];
        end
        else if (enable) begin
            d <= { d[3:0], d[4] ^~ d[3] };     
        end
    end

assign rq = enable && ((d[2] | d[1]));

endmodule // lfsr