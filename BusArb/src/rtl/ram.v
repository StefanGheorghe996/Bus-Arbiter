// Module:  ram
// Author:  Gheorghe Stefan
// Date:    30.03.2020

module ram #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4,
    parameter MEMORY_DEPTH = 16,
    parameter NO_DELAY   = 1'b1, // 0 for delayed acknowlege
    parameter DELAY_ACK = 2   // Number of clock cycles before ack, can take values between 0 and 15  
)(
    input                           clk,     // Clock signal
    input                           reset,   // Reset signal, used for delay_counter register
    input      [ADDR_WIDTH-1 : 0]   address, // Address line
    input                           rq,      // Request signal
    output                          ack,     // Acknowledge output
    input                           wr_ni,   // Selection between read and write operations, 1 = read
    input      [DATA_WIDTH-1 : 0]   dataW,   // Data to be written
    output reg [DATA_WIDTH-1 : 0]   dataR    // Date sent to client
    
);

    reg [DATA_WIDTH-1:0] mem [MEMORY_DEPTH-1 : 0];
    reg rq_d;
    reg [3:0] delay_counter;


    always @(posedge clk)
        if(rq && wr_ni)  dataR <= mem[address];

    always @(posedge clk)
        if (rq && ~wr_ni)  mem[address] <= dataW;

    always @(posedge clk)
    begin
        rq_d <= rq;
    end

    always @(posedge clk or posedge reset)
    begin
        if(reset) delay_counter <= 'b0;
        else if(DELAY_ACK == 0) delay_counter <= 'b0;
        else if (rq) delay_counter <= delay_counter + 'b1;
        //else if (delay_counter == DELAY_ACK) delay_counter <= 'b0;
        else if (~rq) delay_counter <= 'b0;
    end

    
    assign ack = rq && rq_d && (delay_counter == DELAY_ACK && ~NO_DELAY);

endmodule
