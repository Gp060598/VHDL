library verilog;
use verilog.vl_types.all;
entity test is
    port(
        clk             : in     vl_logic;
        reset           : out    vl_logic;
        write           : out    vl_logic;
        data_in         : out    vl_logic_vector(15 downto 0);
        address         : out    vl_logic_vector(2 downto 0);
        data_out        : in     vl_logic_vector(15 downto 0)
    );
end test;
