// Module:  ram
// Author:  Gheorghe Stefan
// Date:    30.03.2020

module ram #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4    
)(
    input                           clk,     // Clock signal
    input      [ADDR_WIDTH-1 : 0]   address, // Address line
    input                           rq,      // Request signal
    output                          ack,     // Acknowledge output
    input                           wr_ni,   // Selection between read and write operations, 1 = read
    input      [DATA_WIDTH-1 : 0]   dataW,   // Data to be written
    output reg [DATA_WIDTH-1 : 0]   dataR    // Date sent to client
    
);

    reg [DATA_WIDTH-1:0] mem [ADDR_WIDTH-1 : 0];
    reg rq_d;


    always @(posedge clk)
    begin
        if(rq && wr_ni) dataR <= mem[address];
        else if (rq && ~wr_ni) mem[address] <= dataW;
    end

    always @(posedge clk)
    begin
        rq_d <= rq;
    end

    assign  ack = rq && rq_d;

endmodule
