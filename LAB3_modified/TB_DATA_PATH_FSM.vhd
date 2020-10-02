library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity test_d is
end test_d;

architecture data_test of test_d is
component data_way is
generic(M:integer:=3;
        N:integer:=16);
port( --Input:in std_logic_vector(N-1 downto 0);
      Reset,clk_main,ie,oe,Write_en,reada,readb:in std_logic;
      Waddr:in std_logic_Vector(M-1 downto 0);
      Ra,Rb:in std_logic_vector(M-1 downto 0); 
      Output:out std_logic_vector(N-1 downto 0);
      Op:in std_logic_vector(2 downto 0);
      en:in std_logic;
      Z_flag,n_flag,o_flag:out std_logic
     );
end component;
signal input_tb:std_logic_vector(15 downto 0);
signal reset_tb,ie_tb,oe_tb,wren_tb,reada_tb,readb_tb,en_tb: std_logic;
signal clk_tb,clk_div: std_logic:='0';
signal waddr_tb,ra_tb,rb_tb:std_logic_Vector(2 downto 0);
signal output_tb:std_logic_vector(15 downto 0);
signal op_tb:std_logic_vector(2 downto 0);
signal z_tb,n_tb,o_tb:std_logic;
constant period:time:=20 ns;
signal tmp:std_logic:='0';
Signal count:integer:= 1;
begin
clk_pro:process
 begin
 loop
 wait for (period/2);
 clk_tb<=not(clk_tb);
 end loop;
end process clk_pro;
c:process(clk_tb) is
begin
if(rising_Edge(clk_tb)) then
 count<=count+1;
 if(count=2) then
 tmp<=not(tmp);
 count<=1;
end if;
end if;
end process c;
clk_div<=tmp;

 uut:data_way generic map(3,16) 
               port map(--input=>input_tb,
                        Reset=>reset_tb,
                        clk_main=>clk_tb, 
                        ie=>ie_tb,  
                        oe=>oe_tb,
                        write_en=>wren_tb,
                        reada=>reada_tb,
                        readb=>readb_tb,  
                        waddr=>waddr_tb,
                        ra=>ra_tb,rb=>rb_tb, 
                        Output=>output_tb,
                        en=>en_tb,
                        op=>op_tb,
                        z_flag=>z_tb,n_flag=>n_tb,o_flag=>o_tb  );
simu:process
begin
reset_tb<='1';
reada_tb<='1';
readb_tb<='1';
ie_tb<='1';
oe_tb<='1';
en_tb<='1';
wren_tb<='0';
--reada_tb<='1';
--readb_tb<='1';
waddr_tb<="001";
ra_tb<="000";
rb_tb<="001";
input_tb<="0000000000000001";
op_tb<="000";
wait for 30 ns;
reset_tb<='0';
wren_tb<='1';
wait on clk_div until clk_div<='1';
ie_tb<='0';
waddr_tb<="000";
wait on clk_div until clk_div<='1';
wait;
end process simu;
end data_test;
