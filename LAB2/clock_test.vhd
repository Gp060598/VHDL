library ieee;
use ieee.std_logic_1164.all;

entity clock is
port(clk:out std_logic; 
      clk_in:in std_logic);
end entity;

architecture test of clock is
begin
 process
constant period:time:=100 ns;
begin
 clk<='0';
loop
 wait for period/2;
 clk<=not(clk);
 end loop;
end process;
end test;
