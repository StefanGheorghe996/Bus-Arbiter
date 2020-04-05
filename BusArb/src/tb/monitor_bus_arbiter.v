// Module:  monitor_bus_arbiter
// Author:  Gheorghe Stefan
// Date:    05.04.2020

module monitor_bus_arbiter#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    // Global signals
    input                           clk,    
    input                           reset, 

    // Server interface

    input       [ADDR_WIDTH-1 : 0]  server_address,
    input                           server_rq,     
    input                           server_ack,    
    input                           server_wr_ni,  
    input       [DATA_WIDTH-1 : 0]  server_dataW,  
    input       [DATA_WIDTH-1 : 0]  server_dataR,   
    
    // Client 1 interface
    
    input      [ADDR_WIDTH-1 : 0]   client_1_address,
    input                           client_1_rq,     
    input                           client_1_ack,    
    input                           client_1_wr_ni,  
    input      [DATA_WIDTH-1 : 0]   client_1_dataW,  
    input      [DATA_WIDTH-1 : 0]   client_1_dataR,   
      
    
    // Client 2 interface

    input      [ADDR_WIDTH-1 : 0]   client_2_address,
    input                           client_2_rq,     
    input                           client_2_ack,    
    input                           client_2_wr_ni,  
    input      [DATA_WIDTH-1 : 0]   client_2_dataW,  
    input      [DATA_WIDTH-1 : 0]   client_2_dataR,

    // Client 3 interface
    
    input     [ADDR_WIDTH-1 : 0]   client_3_address,
    input                          client_3_rq,     
    input                          client_3_ack,    
    input                          client_3_wr_ni,  
    input     [DATA_WIDTH-1 : 0]   client_3_dataW,  
    input     [DATA_WIDTH-1 : 0]   client_3_dataR,
    
    // Client 4 interface
    
    input     [ADDR_WIDTH-1 : 0]   client_4_address,
    input                          client_4_rq,     
    input                          client_4_ack,    
    input                          client_4_wr_ni,  
    input     [DATA_WIDTH-1 : 0]   client_4_dataW,  
    input     [DATA_WIDTH-1 : 0]   client_4_dataR
);

    always @(posedge client_1_rq)  
        begin
            if(client_1_wr_ni)      $display(" %t - CLIENT 1 - READ - ADDRESS: %b", $time,client_1_address);
            else                    $display(" %t - CLIENT 1 - WRITE - ADDRESS: %b - DATA: %b", $time,client_1_address,client_1_dataW);
        end

    always @(posedge client_2_rq)    
        begin
            if(client_2_wr_ni)      $display(" %t - CLIENT 2 - READ - ADDRESS: %b", $time,client_2_address);
            else                    $display(" %t - CLIENT 2 - WRITE - ADDRESS: %b - DATA: %b", $time,client_2_address,client_2_dataW);
        end

      always @(posedge client_3_rq)  
        begin
            if(client_3_wr_ni)      $display(" %t - CLIENT 3 - READ - ADDRESS: %b", $time,client_3_address);
            else                    $display(" %t - CLIENT 3 - WRITE - ADDRESS: %b - DATA: %b", $time,client_3_address,client_3_dataW);
        end

    always @(posedge client_4_rq)  
        begin
            if(client_4_wr_ni)      $display(" %t - CLIENT 4 - READ - ADDRESS: %b", $time,client_4_address);
            else                    $display(" %t - CLIENT 4 - WRITE - ADDRESS: %b - DATA: %b", $time,client_4_address,client_4_dataW);
        end 
    

    always @(posedge client_1_ack)  
        begin
            if(client_1_rq)
                if(client_1_wr_ni)      $display(" %t - CLIENT 1 READ REQUEST SERVED ADDRESS: %b, DATA RECEIVED: %b", $time,client_1_address,client_1_dataR);
                else                    $display(" %t - CLIENT 1 WRITE REQUEST SERVED ADDRESS: %b", $time,client_1_address);
            else $display("PROTOCOL ERROR ON CHANNEL 1 - ACK WITHOUT REQUEST");
        end

    always @(posedge client_2_ack)  
        begin
            if(client_2_rq)
                if(client_2_wr_ni)      $display(" %t - CLIENT 2 READ REQUEST SERVED ADDRESS: %b, DATA RECEIVED: %b", $time,client_2_address,client_2_dataR);
                else                    $display(" %t - CLIENT 2 WRITE REQUEST SERVED ADDRESS: %b", $time,client_2_address);
            else $display("PROTOCOL ERROR ON CHANNEL 2 - ACK WITHOUT REQUEST");
        end

    always @(posedge client_3_ack)  
        begin
            if(client_3_rq)
                if(client_3_wr_ni)      $display(" %t - CLIENT 3 READ REQUEST SERVED ADDRESS: %b, DATA RECEIVED: %b", $time,client_3_address,client_3_dataR);
                else                    $display(" %t - CLIENT 3 WRITE REQUEST SERVED ADDRESS: %b", $time,client_3_address);
            else $display("PROTOCOL ERROR ON CHANNEL 3 - ACK WITHOUT REQUEST");
        end

    always @(posedge client_4_ack)  
        begin
            if(client_4_rq)
                if(client_4_wr_ni)      $display(" %t - CLIENT 4 READ REQUEST SERVED ADDRESS: %b, DATA RECEIVED: %b", $time,client_4_address,client_4_dataR);
                else                    $display(" %t - CLIENT 4 WRITE REQUEST SERVED ADDRESS: %b", $time,client_4_address);
            else $display("PROTOCOL ERROR ON CHANNEL 4 - ACK WITHOUT REQUEST");
        end 

    
endmodule