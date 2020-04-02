library verilog;
use verilog.vl_types.all;
entity client_control_logic is
    generic(
        IDLE            : integer := 0;
        GENERATE_WRITE_TRANSACTION: integer := 2;
        GENERATE_READ_TRANSACTION: integer := 3;
        WAIT_ACK        : integer := 4
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ack             : in     vl_logic;
        rq              : in     vl_logic;
        enable_address_counter: out    vl_logic;
        enable_data_counter: out    vl_logic;
        enable_lfsr     : out    vl_logic;
        enable_rq       : out    vl_logic;
        wr_ni           : out    vl_logic
    );
end client_control_logic;
