library ieee;
use ieee.std_logic_1164.all;
use work.my_declerations.all;
use ieee.std_logic_arith.all;

entity fake_memory is
generic(N:integer:=16);
port(address:in std_logic_vector(7 downto 0);
     data:in std_logic_vector(n-1 downto 0);
     wren,clk:in std_logic;
     q:out std_logic_vector(n-1 downto 0)
     );
end fake_memory;

architecture structure_fake of fake_memory is
signal RAM:program(0 to 255):=(
				(LDI_C & reg5 & B"1_0000_0000"),
				(ADD_C & reg5 & reg5 & reg5 &NU3),
				(ADD_C & reg5 & reg5 & reg5 &NU3),
				(ADD_C & reg5 & reg5 & reg5 &NU3),
				(ADD_C & reg5 & reg5 & reg5 &NU3),
				(LDI_C & reg6 & B"0_0010_0000"),
				(LDI_C & reg3 & B"0_0000_0011"),
				(ST_C  & NU3  & reg6 & reg3 & nu3),
				(LDI_C & REG1 & B"0_0000_0001"),
				(LDI_C & reg0 & B"0_0000_1110"),
				(MOV_C & REG2 & reg0 & NU3 & NU3),
				(ADD_c & reg2 & reg2 & reg1 &nu3),
				(SUB_C & reg0 & reg0 & reg1 & NU3),
				(BRZ & X"003"),
				(NOP_C & NU3 & NU3 & NU3 & NU3),
				(BRA & X"FFC"),
				(ST_c & NU3 & Reg6 & Reg2 & NU3),
				(BRA & X"000"),
                                others=>(NOP_C & NU3 & NU3 & NU3 & NU3));
begin
       process(clk) is
	begin

	if(rising_edge(clk) and wren='1') then
	 Ram(conv_integer(unsigned(address)))<=data;
        end if;
       end process;
      q<=Ram(conv_integer(unsigned(address))) when wren='0' else (others=>'0');
end structure_fake;
				