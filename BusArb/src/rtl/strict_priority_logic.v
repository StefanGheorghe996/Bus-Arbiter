// Module:  strict_priority_logic
// Author:  Gheorghe Stefan
// Date:    02.04.2020

module strict_priority_logic
(
    // Global signals
    input   clk,
    input   reset,

    // Client 1 rq-ack protocol signals

    input       client_1_priority,          // 0 means the highest priority while 3 means the lowest priority
    input       client_1_rq,     
    output  reg client_1_ack, 

    // Client 2 rq-ack protocol signals

    input       client_2_priority,
    input       client_2_rq,     
    output  reg client_2_ack, 

    // Client 3 rq-ack protocol signals

    input       client_3_priority,
    input       client_3_rq,     
    output  reg client_3_ack, 

    // Client 4 rq-ack protocol signals

    input       client_4_priority,
    input       client_4_rq,     
    output  reg client_4_ack, 

    // Server rq-ack protocol signals

    output  reg server_rq,
    input       server_ack

);


// Internal signals and registers

reg [1:0] channel_1_address = 2'b00;    // Address of the 1 channel
reg [1:0] channel_2_address = 2'b01;    // Address of the 2 channel
reg [1:0] channel_3_address = 2'b10;    // Address of the 3 channel
reg [1:0] channel_4_address = 2'b11;    // Address of the 4 channel

wire [1:0] first_priority_channel_addr ;
wire [1:0] second_priority_channel_addr;
wire [1:0] third_priority_channel_addr ;
wire [1:0] fourth_priority_channel_addr;



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

// Modeling the behaviour for server request output
 
always @(posedge clk or posedge reset)
begin
    if (reset) server_rq <= 'b0;

    // Check for first priority
    else if ((channel_1_address == first_priority_channel_addr) && client_1_rq) server_rq <= client_1_rq;
    else if ((channel_2_address == first_priority_channel_addr) && client_2_rq) server_rq <= client_2_rq;
    else if ((channel_3_address == first_priority_channel_addr) && client_3_rq) server_rq <= client_3_rq;
    else if ((channel_4_address == first_priority_channel_addr) && client_4_rq) server_rq <= client_4_rq;

    // Check for second priority
    else if ((channel_1_address == second_priority_channel_addr) && client_1_rq) server_rq <= client_1_rq;
    else if ((channel_2_address == second_priority_channel_addr) && client_2_rq) server_rq <= client_2_rq;
    else if ((channel_3_address == second_priority_channel_addr) && client_3_rq) server_rq <= client_3_rq;
    else if ((channel_4_address == second_priority_channel_addr) && client_4_rq) server_rq <= client_4_rq;

    // Check for third priority
    else if ((channel_1_address == third_priority_channel_addr) && client_1_rq) server_rq <= client_1_rq;
    else if ((channel_2_address == third_priority_channel_addr) && client_2_rq) server_rq <= client_2_rq;
    else if ((channel_3_address == third_priority_channel_addr) && client_3_rq) server_rq <= client_3_rq;
    else if ((channel_4_address == third_priority_channel_addr) && client_4_rq) server_rq <= client_4_rq;

    // Check for fourth priority
    else if ((channel_1_address == fourth_priority_channel_addr) && client_1_rq) server_rq <= client_1_rq;
    else if ((channel_2_address == fourth_priority_channel_addr) && client_2_rq) server_rq <= client_2_rq;
    else if ((channel_3_address == fourth_priority_channel_addr) && client_3_rq) server_rq <= client_3_rq;
    else if ((channel_4_address == fourth_priority_channel_addr) && client_4_rq) server_rq <= client_4_rq;
end

// Modeling the behaviour for clients ack outputs
 
always @(posedge clk or posedge reset)
begin
    if (reset) 
    begin
    client_1_ack    = 'b0;
    client_2_ack    = 'b0;
    client_3_ack    = 'b0;
    client_4_ack    = 'b0;
        
    end

    // Check for first priority
    else if ((channel_1_address == first_priority_channel_addr) && client_1_rq) client_1_ack <= server_ack;
    else if ((channel_2_address == first_priority_channel_addr) && client_2_rq) client_2_ack <= server_ack;
    else if ((channel_3_address == first_priority_channel_addr) && client_3_rq) client_3_ack <= server_ack;
    else if ((channel_4_address == first_priority_channel_addr) && client_4_rq) client_4_ack <= server_ack;

    // Check for second priority
    else if ((channel_1_address == second_priority_channel_addr) && client_1_rq) client_1_ack <= server_ack;
    else if ((channel_2_address == second_priority_channel_addr) && client_2_rq) client_2_ack <= server_ack;
    else if ((channel_3_address == second_priority_channel_addr) && client_3_rq) client_3_ack <= server_ack;
    else if ((channel_4_address == second_priority_channel_addr) && client_4_rq) client_4_ack <= server_ack;


    // Check for third priority
    else if ((channel_1_address == third_priority_channel_addr) && client_1_rq) client_1_ack <= server_ack;
    else if ((channel_2_address == third_priority_channel_addr) && client_2_rq) client_2_ack <= server_ack;
    else if ((channel_3_address == third_priority_channel_addr) && client_3_rq) client_3_ack <= server_ack;
    else if ((channel_4_address == third_priority_channel_addr) && client_4_rq) client_4_ack <= server_ack;


    // Check for fourth priority
    else if ((channel_1_address == fourth_priority_channel_addr) && client_1_rq) client_1_ack <= server_ack;
    else if ((channel_2_address == fourth_priority_channel_addr) && client_2_rq) client_2_ack <= server_ack;
    else if ((channel_3_address == fourth_priority_channel_addr) && client_3_rq) client_3_ack <= server_ack;
    else if ((channel_4_address == fourth_priority_channel_addr) && client_4_rq) client_4_ack <= server_ack;

end
    
endmodule