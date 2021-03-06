library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
entity reg_test is
end reg_test;

architecture test_bench of reg_test is
component reg_file is
generic( M:integer:=3;
         N:integer:=4);
port( wd:in std_logic_vector(N-1 downto 0);
      waddr,ra,rb:in std_logic_vector(M-1 downto 0);
      wren,reada,readb,reset:in std_logic;
      clk:in std_logic;
      Qa,Qb:out std_logic_vector(N-1 downto 0)
     );
end component;
signal wd_tb,Qa_tb,Qb_tb:std_logic_vector(3 downto 0);
signal waddr_tb,ra_tb,rb_tb:std_logic_vector(2 downto 0);
signal wren_tb,reada_tb,readb_tb,reset_tb:std_logic;
signal clk_tb:std_logic:='0';
type value_array is array(integer range <>) of integer;
constant value_data:value_array:=(3,5);
--constant value_b:std_logic_vector:="1010";
constant period:time:=100 ns;
constant waddr_value:value_array:=(0,1);
constant ra_value:std_logic:='0';
constant rb_value:std_logic:='1';
begin
uut: reg_file generic map(3,4) port map(wd=>wd_tb,waddr=>waddr_tb,ra=>ra_tb,rb=>rb_tb,wren=>wren_tb,reada=>reada_tb,readb=>readb_tb,reset=>reset_tb,clk=>clk_tb,qa=>qa_tb,qb=>qb_tb);
clk_gen: process
 begin
 loop
 wait for (period/2);
 clk_tb<=not(clk_tb);
end loop;
end process clk_gen;
wren_tb<='1', '0' after 200 ns;
reada_tb<='1' after 200 ns;
readb_tb<='1' after 200 ns;

write_data_1:process(clk_tb) is
begin
if(rising_edge(clk_tb)) then
for i in waddr_value'range loop
waddr_tb<=conv_std_logic_vector(waddr_value(i),3);
wd_tb<=conv_std_logic_Vector(value_data(i),4);
--wait for 100 ns;
end loop;
end if;
end process write_data_1;
--write_data_2:process(clk_tb) is
--begin
--if(rising_edge(clk_tb)) then
--for i in waddr_value'range loop
--waddr_tb<=conv_std_logic_vector(1,3);
--wd_tb<=conv_std_logic_Vector(5,4);
--wait for 100 ns;
--end loop;
--end if;
--end process write_data_2;
read_data:process(clk_tb) is
begin
--wait for 200 ns;
if(rising_Edge(clk_tb)) then
ra_tb<=conv_std_logic_vector(ra_value,3);
rb_tb<=conv_std_logic_vector(rb_value,3);
end if;
end process read_data;
end test_bench;
