library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.my_declerations.all;

entity comp is
generic(N:integer:=16);
port(clk,reset:in std_logic;
     output:out std_logic_vector(n-1 downto 0)
);

end comp;

architecture structure_comp of comp is

component CPU is
generic( N:integer:= 16); --Here it is the no of bits
port( Din: in std_logic_vector(n-1 downto 0);
      clk,reset:in std_logic;
      address_cpu,dout:out std_logic_vector(N-1 downto 0);
      Z_flag,N_flag,O_flag,R_WN:out std_logic 
     );
end component;

component GPIO is
generic(N:integer:=16);
port(din:in std_logic_vector(N-1 downto 0);
     clk,reset:in std_logic;
     dout:out std_logic_vector(N-1 downto 0);
     ie,oe:in std_logic
     );
end component;

component fake_memory is
generic(N:integer:=16);
port(address:in std_logic_vector(7 downto 0);
     data:in std_logic_vector(n-1 downto 0);
     wren,clk:in std_logic;
     q:out std_logic_vector(n-1 downto 0)
     );
end component;

component divider is
port( clk_in:in std_logic;
     clk_out:out std_logic);
end component;

 signal din,address,data:std_logic_vector(n-1 downto 0);
 signal clk_out,z_flag,n_flag,o_flag,ie,wren,out_en:std_logic;
 begin
u0:divider port map(clk_in=>clk, clk_out=>clk_out);

u1:cpu generic map(16)port map(din=>din,clk=>clk_out,reset=>reset,address_cpu=>address,
                                dout=>data,r_wn=>wren,z_flag=>z_flag,n_flag=>n_flag,o_flag=>o_flag);

u2:gpio generic map(16) port map(din=>data,reset=>reset,clk=>clk_out,dout=>output,ie=>ie,oe=>out_en);

u3: fake_memory generic map(16) port map(address=>address(7 downto 0),clk=>clk_out,
                                        wren=>wren,data=>data,q=>din);
ie<='0' when address=x"F000" else '1';
out_en<='1';

end structure_comp;