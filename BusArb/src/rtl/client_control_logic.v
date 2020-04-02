// Module:  client_control_logic
// Author:  Gheorghe Stefan
// Date:    31.03.2020

module client_control_logic
(
    input       clk,
    input       rst,
    input       ack,
    input       rq,
    output      enable_address_counter,
    output      enable_data_counter,
    output      enable_lfsr,
    output      enable_rq,
    output      wr_ni
);


    //State parameters
    parameter IDLE                          = 3'b000; // Idle state
    parameter GENERATE_WRITE_TRANSACTION    = 3'b010; // Wait for the request signal to be generated, generate write transaction
    parameter GENERATE_READ_TRANSACTION     = 3'b011; // Wait for the request signal to be generated, generate write transaction
    parameter WAIT_ACK                      = 3'b100; // Wait for receiving ack


    // Internal signals and registers
    reg [2:0] state;
    reg [2:0] next_state;
    reg       wr_ni_reg;



    // State transition

    always @(posedge clk or posedge rst)
    begin
        if(rst) state <= IDLE;
        else state <= next_state;
    end 

    always @(*)
    begin
        case (state)

            IDLE: next_state <= GENERATE_WRITE_TRANSACTION;

            GENERATE_WRITE_TRANSACTION: if (rq == 'b0) next_state <= GENERATE_WRITE_TRANSACTION;
                                        else           next_state <= WAIT_ACK;

            GENERATE_READ_TRANSACTION:  if (rq == 'b0) next_state <= GENERATE_READ_TRANSACTION;
                                        else           next_state <= WAIT_ACK;

            WAIT_ACK:   if (ack == 'b0)                             next_state <= WAIT_ACK;
                        else if (wr_ni_reg == 'b0 && ack == 'b1)    next_state <= GENERATE_READ_TRANSACTION;
                        else if (wr_ni_reg == 'b1 && ack == 'b1)    next_state <= GENERATE_WRITE_TRANSACTION;

            default: next_state <= IDLE;
        endcase 

    end

    // wr_ni reg behaviour
    always @(posedge clk or posedge rst)
    begin
        if(rst) wr_ni_reg <= 'b0;
        else if(state == GENERATE_WRITE_TRANSACTION) wr_ni_reg <= 'b0;
        else if(state == GENERATE_READ_TRANSACTION)  wr_ni_reg <= 'b1;
    end 

    assign wr_ni                    = wr_ni_reg;
    assign enable_address_counter   = state == GENERATE_WRITE_TRANSACTION;   
    assign enable_data_counter      = state == GENERATE_WRITE_TRANSACTION;  
    assign enable_lfsr              = state == GENERATE_WRITE_TRANSACTION | GENERATE_READ_TRANSACTION;  
    assign enable_rq                = state == WAIT_ACK;

endmodule // client_control_logic 
