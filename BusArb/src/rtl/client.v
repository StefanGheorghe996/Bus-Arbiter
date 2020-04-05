// Module:  client
// Author:  Gheorghe Stefan
// Date:    26.03.2020

module client#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4,
    parameter ADDR_SPACE_BEGINNING = 0,
    parameter ADDR_SPACE_END = 3,
    parameter LFSR_SEED = 'b00101
)(
    input                       clk,     // Clock signal
    input                       reset,   // Reset signal, active 1
    output  [ADDR_WIDTH-1 : 0]  address, // Address line
    output                      rq,      // Request signal
    input                       ack,     // Acknowledge input
    output                      wr_ni,   // Selection between read and write operations, 1 = read, 0 = write
    output  [DATA_WIDTH-1 : 0]  dataW,   // Data to be written
    input   [DATA_WIDTH-1 : 0]  dataR    // Read data from the server
);

    // Internal signals and registers
    reg [DATA_WIDTH-1 : 0] counter_1; // Counter for data generation
    reg [ADDR_WIDTH-1 : 0] counter_2; // Counter for address generation
    reg [DATA_WIDTH-1 : 0] dataR_reg; // Reg for holding read data

    wire request_wire           ;
    wire enable_address_counter ;
    wire enable_data_counter    ;
    wire enable_lfsr            ;
    wire enable_rq              ;

    // Module instantiation

    client_control_logic CONTROL_LOGIC (
        .clk                    ( clk                    ),                    
        .rst                    ( reset                  ),
        .ack                    ( ack                    ),
        .rq                     ( request_wire           ),
        .enable_rq              ( enable_rq              ),
        .enable_address_counter ( enable_address_counter ),                   
        .enable_data_counter    ( enable_data_counter    ),                
        .enable_lfsr            ( enable_lfsr            ),        
        .wr_ni                  ( wr_ni                  )  
    );

    lfsr #(LFSR_SEED) LFSR (
        .clk        ( clk          ),
        .rst        ( reset        ),
        .enable     ( enable_lfsr  ),
        .rq         ( request_wire )
    );

    // Counters behaviour modeling

    always @(posedge clk or posedge reset)
    begin
        if(reset) counter_1 <= 'b0;
        else if (enable_data_counter == 'b1) counter_1 <= counter_1 + 'b1; 
    end

    always @(posedge clk or posedge reset)
    begin
        if(reset) counter_2 <= ADDR_SPACE_BEGINNING;
        else if ((enable_address_counter == 'b1) && (counter_2 < ADDR_SPACE_END) && (counter_2 >= ADDR_SPACE_BEGINNING)) counter_2 <= counter_2 + 'b1; 
        else if(enable_address_counter && counter_2 == ADDR_SPACE_END) counter_2 <= ADDR_SPACE_BEGINNING;
    end
    
    always @(*)
    begin
        if(reset) dataR_reg <= 'b0;
        else if (ack) dataR_reg <= dataR; 
    end

    

    assign address = counter_2;
    assign dataW   = counter_1;
    assign rq      = enable_rq;


endmodule // client