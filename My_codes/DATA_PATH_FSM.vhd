library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use work.my_declerations.all;
entity data_way is
generic(M:integer:=3;
        N:integer:=16);
port( --Input:in std_logic_vector(N-1 downto 0);
      Ins:in instruction; --feed the instruction to the datapath
      offset,Din:in std_logic_vector(N-1 downto 0);
      Bypass:in std_logic_vector(2 downto 0);
      address_en,data_en:in std_logic;
      --Reset goes with the instruction
      clk:in std_logic;
       --ie,oe,Write_en:in std_logic; goes with the instruction
      Write_en,reada,readb:inout std_logic;               --
      --Waddr:in std_logic_Vector(M-1 downto 0); --
  --    Ra,Rb:in std_logic_vector(M-1 downto 0); --
     -- Output:out std_logic_vector(N-1 downto 0);
      Op:in std_logic_vector(2 downto 0);
      --en:in std_logic; goes with the instrcution
      Z_flag,n_flag,o_flag:out std_logic;
      address,data:out std_logic_vector(N-1 downto 0)
     );
end data_way;
architecture structure of data_way is
--Constant Input:std_logic_vector:="0000000000000001";
Signal Qa_in,Qb_in,sum_in,mux,mux_A,mux_b:std_logic_vector(N-1 downto 0);
signal waddr,ra,rb:std_logic_vector(M-1 downto 0);
--signal write_en,reada,readb:std_logic;
signal Zfl,nfl,ofl:std_logic;
	component reg_file is
	generic( M:integer:=3;
         N:integer:=16);
	port( wd:in std_logic_vector(N-1 downto 0);
      waddr,ra,rb:in std_logic_vector(M-1 downto 0);
      wren,reada,readb,reset:in std_logic;
      clk:in std_logic;
      Qa,Qb:out std_logic_vector(N-1 downto 0));
	end component;
	component alu is
	generic(N:integer:=16);
	port( op:in std_logic_vector(2 downto 0);
      a,b:in std_logic_vector(N-1 downto 0);
      y:out std_logic_vector(N-1 downto 0);
      z_flag,n_flag,o_flag:out std_logic;
      en,reset:in std_logic);
	end component;
 begin
          bypass_mux:process(clk,ins,bypass,address_en,data_en) is
	Begin
	if(bypass(0)='1') then --bypass w;
        	write_en<='1';
                waddr<="111";
                mux<=sum_in;
        else
               waddr<=ins.wreg;
               write_en<='1';
        end if;
        if(bypass(1)='1') then --bypass A
                 mux_a<=Din;
                 else
                 mux_a<=qa_in;
        end if;
        if (bypass(2)='1') then --bypass B
                mux_b<=offset;
                reada<='1';
                ra<="111";
              else
               mux_b<=qb_in;
                ra<=ins.ra ;
                reada<=ins.reada;
         end if;
         readb<=ins.readb;
         rb<=ins.rb; 
    	if(rising_Edge(clk)) then
          if(ins.oe='0') then
            address<=(others=>'0');
            data<=(others=>'0');
            z_flag<='1';
            n_flag<='0';
            o_flag<='0';
           else 
            if(address_en='1') then Address<=Sum_in;
       	        elsif(data_en='1') then data<=sum_in;
                 z_flag<=zfl;
                 n_flag<=nfl;
                 o_flag<=ofl;
               end if;
           end if;
         end if; 
	end process bypass_mux; 
	u1:reg_file generic map(3,16) port map(wd=>mux,waddr=>waddr,wren=>write_en,reada=>reada,readb=>readb,ra=>ra,rb=>rb,reset=>ins.reset,clk=>clk,Qa=>qa_in,Qb=>qb_in);
	u2:alu generic map(16) port map(op=>Op,A=>mux_A,B=>mux_b,en=>ins.alu_en,reset=>ins.reset,Y=>sum_in,z_flag=>zfl,n_flag=>nfl,o_flag=>ofl);
end structure;

