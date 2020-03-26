// Module:  client_tb
// Author:  Gheorghe Stefan
// Date:    26.03.2020

module client_tb#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input                           clk,     // Clock signal
    input                           reset,   // Reset signal, active 1
    input      [ADDR_WIDTH-1 : 0]   address, // Address line
    input                           rq,      // Request signal
    output reg                      ack,     // Acknowledge output
    input                           wr_ni,   // Selection between read and write operations, 1 = read, 0 = write
    input      [DATA_WIDTH-1 : 0]   dataW,   // Data to be written
    output reg [DATA_WIDTH-1 : 0]   dataR    // Date sent to client
);

task generate_ack;
    begin
        ack <= 'b0;
        @(posedge rq);
        @(posedge clk);
        $display("%M %t - ACK SIGNAL ASSERTED", $time);
        ack <= 'b1;
        @(posedge clk);
        ack <= 'b0;
        $display("%M %t - ACK SIGNAL DEASSERTED", $time);
    end    
endtask

task generate_dataR;
    begin
        dataR <= $random;
    end    
endtask

initial
    begin
        wait(reset);
        forever
        begin
            generate_dataR;
            generate_ack;
        end
    end
endmodule // client_tb