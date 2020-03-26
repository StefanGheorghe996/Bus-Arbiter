// Module:  client_test
// Author:  Gheorghe Stefan
// Date:    26.03.2020

module client_test();

// Parameters
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 4;
parameter ADDR_SPACE_BEGINNING = 0;
parameter ADDR_SPACE_END = 3;
parameter REQUEST_DELAY = 2;
parameter CLOCK_PERIOD = 5;
parameter RST_DELAY = 30;
parameter RST_DURATION = 2;

// Internal signals
wire                    clk     ;
wire                    reset   ;
wire [ADDR_WIDTH-1 : 0] address ;
wire                    rq      ;
wire                    ack     ;
wire                    wr_ni   ;
wire [DATA_WIDTH-1 : 0] dataW   ;
wire [DATA_WIDTH-1 : 0] dataR   ;


// Module instantiation
client #(DATA_WIDTH,ADDR_WIDTH,ADDR_SPACE_BEGINNING,ADDR_SPACE_END,REQUEST_DELAY) DUT (
    .clk        (clk    ), 
    .reset      (reset  ),
    .address    (address),
    .rq         (rq     ),
    .ack        (ack    ),
    .wr_ni      (wr_ni  ),
    .dataW      (dataW  ),
    .dataR      (dataR  )
);

client_tb #(DATA_WIDTH,ADDR_WIDTH) TB (
    .clk        (clk    ), 
    .reset      (reset  ),
    .address    (address),
    .rq         (rq     ),
    .ack        (ack    ),
    .wr_ni      (wr_ni  ),
    .dataW      (dataW  ),
    .dataR      (dataR  )

);

clock_rst_gen #(CLOCK_PERIOD,RST_DELAY,RST_DURATION) CLK_GEN (
    .clk        (clk    ), 
    .reset      (reset  )
);


endmodule // client_test