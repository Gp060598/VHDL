library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity test_bench is
end test_bench;

architecture Alu_tb of test_bench is
component alu is
generic(N:integer:=4);
port( op:in std_logic_vector(2 downto 0);
      a,b:in std_logic_vector(N-1 downto 0);
      y:out std_logic_vector(N-1 downto 0);
      z_flag,n_flag,o_flag:out std_logic
     );
end component;
signal op_tb:std_logic_vector(2 downto 0);
signal a_tb,b_tb:std_logic_vector(3 downto 0);
signal y_tb:std_logic_vector(3 downto 0);
signal z_tb,n_tb,o_tb:std_logic;
type my_values is array(integer range <>) of integer;
constant op_value:my_values:=(0,1,2,3,4,5,6,7);
constant a_value:my_values:=(7,4,5,6,7);
constant b_value:my_values:=(9,5,4,3,9);
 begin
uut:alu generic map(4) port map( op=>op_tb,a=>a_tb,b=>b_tb,y=>y_tb,
                                  z_flag=>z_tb,n_flag=>n_tb,o_flag=>o_tb);
 process 
 begin
 uut1:for i in a_value'range loop
 a_tb<=conv_std_logic_vector(a_value(i),4);
 b_tb<=conv_std_logic_vector(b_value(i),4);
 wait for 1 ns;
 uut2:for j in op_value'range loop
 op_tb<=conv_std_logic_vector(op_value(j),3);
 --assert (o_tb='0') report "overflow has occured" severity note;
 --assert (n_tb='0') report "negative result" severity note;
 --assert (z_tb='0') report "result is 0" severity note;
wait for 9  ns;
end loop uut2;
end loop uut1;
end process;
end alu_tb;

