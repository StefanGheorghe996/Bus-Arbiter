// Module:  bus_arbiter
// Author:  Gheorghe Stefan
// Date:    02.04.2020

module bus_arbiter #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4,
    parameter CLIENT_1_PRIORITY = 0,
    parameter CLIENT_2_PRIORITY = 1,
    parameter CLIENT_3_PRIORITY = 2,
    parameter CLIENT_4_PRIORITY = 3,
    parameter PRIORITY_SCHEDULING_ALGORITHM = 1'b0 // Parameter used for selecting between priority scheduling algorithms: 0 for strict priority, 1 for round robin 
)(
    // Global signals
    input                           clk,    
    input                           reset, 

    // Server interface

    output reg  [ADDR_WIDTH-1 : 0]  srv_address,
    output                          srv_rq,     
    input                           srv_ack,    
    output reg                      srv_wr_ni,  
    output reg  [DATA_WIDTH-1 : 0]  srv_dataW,  
    input       [DATA_WIDTH-1 : 0]  srv_dataR,   
    
    // Client 1 interface
    
    input      [ADDR_WIDTH-1 : 0]   client_1_address,
    input                           client_1_rq,     
    output                          client_1_ack,    
    input                           client_1_wr_ni,  
    input      [DATA_WIDTH-1 : 0]   client_1_dataW,  
    output reg [DATA_WIDTH-1 : 0]   client_1_dataR,   
      
    
    // Client 2 interface

    input      [ADDR_WIDTH-1 : 0]   client_2_address,
    input                           client_2_rq,     
    output                          client_2_ack,    
    input                           client_2_wr_ni,  
    input      [DATA_WIDTH-1 : 0]   client_2_dataW,  
    output reg [DATA_WIDTH-1 : 0]   client_2_dataR,

    // Client 3 interface
    
    input      [ADDR_WIDTH-1 : 0]   client_3_address,
    input                           client_3_rq,     
    output                          client_3_ack,    
    input                           client_3_wr_ni,  
    input      [DATA_WIDTH-1 : 0]   client_3_dataW,  
    output reg [DATA_WIDTH-1 : 0]   client_3_dataR,
    
    // Client 4 interface
    
    input      [ADDR_WIDTH-1 : 0]   client_4_address,
    input                           client_4_rq,     
    output                          client_4_ack,    
    input                           client_4_wr_ni,  
    input      [DATA_WIDTH-1 : 0]   client_4_dataW,  
    output reg [DATA_WIDTH-1 : 0]   client_4_dataR
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

    always @(posedge reset)
    begin
        client_1_priority <= CLIENT_1_PRIORITY;
        client_2_priority <= CLIENT_2_PRIORITY;
        client_3_priority <= CLIENT_3_PRIORITY;
        client_4_priority <= CLIENT_4_PRIORITY;
    end

    
    always @(posedge clk or posedge reset)
    begin
        if (reset) srv_rq <= 'b0;

        // Check for first priority
        else if ((channel_1_address == first_priority_channel_addr) && client_1_rq) srv_rq <= client_1_rq;
        else if ((channel_2_address == first_priority_channel_addr) && client_2_rq) srv_rq <= client_2_rq;
        else if ((channel_3_address == first_priority_channel_addr) && client_3_rq) srv_rq <= client_3_rq;
        else if ((channel_4_address == first_priority_channel_addr) && client_4_rq) srv_rq <= client_4_rq;

        // Check for second priority
        else if ((channel_1_address == second_priority_channel_addr) && client_1_rq) srv_rq <= client_1_rq;
        else if ((channel_2_address == second_priority_channel_addr) && client_2_rq) srv_rq <= client_2_rq;
        else if ((channel_3_address == second_priority_channel_addr) && client_3_rq) srv_rq <= client_3_rq;
        else if ((channel_4_address == second_priority_channel_addr) && client_4_rq) srv_rq <= client_4_rq;

        // Check for third priority
        else if ((channel_1_address == third_priority_channel_addr) && client_1_rq) srv_rq <= client_1_rq;
        else if ((channel_2_address == third_priority_channel_addr) && client_2_rq) srv_rq <= client_2_rq;
        else if ((channel_3_address == third_priority_channel_addr) && client_3_rq) srv_rq <= client_3_rq;
        else if ((channel_4_address == third_priority_channel_addr) && client_4_rq) srv_rq <= client_4_rq;

        // Check for fourth priority
        else if ((channel_1_address == fourth_priority_channel_addr) && client_1_rq) srv_rq <= client_1_rq;
        else if ((channel_2_address == fourth_priority_channel_addr) && client_2_rq) srv_rq <= client_2_rq;
        else if ((channel_3_address == fourth_priority_channel_addr) && client_3_rq) srv_rq <= client_3_rq;
        else if ((channel_4_address == fourth_priority_channel_addr) && client_4_rq) srv_rq <= client_4_rq;
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
        else if ((channel_1_address == first_priority_channel_addr) && client_1_rq) client_1_ack <= srv_ack;
        else if ((channel_2_address == first_priority_channel_addr) && client_2_rq) client_2_ack <= srv_ack;
        else if ((channel_3_address == first_priority_channel_addr) && client_3_rq) client_3_ack <= srv_ack;
        else if ((channel_4_address == first_priority_channel_addr) && client_4_rq) client_4_ack <= srv_ack;

        // Check for second priority
        else if ((channel_1_address == second_priority_channel_addr) && client_1_rq) client_1_ack <= srv_ack;
        else if ((channel_2_address == second_priority_channel_addr) && client_2_rq) client_2_ack <= srv_ack;
        else if ((channel_3_address == second_priority_channel_addr) && client_3_rq) client_3_ack <= srv_ack;
        else if ((channel_4_address == second_priority_channel_addr) && client_4_rq) client_4_ack <= srv_ack;


        // Check for third priority
        else if ((channel_1_address == third_priority_channel_addr) && client_1_rq) client_1_ack <= srv_ack;
        else if ((channel_2_address == third_priority_channel_addr) && client_2_rq) client_2_ack <= srv_ack;
        else if ((channel_3_address == third_priority_channel_addr) && client_3_rq) client_3_ack <= srv_ack;
        else if ((channel_4_address == third_priority_channel_addr) && client_4_rq) client_4_ack <= srv_ack;


        // Check for fourth priority
        else if ((channel_1_address == fourth_priority_channel_addr) && client_1_rq) client_1_ack <= srv_ack;
        else if ((channel_2_address == fourth_priority_channel_addr) && client_2_rq) client_2_ack <= srv_ack;
        else if ((channel_3_address == fourth_priority_channel_addr) && client_3_rq) client_3_ack <= srv_ack;
        else if ((channel_4_address == fourth_priority_channel_addr) && client_4_rq) client_4_ack <= srv_ack;

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
        else if ((channel_1_address == first_priority_channel_addr) && client_1_rq) client_1_ack <= srv_ack;
        else if ((channel_2_address == first_priority_channel_addr) && client_2_rq) client_2_ack <= srv_ack;
        else if ((channel_3_address == first_priority_channel_addr) && client_3_rq) client_3_ack <= srv_ack;
        else if ((channel_4_address == first_priority_channel_addr) && client_4_rq) client_4_ack <= srv_ack;

        // Check for second priority
        else if ((channel_1_address == second_priority_channel_addr) && client_1_rq) client_1_ack <= srv_ack;
        else if ((channel_2_address == second_priority_channel_addr) && client_2_rq) client_2_ack <= srv_ack;
        else if ((channel_3_address == second_priority_channel_addr) && client_3_rq) client_3_ack <= srv_ack;
        else if ((channel_4_address == second_priority_channel_addr) && client_4_rq) client_4_ack <= srv_ack;


        // Check for third priority
        else if ((channel_1_address == third_priority_channel_addr) && client_1_rq) client_1_ack <= srv_ack;
        else if ((channel_2_address == third_priority_channel_addr) && client_2_rq) client_2_ack <= srv_ack;
        else if ((channel_3_address == third_priority_channel_addr) && client_3_rq) client_3_ack <= srv_ack;
        else if ((channel_4_address == third_priority_channel_addr) && client_4_rq) client_4_ack <= srv_ack;


        // Check for fourth priority
        else if ((channel_1_address == fourth_priority_channel_addr) && client_1_rq) client_1_ack <= srv_ack;
        else if ((channel_2_address == fourth_priority_channel_addr) && client_2_rq) client_2_ack <= srv_ack;
        else if ((channel_3_address == fourth_priority_channel_addr) && client_3_rq) client_3_ack <= srv_ack;
        else if ((channel_4_address == fourth_priority_channel_addr) && client_4_rq) client_4_ack <= srv_ack;

    end

    // Modeling the behaviour for wr_ni signal

    always @(posedge clk or posedge reset)
    begin
        if (reset) srv_wr_ni <= 'b0;

        // Check for first priority
        else if ((channel_1_address == first_priority_channel_addr) && client_1_rq)     srv_wr_ni   <= client_1_wr_ni;
        else if ((channel_2_address == first_priority_channel_addr) && client_2_rq)     srv_wr_ni   <= client_2_wr_ni;
        else if ((channel_3_address == first_priority_channel_addr) && client_3_rq)     srv_wr_ni   <= client_3_wr_ni;
        else if ((channel_4_address == first_priority_channel_addr) && client_4_rq)     srv_wr_ni   <= client_4_wr_ni;

        // Check for second priority
        else if ((channel_1_address == second_priority_channel_addr) && client_1_rq)    srv_wr_ni   <= client_1_wr_ni;
        else if ((channel_2_address == second_priority_channel_addr) && client_2_rq)    srv_wr_ni   <= client_2_wr_ni;
        else if ((channel_3_address == second_priority_channel_addr) && client_3_rq)    srv_wr_ni   <= client_3_wr_ni;
        else if ((channel_4_address == second_priority_channel_addr) && client_4_rq)    srv_wr_ni   <= client_4_wr_ni;

        // Check for third priority
        else if ((channel_1_address == third_priority_channel_addr) && client_1_rq)     srv_wr_ni   <= client_1_wr_ni;
        else if ((channel_2_address == third_priority_channel_addr) && client_2_rq)     srv_wr_ni   <= client_2_wr_ni;
        else if ((channel_3_address == third_priority_channel_addr) && client_3_rq)     srv_wr_ni   <= client_3_wr_ni;
        else if ((channel_4_address == third_priority_channel_addr) && client_4_rq)     srv_wr_ni   <= client_4_wr_ni;

        // Check for fourth priority
        else if ((channel_1_address == fourth_priority_channel_addr) && client_1_rq)    srv_wr_ni   <= client_1_wr_ni;
        else if ((channel_2_address == fourth_priority_channel_addr) && client_2_rq)    srv_wr_ni   <= client_2_wr_ni;
        else if ((channel_3_address == fourth_priority_channel_addr) && client_3_rq)    srv_wr_ni   <= client_3_wr_ni;
        else if ((channel_4_address == fourth_priority_channel_addr) && client_4_rq)    srv_wr_ni   <= client_4_wr_ni;
    end


    // Modeling the behaviour for address line

    always @(posedge clk or posedge reset)
    begin
        if (reset) srv_address <= 'b0;

        // Check for first priority
        else if ((channel_1_address == first_priority_channel_addr) && client_1_rq)     srv_address   <= client_1_address;
        else if ((channel_2_address == first_priority_channel_addr) && client_2_rq)     srv_address   <= client_2_address;
        else if ((channel_3_address == first_priority_channel_addr) && client_3_rq)     srv_address   <= client_3_address;
        else if ((channel_4_address == first_priority_channel_addr) && client_4_rq)     srv_address   <= client_4_address;

        // Check for second priority
        else if ((channel_1_address == second_priority_channel_addr) && client_1_rq)    srv_address   <= client_1_address;
        else if ((channel_2_address == second_priority_channel_addr) && client_2_rq)    srv_address   <= client_2_address;
        else if ((channel_3_address == second_priority_channel_addr) && client_3_rq)    srv_address   <= client_3_address;
        else if ((channel_4_address == second_priority_channel_addr) && client_4_rq)    srv_address   <= client_4_address;

        // Check for third priority
        else if ((channel_1_address == third_priority_channel_addr) && client_1_rq)     srv_address   <= client_1_address;
        else if ((channel_2_address == third_priority_channel_addr) && client_2_rq)     srv_address   <= client_2_address;
        else if ((channel_3_address == third_priority_channel_addr) && client_3_rq)     srv_address   <= client_3_address;
        else if ((channel_4_address == third_priority_channel_addr) && client_4_rq)     srv_address   <= client_4_address;

        // Check for fourth priority
        else if ((channel_1_address == fourth_priority_channel_addr) && client_1_rq)    srv_address   <= client_1_address;
        else if ((channel_2_address == fourth_priority_channel_addr) && client_2_rq)    srv_address   <= client_2_address;
        else if ((channel_3_address == fourth_priority_channel_addr) && client_3_rq)    srv_address   <= client_3_address;
        else if ((channel_4_address == fourth_priority_channel_addr) && client_4_rq)    srv_address   <= client_4_address;
    end

    // Modeling the behaviour for the dataW line

    always @(posedge clk or posedge reset)
    begin
        if (reset) srv_dataW <= 'b0;

        // Check for first priority
        else if ((channel_1_address == first_priority_channel_addr) && client_1_rq)     srv_dataW   <= client_1_dataW;
        else if ((channel_2_address == first_priority_channel_addr) && client_2_rq)     srv_dataW   <= client_2_dataW;
        else if ((channel_3_address == first_priority_channel_addr) && client_3_rq)     srv_dataW   <= client_3_dataW;
        else if ((channel_4_address == first_priority_channel_addr) && client_4_rq)     srv_dataW   <= client_4_dataW;

        // Check for second priority
        else if ((channel_1_address == second_priority_channel_addr) && client_1_rq)    srv_dataW   <= client_1_dataW;
        else if ((channel_2_address == second_priority_channel_addr) && client_2_rq)    srv_dataW   <= client_2_dataW;
        else if ((channel_3_address == second_priority_channel_addr) && client_3_rq)    srv_dataW   <= client_3_dataW;
        else if ((channel_4_address == second_priority_channel_addr) && client_4_rq)    srv_dataW   <= client_4_dataW;

        // Check for third priority
        else if ((channel_1_address == third_priority_channel_addr) && client_1_rq)     srv_dataW   <= client_1_dataW;
        else if ((channel_2_address == third_priority_channel_addr) && client_2_rq)     srv_dataW   <= client_2_dataW;
        else if ((channel_3_address == third_priority_channel_addr) && client_3_rq)     srv_dataW   <= client_3_dataW;
        else if ((channel_4_address == third_priority_channel_addr) && client_4_rq)     srv_dataW   <= client_4_dataW;

        // Check for fourth priority
        else if ((channel_1_address == fourth_priority_channel_addr) && client_1_rq)    srv_dataW   <= client_1_dataW;
        else if ((channel_2_address == fourth_priority_channel_addr) && client_2_rq)    srv_dataW   <= client_2_dataW;
        else if ((channel_3_address == fourth_priority_channel_addr) && client_3_rq)    srv_dataW   <= client_3_dataW;
        else if ((channel_4_address == fourth_priority_channel_addr) && client_4_rq)    srv_dataW   <= client_4_dataW;
    end

    // Modeling the behaviour for dataR line
    always @(posedge clk or posedge reset)
    begin
        if (reset) 
        begin
        client_1_dataR    = 'b0;
        client_2_dataR    = 'b0;
        client_3_dataR    = 'b0;
        client_4_dataR    = 'b0;

        end

        // Check for first priority
        else if ((channel_1_address == first_priority_channel_addr) && client_1_rq)     client_1_dataR <= srv_dataR;
        else if ((channel_2_address == first_priority_channel_addr) && client_2_rq)     client_2_dataR <= srv_dataR;
        else if ((channel_3_address == first_priority_channel_addr) && client_3_rq)     client_3_dataR <= srv_dataR;
        else if ((channel_4_address == first_priority_channel_addr) && client_4_rq)     client_4_dataR <= srv_dataR;

        // Check for second priority
        else if ((channel_1_address == second_priority_channel_addr) && client_1_rq)    client_1_dataR <= srv_dataR;
        else if ((channel_2_address == second_priority_channel_addr) && client_2_rq)    client_2_dataR <= srv_dataR;
        else if ((channel_3_address == second_priority_channel_addr) && client_3_rq)    client_3_dataR <= srv_dataR;
        else if ((channel_4_address == second_priority_channel_addr) && client_4_rq)    client_4_dataR <= srv_dataR;


        // Check for third priority
        else if ((channel_1_address == third_priority_channel_addr) && client_1_rq)     client_1_dataR <= srv_dataR;
        else if ((channel_2_address == third_priority_channel_addr) && client_2_rq)     client_2_dataR <= srv_dataR;
        else if ((channel_3_address == third_priority_channel_addr) && client_3_rq)     client_3_dataR <= srv_dataR;
        else if ((channel_4_address == third_priority_channel_addr) && client_4_rq)     client_4_dataR <= srv_dataR;


        // Check for fourth priority
        else if ((channel_1_address == fourth_priority_channel_addr) && client_1_rq)    client_1_dataR <= srv_dataR;
        else if ((channel_2_address == fourth_priority_channel_addr) && client_2_rq)    client_2_dataR <= srv_dataR;
        else if ((channel_3_address == fourth_priority_channel_addr) && client_3_rq)    client_3_dataR <= srv_dataR;
        else if ((channel_4_address == fourth_priority_channel_addr) && client_4_rq)    client_4_dataR <= srv_dataR;

    end
    

    
    
endmodule