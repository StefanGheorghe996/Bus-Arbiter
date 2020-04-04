// Module:  strict_priority_logic
// Author:  Gheorghe Stefan
// Date:    02.04.2020

module strict_priority_logic
(
    // Global signals
    input               clk,
    input               reset,
    input   [1:0]       client_1_priority,          // 0 means the highest priority while 3 means the lowest priority
    input               client_1_rq,     
    input   [1:0]       client_2_priority,
    input               client_2_rq,     
    input   [1:0]       client_3_priority,
    input               client_3_rq,     
    input   [1:0]       client_4_priority,
    input               client_4_rq,     
    input               server_ack,
    output  reg [1:0]       address_to_be_served

);


    // Internal signals and registers

    localparam [1:0] channel_1_address = 2'b00;    // Address of the 1 channel
    localparam [1:0] channel_2_address = 2'b01;    // Address of the 2 channel
    localparam [1:0] channel_3_address = 2'b10;    // Address of the 3 channel
    localparam [1:0] channel_4_address = 2'b11;    // Address of the 4 channel

    wire [1:0] first_priority_channel_addr ;
    wire [1:0] second_priority_channel_addr;
    wire [1:0] third_priority_channel_addr ;
    wire [1:0] fourth_priority_channel_addr;

    wire first_priority_request ;
    wire second_priority_request;
    wire third_priority_request ;
    wire fourth_priority_request;




    // Module instantiation

    priority_sort PRIORITY_SORT(
        .clk                            (clk                            ),
        .reset                          (reset                          ),
        .client_1_priority              (client_1_priority              ),
        .client_2_priority              (client_2_priority              ),
        .client_3_priority              (client_3_priority              ),
        .client_4_priority              (client_4_priority              ),
        .first_priority_channel_addr    (first_priority_channel_addr    ),
        .second_priority_channel_addr   (second_priority_channel_addr   ),
        .third_priority_channel_addr    (third_priority_channel_addr    ),
        .fourth_priority_channel_addr   (fourth_priority_channel_addr   )   
    );    
    
    always@(posedge clk or posedge reset)
    begin
        if(reset) address_to_be_served <= 'b0;

        else
        begin
            if      (first_priority_request)                                                                                    address_to_be_served <= first_priority_channel_addr;
            else if (~first_priority_request && second_priority_request)                                                        address_to_be_served <= second_priority_channel_addr;
            else if (~first_priority_request && ~second_priority_request && third_priority_request)                             address_to_be_served <= third_priority_channel_addr;
            else if (~first_priority_request && ~second_priority_request && ~third_priority_request && fourth_priority_request) address_to_be_served <= fourth_priority_channel_addr;
        end


    end 


    assign first_priority_request = (channel_1_address == first_priority_channel_addr)? client_1_rq : 
                                    (channel_2_address == first_priority_channel_addr)? client_2_rq : 
                                    (channel_3_address == first_priority_channel_addr)? client_3_rq : 
                                    (channel_4_address == first_priority_channel_addr)? client_4_rq : 'b0;

    assign second_priority_request =    (channel_1_address == second_priority_channel_addr)? client_1_rq : 
                                        (channel_2_address == second_priority_channel_addr)? client_2_rq : 
                                        (channel_3_address == second_priority_channel_addr)? client_3_rq : 
                                        (channel_4_address == second_priority_channel_addr)? client_4_rq : 'b0;

    assign third_priority_request = (channel_1_address == third_priority_channel_addr)? client_1_rq : 
                                    (channel_2_address == third_priority_channel_addr)? client_2_rq : 
                                    (channel_3_address == third_priority_channel_addr)? client_3_rq : 
                                    (channel_4_address == third_priority_channel_addr)? client_4_rq : 'b0;
    
    assign fourth_priority_request =    (channel_1_address == fourth_priority_channel_addr)? client_1_rq : 
                                        (channel_2_address == fourth_priority_channel_addr)? client_2_rq : 
                                        (channel_3_address == fourth_priority_channel_addr)? client_3_rq : 
                                        (channel_4_address == fourth_priority_channel_addr)? client_4_rq : 'b0;

   
 

    
endmodule