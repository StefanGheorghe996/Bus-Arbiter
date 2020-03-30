// Module:  ram
// Author:  Gheorghe Stefan
// Date:    30.03.2020

module ram #(
    parameter ADDR_WIDTH = 4;
    parameter DATA_WIDTH = 8;    
)(
    input                           clk,     // Clock signal
    input      [ADDR_WIDTH-1 : 0]   address, // Address line
    input                           rq,      // Request signal
    output reg                      ack,     // Acknowledge output
    input                           wr_ni,   // Selection between read and write operations, 1 = rea
    input      [DATA_WIDTH-1 : 0]   dataW,   // Data to be written
    output reg [DATA_WIDTH-1 : 0]   dataR    // Date sent to client
    
);



reg [DATA_WIDTH-1:0] mem [ADDR_WIDTH-1 : 0];

always @(posedge clk)
begin
    if(rq && wr_no) dataR <= mem[addr];
    else if (rq && ~wr_no) mem[addr] <= dataW;
end

always @(posedge clk)
begin
    ack <= rq;
end

endmodule
