library verilog;
use verilog.vl_types.all;
entity lfsr is
    generic(
        SEED            : integer := 3
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        enable          : in     vl_logic;
        rq              : out    vl_logic
    );
end lfsr;
