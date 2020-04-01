library verilog;
use verilog.vl_types.all;
entity ram is
    generic(
        DATA_WIDTH      : integer := 8;
        ADDR_WIDTH      : integer := 4
    );
    port(
        clk             : in     vl_logic;
        address         : in     vl_logic_vector;
        rq              : in     vl_logic;
        ack             : out    vl_logic;
        wr_ni           : in     vl_logic;
        dataW           : in     vl_logic_vector;
        dataR           : out    vl_logic_vector
    );
end ram;
