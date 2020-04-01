// Module:  client_ram_test
// Author:  Gheorghe Stefan
// Date:    30.03.2020


module client_ram_test();

// Parameters
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 4;
parameter ADDR_SPACE_BEGINNING = 0;
parameter ADDR_SPACE_END = 3;
parameter LFSR_SEED = 5'b00011;
parameter CLOCK_PERIOD = 5;
parameter RST_DELAY = 3;
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
client #(DATA_WIDTH,ADDR_WIDTH,ADDR_SPACE_BEGINNING,ADDR_SPACE_END,LFSR_SEED) CLIENT (
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

ram #(DATA_WIDTH,ADDR_WIDTH) RAM(
    .clk        (clk    ), 
    .address    (address),
    .rq         (rq     ),
    .ack        (ack    ),
    .wr_ni      (wr_ni  ),
    .dataW      (dataW  ),
    .dataR      (dataR  )
);

endmodule // client_ram_test