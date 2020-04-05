// Module:  system_test
// Author:  Gheorghe Stefan
// Date:    04.04.2020

module system_test;


// General parameters       
localparam DATA_WIDTH                    = 8;        
localparam ADDR_WIDTH                    = 4;        

// First client module specific parameters      
localparam CLIENT_1_ADDR_SPACE_BEGINNING = 0;      // Assigning an address space for the client          
localparam CLIENT_1_ADDR_SPACE_END       = 3;        
localparam CLIENT_1_LFSR_SEED            = 'b00010; // LFSR seed for random request generation      

// Second client module specific parameters     
localparam CLIENT_2_ADDR_SPACE_BEGINNING = 4;        
localparam CLIENT_2_ADDR_SPACE_END       = 7;        
localparam CLIENT_2_LFSR_SEED            = 'b00111;      

// Third client module specific parameters      
localparam CLIENT_3_ADDR_SPACE_BEGINNING = 8;        
localparam CLIENT_3_ADDR_SPACE_END       = 11;       
localparam CLIENT_3_LFSR_SEED            = 'b00100;      

// Fourth client module specific parameters     
localparam CLIENT_4_ADDR_SPACE_BEGINNING = 12;       
localparam CLIENT_4_ADDR_SPACE_END       = 15;       
localparam CLIENT_4_LFSR_SEED            = 'b00000;      


// Server memory module specific parameters     
localparam DELAY_ACK                     = 0;   
localparam NO_DELAY                      = 1;     


// Bus arbiter module specific parameters
localparam CLIENT_1_PRIORITY = 3;
localparam CLIENT_2_PRIORITY = 2;
localparam CLIENT_3_PRIORITY = 1;
localparam CLIENT_4_PRIORITY = 0;
localparam PRIORITY_SCHEDULING_ALGORITHM = 1'b0;     // 0 = strict priority 1 = round robin

// Clock and reset generator module specific parameters
localparam CLOCK_PERIOD = 5;
localparam RST_DELAY = 3;
localparam RST_DURATION = 2;



// Internal signals
wire                    clk     ;
wire                    reset   ;


wire [ADDR_WIDTH-1 : 0] address_client_1 ;
wire                    rq_client_1      ;
wire                    ack_client_1     ;
wire                    wr_ni_client_1   ;
wire [DATA_WIDTH-1 : 0] dataW_client_1   ;
wire [DATA_WIDTH-1 : 0] dataR_client_1   ;

wire [ADDR_WIDTH-1 : 0] address_client_2 ;
wire                    rq_client_2      ;
wire                    ack_client_2     ;
wire                    wr_ni_client_2   ;
wire [DATA_WIDTH-1 : 0] dataW_client_2   ;
wire [DATA_WIDTH-1 : 0] dataR_client_2   ;

wire [ADDR_WIDTH-1 : 0] address_client_3 ;
wire                    rq_client_3      ;
wire                    ack_client_3     ;
wire                    wr_ni_client_3   ;
wire [DATA_WIDTH-1 : 0] dataW_client_3   ;
wire [DATA_WIDTH-1 : 0] dataR_client_3   ;

wire [ADDR_WIDTH-1 : 0] address_client_4 ;
wire                    rq_client_4      ;
wire                    ack_client_4     ;
wire                    wr_ni_client_4   ;
wire [DATA_WIDTH-1 : 0] dataW_client_4   ;
wire [DATA_WIDTH-1 : 0] dataR_client_4   ;

wire [ADDR_WIDTH-1 : 0] address_srv ;
wire                    rq_srv      ;
wire                    ack_srv     ;
wire                    wr_ni_srv   ;
wire [DATA_WIDTH-1 : 0] dataW_srv   ;
wire [DATA_WIDTH-1 : 0] dataR_srv   ;

// Module instantiation

// Clock and reset generator instantiation
clock_rst_gen #(CLOCK_PERIOD,RST_DELAY,RST_DURATION) CLK_GEN (
    .clk        (clk    ), 
    .reset      (reset  )
);

client #(DATA_WIDTH,ADDR_WIDTH,CLIENT_1_ADDR_SPACE_BEGINNING,CLIENT_1_ADDR_SPACE_END,CLIENT_1_LFSR_SEED) CLIENT_1 (
    .clk        (clk    ), 
    .reset      (reset  ),
    .address    (address_client_1),
    .rq         (rq_client_1     ),
    .ack        (ack_client_1    ),
    .wr_ni      (wr_ni_client_1  ),
    .dataW      (dataW_client_1  ),
    .dataR      (dataR_client_1  )
);

client #(DATA_WIDTH,ADDR_WIDTH,CLIENT_2_ADDR_SPACE_BEGINNING,CLIENT_2_ADDR_SPACE_END,CLIENT_2_LFSR_SEED) CLIENT_2 (
    .clk        (clk    ), 
    .reset      (reset  ),
    .address    (address_client_2),
    .rq         (rq_client_2     ),
    .ack        (ack_client_2    ),
    .wr_ni      (wr_ni_client_2  ),
    .dataW      (dataW_client_2  ),
    .dataR      (dataR_client_2  )
);


client #(DATA_WIDTH,ADDR_WIDTH,CLIENT_3_ADDR_SPACE_BEGINNING,CLIENT_3_ADDR_SPACE_END,CLIENT_3_LFSR_SEED) CLIENT_3 (
    .clk        (clk    ), 
    .reset      (reset  ),
    .address    (address_client_3),
    .rq         (rq_client_3     ),
    .ack        (ack_client_3    ),
    .wr_ni      (wr_ni_client_3  ),
    .dataW      (dataW_client_3  ),
    .dataR      (dataR_client_3  )
);


client #(DATA_WIDTH,ADDR_WIDTH,CLIENT_4_ADDR_SPACE_BEGINNING,CLIENT_4_ADDR_SPACE_END,CLIENT_4_LFSR_SEED) CLIENT_4 (
    .clk        (clk    ), 
    .reset      (reset  ),
    .address    (address_client_4),
    .rq         (rq_client_4     ),
    .ack        (ack_client_4    ),
    .wr_ni      (wr_ni_client_4  ),
    .dataW      (dataW_client_4  ),
    .dataR      (dataR_client_4  )
);


bus_arbiter #(DATA_WIDTH,ADDR_WIDTH,CLIENT_1_PRIORITY,CLIENT_2_PRIORITY,CLIENT_3_PRIORITY,CLIENT_4_PRIORITY,PRIORITY_SCHEDULING_ALGORITHM) ARBITER(
    .clk                        (clk            ),
    .reset                      (reset          ),
    .server_address             (address_srv    ),
    .server_rq                  (rq_srv         ),
    .server_ack                 (ack_srv        ),
    .server_wr_ni               (wr_ni_srv      ),
    .server_dataW               (dataW_srv      ),
    .server_dataR               (dataR_srv      ),


    .client_1_address           (address_client_1    ),
    .client_1_rq                (rq_client_1         ),
    .client_1_ack               (ack_client_1        ),
    .client_1_wr_ni             (wr_ni_client_1      ),
    .client_1_dataW             (dataW_client_1      ),
    .client_1_dataR             (dataR_client_1      ),


    .client_2_address           (address_client_2    ),
    .client_2_rq                (rq_client_2         ),
    .client_2_ack               (ack_client_2        ),
    .client_2_wr_ni             (wr_ni_client_2      ),
    .client_2_dataW             (dataW_client_2      ),
    .client_2_dataR             (dataR_client_2      ),


    .client_3_address           (address_client_3    ),
    .client_3_rq                (rq_client_3         ),
    .client_3_ack               (ack_client_3        ),
    .client_3_wr_ni             (wr_ni_client_3      ),
    .client_3_dataW             (dataW_client_3      ),
    .client_3_dataR             (dataR_client_3      ),


    .client_4_address           (address_client_4    ),
    .client_4_rq                (rq_client_4         ),
    .client_4_ack               (ack_client_4        ),
    .client_4_wr_ni             (wr_ni_client_4      ),
    .client_4_dataW             (dataW_client_4      ),
    .client_4_dataR             (dataR_client_4      )
);



ram #(DATA_WIDTH,ADDR_WIDTH,NO_DELAY,DELAY_ACK) RAM(
    .clk        (clk    ), 
    .reset      (reset  ),
    .address    (address_srv),
    .rq         (rq_srv     ),
    .ack        (ack_srv    ),
    .wr_ni      (wr_ni_srv  ),
    .dataW      (dataW_srv  ),
    .dataR      (dataR_srv  )
);

    
endmodule