library verilog;
use verilog.vl_types.all;
entity client_ram_test is
    generic(
        DATA_WIDTH      : integer := 8;
        ADDR_WIDTH      : integer := 4;
        ADDR_SPACE_BEGINNING: integer := 0;
        ADDR_SPACE_END  : integer := 3;
        LFSR_SEED       : integer := 3;
        CLOCK_PERIOD    : integer := 5;
        RST_DELAY       : integer := 3;
        RST_DURATION    : integer := 2
    );
end client_ram_test;
