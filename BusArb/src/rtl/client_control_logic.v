// Module:  client_control_logic
// Author:  Gheorghe Stefan
// Date:    31.03.2020

module client_control_logic(
    input       clk,
    input       rst,
    input       ack,
    input       rq,
    output      enable_address_counter,
    output      enable_data_counter,
    output      enable_lfsr,
    output reg  wr_ni
);


//State parameters
    parameter IDLE              = 2'b00; // Idle state
    parameter GENERATE_RQ       = 2'b10; // Wait for the request signal to be generated
    parameter WAIT_ACK          = 2'b01; // Wait for receiving ack


// Internal signals and registers
    reg [2:0] state;
    reg [2:0] next_state;

    // State transition

    always @(posedge clk or negedge rstn)
    begin
        if(~rstn) state <= IDLE;
        else if (sw_rst) state <= IDLE;
        else state <= next_state;
    end 

    always #(*)
    begin
        case (state)
            IDLE: next_state <= GENERATE_RQ;
            GENERATE_RQ: if (rq == 'b0) next_state <= GENERATE_RQ;
                         else           next_state <= WAIT_ACK;

            WAIT_ACK:   if (ack == 'b0) next_state <= WAIT_ACK;
                        else            next_state <= GENERATE_RQ;
            default: IDLE;
        endcase 
    end

    //wr_ni reg behaviour

endmodule // client_control_logic 
