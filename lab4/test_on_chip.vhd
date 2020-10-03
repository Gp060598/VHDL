library ieee;
use ieee.std_logic_1164.all;
use work.my_declerations.all;

entity test is
end test;

architecture test_chip of test is
component comp is
generic(N:integer:=16);
port(clk,reset:in std_logic;
     output:out std_logic_vector(n-1 downto 0)
);

end component;
signal clk_tb:std_logic:='0';
constant period:time:= 10 ns;
signal reset_tb:std_logic;
signal output_tb:std_logic_vector(15 downto 0);
 begin
 u0: comp generic map(16) port map(clk=>clk_tb,reset=>reset_tb,output=>output_tb);
 clk_tb<=not(clk_tb) after (period/2);
 process
  begin
  reset_tb<='0';
  wait for period*2;
  reset_tb<='1';
  wait;
end process;
end test_chip;
