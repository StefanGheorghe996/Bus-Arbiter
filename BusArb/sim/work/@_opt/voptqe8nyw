library verilog;
use verilog.vl_types.all;
entity clock_rst_gen is
    generic(
        CLOCK_PERIOD    : integer := 5;
        RST_DELAY       : integer := 30;
        RST_DURATION    : integer := 2
    );
    port(
        clk             : out    vl_logic;
        reset           : out    vl_logic
    );
end clock_rst_gen;
