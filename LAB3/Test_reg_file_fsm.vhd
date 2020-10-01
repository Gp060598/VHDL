library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
entity reg_test_trial is
end reg_test_trial;

architecture test_bench_trial of reg_test_trial is
component reg_file is
generic( M:integer:=3;
         N:integer:=16);
port( wd:in std_logic_vector(N-1 downto 0);
      waddr,ra,rb:in std_logic_vector(M-1 downto 0);
      wren,reada,readb,reset:in std_logic;
      clk:in std_logic;
      Qa,Qb:out std_logic_vector(N-1 downto 0)
     );
end component;
signal wd_tb,Qa_tb,Qb_tb:std_logic_vector(15 downto 0);
signal waddr_tb,ra_tb,rb_tb:std_logic_vector(2 downto 0);
signal wren_tb,reada_tb,readb_tb,reset_tb:std_logic;
signal clk_tb:std_logic:='0';
type value_array is array(integer range <>) of integer;
--constant value_data:value_array:=(3,5);
--constant value_b:std_logic_vector:="1010";
constant period:time:=100 ns;
--constant waddr_value:value_array:=(0,1);
--constant ra_value:std_logic:='0';
--constant rb_value:std_logic:='1';
begin
uut: reg_file generic map(3,16) port map(wd=>wd_tb,
                                        waddr=>waddr_tb,
                                        ra=>ra_tb,
                                        rb=>rb_tb,
                                        wren=>wren_tb,
                                        reada=>reada_tb,
                                        readb=>readb_tb,
                                        reset=>reset_tb,
                                        clk=>clk_tb,
                                        qa=>qa_tb,
                                         qb=>qb_tb);
clk_gen: process
 begin
 loop
 wait for (period/2);
 clk_tb<=not(clk_tb);
end loop;

--clk=not(clk) after period/2;

end process clk_gen;
--wren_tb<='1', '0' after 200 ns;
--reada_tb<='1' after 200 ns;
--readb_tb<='1' after 200 ns;

   write_data_1:process
   begin
      --if(rising_edge(clk_tb) and wren_tb='1') then
      wait until (rising_edge(clk_tb));
      wren_tb<='1';                              --write data first(first data in at 0ns and 2nd in at 100ns and then read both the data
      waddr_tb<="000";
      wd_tb<="0000000000000101";
      wait for 100 ns;
     wait on clk_tb until clk_tb='1'; --until (rising_Edge(clk_tb));
      wren_tb<='1';
      waddr_tb<="001";
      wd_tb<="0000000000001010";
      --end if;
      wren_tb<='0' after 200 ns;
      wait;
   end process write_data_1;

read_data:process
begin
--wait for 200 ns;
--if(rising_Edge(clk_tb)) then
reada_tb<='0';
readb_tb<='0';
ra_tb<="000";
rb_tb<="001";
wait for 200 ns;
wait on clk_tb until clk_tb='1'; -- until (rising_edge(clk_tb));
reada_tb<='1';
readb_tb<='1';
--ra_tb<="000";
--rb_tb<="001";
--wait for 300 ns;
--wait until rising_edge(clk_tb);
--ra_tb<="000";
--rb_tb<="001";
--end if;
wait;
end process read_data;
end test_bench_trial;

