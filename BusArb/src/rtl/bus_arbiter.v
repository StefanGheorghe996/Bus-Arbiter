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

    output      [ADDR_WIDTH-1 : 0]  server_address,
    output                          server_rq,     
    input                           server_ack,    
    output                          server_wr_ni,  
    output      [DATA_WIDTH-1 : 0]  server_dataW,  
    input       [DATA_WIDTH-1 : 0]  server_dataR,   
    
    // Client 1 interface
    
    input      [ADDR_WIDTH-1 : 0]   client_1_address,
    input                           client_1_rq,     
    output                          client_1_ack,    
    input                           client_1_wr_ni,  
    input      [DATA_WIDTH-1 : 0]   client_1_dataW,  
    output     [DATA_WIDTH-1 : 0]   client_1_dataR,   
      
    
    // Client 2 interface

    input      [ADDR_WIDTH-1 : 0]   client_2_address,
    input                           client_2_rq,     
    output                          client_2_ack,    
    input                           client_2_wr_ni,  
    input      [DATA_WIDTH-1 : 0]   client_2_dataW,  
    output     [DATA_WIDTH-1 : 0]   client_2_dataR,

    // Client 3 interface
    
    input      [ADDR_WIDTH-1 : 0]   client_3_address,
    input                           client_3_rq,     
    output                          client_3_ack,    
    input                           client_3_wr_ni,  
    input      [DATA_WIDTH-1 : 0]   client_3_dataW,  
    output     [DATA_WIDTH-1 : 0]   client_3_dataR,
    
    // Client 4 interface
    
    input      [ADDR_WIDTH-1 : 0]   client_4_address,
    input                           client_4_rq,     
    output                          client_4_ack,    
    input                           client_4_wr_ni,  
    input      [DATA_WIDTH-1 : 0]   client_4_dataW,  
    output     [DATA_WIDTH-1 : 0]   client_4_dataR
);

    // Internal signals and registers

    reg [1:0] client_1_priority;
    reg [1:0] client_2_priority;
    reg [1:0] client_3_priority;
    reg [1:0] client_4_priority;

    wire [1:0] address_to_be_served;



    // Module instantiation

    strict_priority_logic SP_LOGIC(
        .clk                    (clk                    ),
        .reset                  (reset                  ),
        .client_1_priority      (client_1_priority      ),
        .client_1_rq            (client_1_rq            ),
        .client_2_priority      (client_2_priority      ),
        .client_2_rq            (client_2_rq            ),
        .client_3_priority      (client_3_priority      ),
        .client_3_rq            (client_3_rq            ),
        .client_4_priority      (client_4_priority      ),
        .client_4_rq            (client_4_rq            ),
        .server_ack             (server_ack             ),
        .address_to_be_served   (address_to_be_served   )
    );

    always @(posedge clk or posedge reset)
    begin
        client_1_priority <= CLIENT_1_PRIORITY;
        client_2_priority <= CLIENT_2_PRIORITY;
        client_3_priority <= CLIENT_3_PRIORITY;
        client_4_priority <= CLIENT_4_PRIORITY;
    end


    assign server_rq =  (address_to_be_served == 'b00)? client_1_rq:
                        (address_to_be_served == 'b01)? client_2_rq:
                        (address_to_be_served == 'b10)? client_3_rq:
                        (address_to_be_served == 'b11)? client_4_rq:'b0;

    assign client_1_ack = (address_to_be_served == 'b00)? server_ack:'b0;
    assign client_2_ack = (address_to_be_served == 'b01)? server_ack:'b0;
    assign client_3_ack = (address_to_be_served == 'b10)? server_ack:'b0;
    assign client_4_ack = (address_to_be_served == 'b11)? server_ack:'b0;

    assign server_dataW =   (address_to_be_served == 'b00)? client_1_dataW:
                            (address_to_be_served == 'b01)? client_2_dataW:
                            (address_to_be_served == 'b10)? client_3_dataW:
                            (address_to_be_served == 'b11)? client_4_dataW:'b0;
    

    assign client_1_dataR  = (address_to_be_served == 'b00)? server_dataR:'b0;
    assign client_2_dataR  = (address_to_be_served == 'b01)? server_dataR:'b0;
    assign client_3_dataR  = (address_to_be_served == 'b10)? server_dataR:'b0;
    assign client_4_dataR  = (address_to_be_served == 'b11)? server_dataR:'b0;

    assign server_wr_ni  =  (address_to_be_served == 'b00)? client_1_wr_ni:
                            (address_to_be_served == 'b01)? client_2_wr_ni:
                            (address_to_be_served == 'b10)? client_3_wr_ni:
                            (address_to_be_served == 'b11)? client_4_wr_ni:'b0;

    assign server_address  =    (address_to_be_served == 'b00)? client_1_address:
                                (address_to_be_served == 'b01)? client_2_address:
                                (address_to_be_served == 'b10)? client_3_address:
                                (address_to_be_served == 'b11)? client_4_address:'b0;


endmodule