// Module:  round_robin_logic
// Author:  Gheorghe Stefan
// Date:    02.04.2020

module round_robin_logic#(
    parameter NUMBER_OF_CLIENTS = 4;
)
(
    // Global signals
    input               clk,
    input               reset,
    input               client_1_rq,     
    input               client_2_rq,     
    input               client_3_rq,     
    input               client_4_rq,     
    input               server_ack,
    output  reg [1:0]   address_to_be_served,
    input               enable
);


    // Internal signals and registers

    localparam [1:0] channel_1_address = 2'b00;    // Address of the 1 channel
    localparam [1:0] channel_2_address = 2'b01;    // Address of the 2 channel
    localparam [1:0] channel_3_address = 2'b10;    // Address of the 3 channel
    localparam [1:0] channel_4_address = 2'b11;    // Address of the 4 channel

    reg [NUMBER_OF_CLIENTS-1:0] ring_counter; 

    // Module instantiation

    always @(posedge clk or posedge reset)
    begin
        if(reset) 
        begin
            ring_counter[NUMBER_OF_CLIENTS-1] <= 'b1;
            ring_counter[NUMBER_OF_CLIENTS-2:0] <= 'b0;
        end
       

    end


endmodule