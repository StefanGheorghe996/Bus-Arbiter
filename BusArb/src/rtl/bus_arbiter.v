// Module:  bus_arbiter
// Author:  Gheorghe Stefan
// Date:    02.04.2020

module bus_arbiter #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4,
    parameter PRIORITY_SCHEDULING_ALGORITHM = 0 // Parameter used for selecting between priority scheduling algorithms: 0 for strict priority, 1 for round robin 
)(
    // Global signals
    input                           clk,    
    input                           reset, 

    // Server interface

    output      [ADDR_WIDTH-1 : 0]  srv_address,
    output                          srv_rq,     
    input                           srv_ack,    
    output                          srv_wr_ni,  
    output      [DATA_WIDTH-1 : 0]  srv_dataW,  
    input reg   [DATA_WIDTH-1 : 0]  srv_dataR,   
    
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
    
endmodule