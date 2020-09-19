library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity data_way is
generic(M:integer:=3;
        N:integer:=4);
port( --Input:in std_logic_vector(N-1 downto 0);
      Reset,clk_main,ie,oe,Write_en,reada,readb:in std_logic;
      Waddr:in std_logic_Vector(M-1 downto 0);
      Ra,Rb:in std_logic_vector(M-1 downto 0); 
      Output:out std_logic_vector(N-1 downto 0);
      Op:in std_logic_vector(2 downto 0);
      en:in std_logic;
      Z_flag,n_flag,o_flag:out std_logic
     );
end data_way;
architecture structure of data_way is
Constant Input:std_logic_vector:="0001";
Signal Qa_in,Qb_in,sum_in,mux:std_logic_vector(N-1 downto 0);
signal clk_out,clk_in:std_logic;
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
component alu is
generic(N:integer:=4);
port( op:in std_logic_vector(2 downto 0);
      a,b:in std_logic_vector(N-1 downto 0);
      y:out std_logic_vector(N-1 downto 0);
      z_flag,n_flag,o_flag:out std_logic;
      en,reset:in std_logic
    
     );
end component;
component DIVIDER is
port( clk_in:in std_logic;
     clk_out:out std_logic);
end component;
begin
mux<=Input when ie='1' else sum_in;
 --Mux_pro:process(ie,Input,Sum_in) is
 --begin
 --if(ie='1') then mux<=input;
 --else mux<=sum_in;
 --end if;
--end process Mux_pro;
u0:divider port map(clk_in=>clk_main, clk_out=>clk_out);
u1:reg_file generic map(3,4) port map(wd=>mux,waddr=>waddr,wren=>write_en,reada=>reada,readb=>readb,ra=>ra,rb=>rb,reset=>reset,clk=>clk_out,Qa=>qa_in,Qb=>qb_in);
u2:alu generic map(4) port map(op=>Op,A=>qa_in,B=>qb_in,en=>en,reset=>reset,Y=>sum_in,z_flag=>z_flag,n_flag=>n_flag,o_flag=>o_flag);

Output<=sum_in when oe='1' else
       (others=>'0') when reset='1' else
       (others=>'Z');
end structure;
