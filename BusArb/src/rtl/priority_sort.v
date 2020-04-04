// Module:  priority_sort
// Author:  Gheorghe Stefan
// Date:    03.04.2020

module priority_sort(
     // Global signals
    input   clk,
    input   reset,

    input   [1:0] client_1_priority,
    input   [1:0] client_2_priority,
    input   [1:0] client_3_priority,
    input   [1:0] client_4_priority,

    output reg [1:0] first_priority_channel_addr,
    output reg [1:0] second_priority_channel_addr,
    output reg [1:0] third_priority_channel_addr,
    output reg [1:0] fourth_priority_channel_addr
    
);

always @(posedge clk or posedge reset)
begin
    if(reset) first_priority_channel_addr <= 'b0;
    else if(client_1_priority == 2'b00) first_priority_channel_addr <= 2'b00;
    else if(client_2_priority == 2'b00) first_priority_channel_addr <= 2'b01;
    else if(client_3_priority == 2'b00) first_priority_channel_addr <= 2'b10;
    else if(client_4_priority == 2'b00) first_priority_channel_addr <= 2'b11;
end

always @(posedge clk or posedge reset)
begin
    if(reset) first_priority_channel_addr <= 'b0;
    else if(client_1_priority == 2'b01) second_priority_channel_addr <= 2'b00;
    else if(client_2_priority == 2'b01) second_priority_channel_addr <= 2'b01;
    else if(client_3_priority == 2'b01) second_priority_channel_addr <= 2'b10;
    else if(client_4_priority == 2'b01) second_priority_channel_addr <= 2'b11;
end

always @(posedge clk or posedge reset)
begin
    if(reset) first_priority_channel_addr <= 'b0;
    else if(client_1_priority == 2'b10) third_priority_channel_addr <= 2'b00;
    else if(client_2_priority == 2'b10) third_priority_channel_addr <= 2'b01;
    else if(client_3_priority == 2'b10) third_priority_channel_addr <= 2'b10;
    else if(client_4_priority == 2'b10) third_priority_channel_addr <= 2'b11;
end

always @(posedge clk or posedge reset)
begin
    if(reset) first_priority_channel_addr <= 'b0;
    else if(client_1_priority == 2'b11) fourth_priority_channel_addr <= 2'b00;
    else if(client_2_priority == 2'b11) fourth_priority_channel_addr <= 2'b01;
    else if(client_3_priority == 2'b11) fourth_priority_channel_addr <= 2'b10;
    else if(client_4_priority == 2'b11) fourth_priority_channel_addr <= 2'b11;
end

    
endmodule