library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
entity testing is
port(a,b: in std_logic_vector(3 downto 0 );
     result:out std_logic_vector(3 downto 0 );
     flag:out std_logic;
     z_flag:out std_logic
     );

end testing;

architecture testing_done of testing is
signal temp:std_logic_vector(4 downto 0);
begin
process(a,b) is
begin
temp<=('0' & a)-('0' & b);
end process;
result<=temp(3 downto 0);
flag<='1' when temp(4)='1' else '0';
z_flag<='1' when temp(3 downto 0)="000" else '0';


end testing_done;
