library verilog;
use verilog.vl_types.all;
entity client is
    generic(
        DATA_WIDTH      : integer := 8;
        ADDR_WIDTH      : integer := 4;
        ADDR_SPACE_BEGINNING: integer := 0;
        ADDR_SPACE_END  : integer := 3;
        LFSR_SEED       : integer := 5
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        address         : out    vl_logic_vector;
        rq              : out    vl_logic;
        ack             : in     vl_logic;
        wr_ni           : out    vl_logic;
        dataW           : out    vl_logic_vector;
        dataR           : in     vl_logic_vector
    );
end client;
