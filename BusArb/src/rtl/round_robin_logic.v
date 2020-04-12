// Module:  round_robin_logic
// Author:  Gheorghe Stefan
// Date:    02.04.2020

module round_robin_logic#(
    parameter NUMBER_OF_CLIENTS = 4
)
(
    // Global signals
    input               clk,
    input               reset,
    input               client_1_rq,     
    input               client_2_rq,     
    input               client_3_rq,     
    input               client_4_rq,     
    input               server_ack,
    output  reg [1:0]   address_to_be_served,
    input               enable
);


    // Internal signals, registers and parameters

    reg [3:0] ring_counter; 
    reg [1:0] sp_1_client_1_priority;
    reg [1:0] sp_1_client_2_priority;
    reg [1:0] sp_1_client_3_priority;
    reg [1:0] sp_1_client_4_priority;

    reg [1:0] sp_2_client_1_priority;
    reg [1:0] sp_2_client_2_priority;
    reg [1:0] sp_2_client_3_priority;
    reg [1:0] sp_2_client_4_priority;

    reg [1:0] sp_3_client_1_priority;
    reg [1:0] sp_3_client_2_priority;
    reg [1:0] sp_3_client_3_priority;
    reg [1:0] sp_3_client_4_priority;

    reg [1:0] sp_4_client_1_priority;
    reg [1:0] sp_4_client_2_priority;
    reg [1:0] sp_4_client_3_priority;
    reg [1:0] sp_4_client_4_priority;

    wire sp_1_enable;
    wire sp_2_enable;
    wire sp_3_enable;
    wire sp_4_enable;

    wire [1:0] sp_1_address_to_be_served;
    wire [1:0] sp_2_address_to_be_served;
    wire [1:0] sp_3_address_to_be_served;
    wire [1:0] sp_4_address_to_be_served;
         

    // Module instantiation

    strict_priority_logic STRICT_PRIORITY_1(
        .clk                    (clk                      ),
        .reset                  (reset                    ),
        .client_1_priority      (sp_1_client_1_priority   ), 
        .client_1_rq            (client_1_rq              ),
        .client_2_priority      (sp_1_client_2_priority   ),
        .client_2_rq            (client_2_rq              ),
        .client_3_priority      (sp_1_client_3_priority   ),
        .client_3_rq            (client_3_rq              ),
        .client_4_priority      (sp_1_client_4_priority   ),
        .client_4_rq            (client_4_rq              ),
        .server_ack             (server_ack               ),
        .address_to_be_served   (sp_1_address_to_be_served),
        .enable                 (sp_1_enable              )
    );

    strict_priority_logic STRICT_PRIORITY_2(
        .clk                    (clk                      ),
        .reset                  (reset                    ),
        .client_1_priority      (sp_2_client_1_priority   ), 
        .client_1_rq            (client_1_rq              ),
        .client_2_priority      (sp_2_client_2_priority   ),
        .client_2_rq            (client_2_rq              ),
        .client_3_priority      (sp_2_client_3_priority   ),
        .client_3_rq            (client_3_rq              ),
        .client_4_priority      (sp_2_client_4_priority   ),
        .client_4_rq            (client_4_rq              ),
        .server_ack             (server_ack               ),
        .address_to_be_served   (sp_2_address_to_be_served),
        .enable                 (sp_2_enable              )
    );

    strict_priority_logic STRICT_PRIORITY_3(
        .clk                    (clk                      ),
        .reset                  (reset                    ),
        .client_1_priority      (sp_3_client_1_priority   ), 
        .client_1_rq            (client_1_rq              ),
        .client_2_priority      (sp_3_client_2_priority   ),
        .client_2_rq            (client_2_rq              ),
        .client_3_priority      (sp_3_client_3_priority   ),
        .client_3_rq            (client_3_rq              ),
        .client_4_priority      (sp_3_client_4_priority   ),
        .client_4_rq            (client_4_rq              ),
        .server_ack             (server_ack               ),
        .address_to_be_served   (sp_3_address_to_be_served),
        .enable                 (sp_3_enable              )
    );

    strict_priority_logic STRICT_PRIORITY_4(
        .clk                    (clk                      ),
        .reset                  (reset                    ),
        .client_1_priority      (sp_4_client_1_priority   ), 
        .client_1_rq            (client_1_rq              ),
        .client_2_priority      (sp_4_client_2_priority   ),
        .client_2_rq            (client_2_rq              ),
        .client_3_priority      (sp_4_client_3_priority   ),
        .client_3_rq            (client_3_rq              ),
        .client_4_priority      (sp_4_client_4_priority   ),
        .client_4_rq            (client_4_rq              ),
        .server_ack             (server_ack               ),
        .address_to_be_served   (sp_4_address_to_be_served),
        .enable                 (sp_4_enable              )
    );

    always @(posedge clk or posedge reset)
    begin
        if (reset) 
        begin
            sp_1_client_1_priority  <= 2'b11; 
            sp_1_client_2_priority  <= 2'b11;
            sp_1_client_3_priority  <= 2'b11;
            sp_1_client_4_priority  <= 2'b11;
        end
        else if (enable)
        begin
            sp_1_client_1_priority  <= 2'b00; 
            sp_1_client_2_priority  <= 2'b01;
            sp_1_client_3_priority  <= 2'b10;
            sp_1_client_4_priority  <= 2'b11;
        end       
    end

    always @(posedge clk or posedge reset)
    begin
        if (reset) 
        begin
            sp_2_client_1_priority  <= 2'b11; 
            sp_2_client_2_priority  <= 2'b11;
            sp_2_client_3_priority  <= 2'b11;
            sp_2_client_4_priority  <= 2'b11;
        end
        else if (enable)
        begin
            sp_2_client_1_priority  <= 2'b01; 
            sp_2_client_2_priority  <= 2'b00;
            sp_2_client_3_priority  <= 2'b10;
            sp_2_client_4_priority  <= 2'b11;
        end       
    end

    always @(posedge clk or posedge reset)
    begin
        if (reset) 
        begin
            sp_3_client_1_priority  <= 2'b11; 
            sp_3_client_2_priority  <= 2'b11;
            sp_3_client_3_priority  <= 2'b11;
            sp_3_client_4_priority  <= 2'b11;
        end
        else if (enable)
        begin
            sp_3_client_1_priority  <= 2'b10; 
            sp_3_client_2_priority  <= 2'b01;
            sp_3_client_3_priority  <= 2'b00;
            sp_3_client_4_priority  <= 2'b11;
        end       
    end

    always @(posedge clk or posedge reset)
    begin
        if (reset) 
        begin
            sp_4_client_1_priority  <= 2'b11; 
            sp_4_client_2_priority  <= 2'b11;
            sp_4_client_3_priority  <= 2'b11;
            sp_4_client_4_priority  <= 2'b11;
        end
        else
        begin if (enable)
            sp_4_client_1_priority  <= 2'b11; 
            sp_4_client_2_priority  <= 2'b10;
            sp_4_client_3_priority  <= 2'b01;
            sp_4_client_4_priority  <= 2'b00;
        end       
    end

    always @(posedge clk or posedge reset)
    begin
        if (reset)            address_to_be_served  <= 'b0;
        else if (sp_1_enable) address_to_be_served <= sp_1_address_to_be_served;
        else if (sp_2_enable) address_to_be_served <= sp_2_address_to_be_served;
        else if (sp_3_enable) address_to_be_served <= sp_3_address_to_be_served;
        else if (sp_4_enable) address_to_be_served <= sp_4_address_to_be_served;
              
    end

    assign sp_1_enable = ring_counter[3];
    assign sp_2_enable = ring_counter[2];
    assign sp_3_enable = ring_counter[1];
    assign sp_4_enable = ring_counter[0];

    always @(posedge clk or posedge reset)
    begin
        if(reset)  
        begin
            ring_counter[NUMBER_OF_CLIENTS-1] <= 'b1;
            ring_counter[NUMBER_OF_CLIENTS-2:0] <= 'b0;
        end
        else if (enable)
        if(NUMBER_OF_CLIENTS == 'd4)
        begin
            if      (sp_1_enable && sp_1_address_to_be_served == 2'b00) ring_counter <= (server_ack)? {ring_counter[0],ring_counter[3:1]} : ring_counter;
            else if (sp_2_enable && sp_2_address_to_be_served == 2'b01) ring_counter <= (server_ack)? {ring_counter[0],ring_counter[3:1]} : ring_counter;
            else if (sp_3_enable && sp_3_address_to_be_served == 2'b10) ring_counter <= (server_ack)? {ring_counter[0],ring_counter[3:1]} : ring_counter;
            else if (sp_4_enable && sp_4_address_to_be_served == 2'b11) ring_counter <= (server_ack)? {ring_counter[0],ring_counter[3:1]} : ring_counter;
        end
    end


endmodule