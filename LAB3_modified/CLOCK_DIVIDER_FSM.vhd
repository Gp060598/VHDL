library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity divider is
port( clk_in:in std_logic;
     clk_out:out std_logic);
end divider;

architecture implement of divider is
signal tmp:std_logic:='0';
Signal count:integer:= 0;
begin

process(clk_in) is
begin
if(rising_Edge(clk_in)) then
 count<=count+1;
 if(count=1) then
 tmp<=not(tmp);
 count<=1;
end if;
end if;
--clk_out<=tmp;
end process;
clk_out<=tmp;
end implement;
