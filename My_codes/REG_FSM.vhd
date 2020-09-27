library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity reg_file is
generic( M:integer:=3;
         N:integer:=16);
port( wd:in std_logic_vector(N-1 downto 0);
      waddr,ra,rb:in std_logic_vector(M-1 downto 0);
      wren,reada,readb,reset:in std_logic;
      clk:in std_logic;
      Qa,Qb:out std_logic_vector(N-1 downto 0)
     );
end reg_file;

architecture reg of reg_file is
type reg_array is array((2**M)-1 downto 0) of std_logic_vector(N-1 downto 0);
signal r:reg_array;
--signal qa_tmp,qb_tmp:std_logic_vector(N-1 downto 0);
begin
process(clk,wren,wd,reset) is
 begin
 if(reset='1') then 
  r<=(others=>(others=>'0'));
 elsif(rising_edge(clk)) then
  if(wren='1') then
  r(conv_integer(unsigned(waddr)))<=wd;
  end if;
end if;
end process;
  qa<=r(conv_integer(unsigned(ra))) when reada<='1' else (others=>'0');
  qb<=r(conv_integer(unsigned(rb))) when readb<='1' else (others=>'0');
--qa<=(others=>'0') when reset='1' else qa_tmp;
--qb<=(others=>'0') when reset='1' else qb_tmp;
end reg;

