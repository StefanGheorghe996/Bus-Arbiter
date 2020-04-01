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

    reg bit_1;
    reg bit_2;
    reg bit_3;
    reg bit_4;
    reg bit_5;

    always @(posedge clk or posedge rst)
    begin
        if (rst) begin
            bit_1 <= SEED[0];
            bit_2 <= SEED[1];
            bit_3 <= SEED[2];
            bit_4 <= SEED[3];
            bit_5 <= SEED[4];
        end

        else if (enable) begin
            bit_1 <= bit_3 ~^ bit_5;  
            bit_2 <= bit_1; 
            bit_3 <= bit_2; 
            bit_4 <= bit_3; 
            bit_5 <= bit_4; 
        end
    end

assign rq = enable && bit_2 && bit_3;

endmodule // lfsr