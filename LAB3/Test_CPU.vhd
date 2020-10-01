library ieee;
use ieee.std_logic_1164.all;
use work.my_declerations.all;

entity test_cpu is
end test_cpu;

architecture st_tb of test_cpu is
component CPU is
generic( N:integer:= 16); --Here it is the no of bits
port( Din: in std_logic_vector(n-1 downto 0);
      clk,reset:in std_logic;
      output:out std_logic_vector(N-1 downto 0);
      Z_flag,N_flag,O_flag:out std_logic 
     );
end component;

signal clk_tb:std_logic:='0';
signal reset_tb:std_logic;
signal Din_tb:std_logic_vector(15 downto 0):=X"0000";
signal output_tb:std_logic_vector(15 downto 0);
signal z_tb,N_tb,o_tb:std_logic;
constant period:time:=10 ns;

 begin
 uut:cpu generic map(16) port map(din=>din_tb,clk=>clk_tb,reset=>reset_tb,output=>output_tb,
                                 z_flag=>z_tb,n_flag=>n_tb,o_flag=>o_tb);
     clk_proc: process is
	begin
	loop
	wait for (period/2);
	clk_tb<=not(clk_tb);
	end loop;
      end process clk_proc;
process
begin
reset_tb<='1';
wait for 20 ns;
reset_tb<='0';
wait;
end process;
end st_tb;