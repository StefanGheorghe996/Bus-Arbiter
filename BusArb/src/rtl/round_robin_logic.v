// Module:  round_robin_logic
// Author:  Gheorghe Stefan
// Date:    02.04.2020

module round_robin_logic(
    // Client 1 rq-ack protocol signals
    input                   client_1_rq,     
    output                  client_1_ack, 

    // Client 2 rq-ack protocol signals
    input                   client_2_rq,     
    output                  client_2_ack, 

    // Client 3 rq-ack protocol signals
    input                   client_3_rq,     
    output                  client_3_ack, 

    // Client 4 rq-ack protocol signals
    input                   client_4_rq,     
    output                  client_4_ack, 

    // Server rq-ack protocol signals

    output                  server_rq,
    input                   server_ack
);
    
endmodule