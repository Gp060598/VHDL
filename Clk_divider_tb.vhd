 library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity test_divider is
end test_divider;

architecture clk_test of test_divider is
signal clk_in:std_logic:='0';
signal clk_out:std_logic;
constant period:time:=20 ns;
 component divider is
 port( clk_in:in std_logic;
     clk_out:out std_logic);
 end component;
 begin
 uut:divider port map( clk_in=>clk_in, clk_out=>clk_out);
  process is
  begin
  wait for period/2;
  clk_in<=not(clk_in);
 end process;
end clk_test;
