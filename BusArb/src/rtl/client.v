// Module:  client
// Author:  Gheorghe Stefan
// Date:    26.03.2020

module client#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4,
    parameter ADDR_SPACE_BEGINNING = 0,
    parameter ADDR_SPACE_END = 3,
    parameter REQUEST_DELAY = 10
)(
    input                       clk,     // Clock signal
    input                       reset,   // Reset signal, active 1
    output  [ADDR_WIDTH-1 : 0]  address, // Address line
    output reg                  rq,      // Request signal
    input                       ack,     // Acknowledge input
    output                      wr_ni,   // Selection between read and write operations, 1 = read, 0 = write
    output  [DATA_WIDTH-1 : 0]  dataW,   // Data to be written
    input   [DATA_WIDTH-1 : 0]  dataR    // Read data from the server
);

// Internal signals and registers
reg [DATA_WIDTH-1 : 0] counter_1; // Counter for data generation
reg [ADDR_WIDTH-1 : 0] counter_2; // Counter for address generation
reg [DATA_WIDTH-1 : 0] counter_3; // Counter for request generation

reg rq_delayed; // Register used for the request negedge detection

// Modeling counter_1 behaviour
always @(posedge clk or posedge reset)
begin
    if(reset) counter_1 <= 'b0;
    else if (rq && rq_delayed == 0) counter_1 <= counter_1 + 1;
end 

// Modeling counter_2 behaviour
always @(posedge clk or posedge reset)
begin
    if(reset) counter_2 <= ADDR_SPACE_BEGINNING;
    else if (~rq && rq_delayed == 1) 
        begin
            if (counter_2 <= ADDR_SPACE_END) counter_2 <= counter_2 + 1;
            else counter_2 <= ADDR_SPACE_BEGINNING;
        end
end 

// Modeling counter_3 behaviour
always @(posedge clk or posedge reset)
begin
    if(reset) counter_3 <= 'b0;
    else if (~rq) 
    begin
        if (counter_3 <= REQUEST_DELAY-1)  counter_3 <= counter_3 + 1;     
        else                               counter_3 <= 'b0; 
    end
end 

// Modeling rq_delayed behaviour
always @(posedge clk or posedge reset) 
begin
    if(reset) rq_delayed <= 'b0;
    else rq_delayed <= rq;
end 

// Modeling rq behaviour
always @(posedge clk or posedge reset) 
begin
    if(reset) rq <= 'b0;
    else if (counter_3 == REQUEST_DELAY) rq <= 'b1;
    else if (ack == 1)                   rq <= 'b0;
end 

// Assigning outputs
assign wr_ni    = counter_2[0];
assign dataW    = counter_1;
assign address  = counter_2;


endmodule // client