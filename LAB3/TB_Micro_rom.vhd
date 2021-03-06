library ieee;
use ieee.std_logic_1164.all;
use work.my_declerations.all;

entity TB_ROM is
end TB_ROM;

Architecture Structure_TB_ROM of TB_ROM is
component micro_rom is
port(inst: in operation;
     flag:in std_logic;
     upc:in std_logic_vector(1 downto 0);
     reset:in std_logic;
     wren,reada,readb:out std_logic;
     uinst: out opcode;
     bypass:out std_logic_vector(2 downto 0);
     address_en,data_en:out std_logic
     );
end component;
component FSM is
  port(instr: IN operation;
    clk,reset : IN std_logic;
    state: OUT std_logic_vector(3 downto 0);
    PC_out: OUT std_logic_vector(1 downto 0));
end component;
type pass is array(integer range<>) of operation;
constant pass_in:pass:=(add_c,sub_C,and_c);
signal instr:operation;
signal reset:std_logic;
signal state:std_logic_vector(3 downto 0);
signal Upc:std_logic_vector(1 downto 0);
signal wren,reada,readb:std_logic;
signal uinst:opcode;
signal flag:std_logic;
signal bypass:std_logic_vector(2 downto 0);
signal address_en,data_en:std_logic;
constant period:time:=100 ns;
signal clk_tb:std_logic:='0';
  begin
  clk_proc:process
  begin
  loop
  wait for period/2;
  clk_tb<=not(clk_tb);
  end loop;
  end process clk_proc;
 uut1:fsm port map(instr=>instr,clk=>clk_tb,reset=>reset,state=>state, pc_out=>upc);
uut2: micro_rom port map(inst=>state,flag=>flag,upc=>upc,reset=>reset,wren=>wren,
                          reada=>reada,readb=>readb,uinst=>uinst,bypass=>bypass,
                          address_en=>address_en, data_en=>data_en);
input_simu: process 
begin
reset<='1';
flag<='0';
wait for 10 ns;
reset<='0';
for i in pass_in'range loop
instr<=pass_in(i);
--reset<='1';
--flag<='0';
--wait for 10 ns;
--wait on clk_tb until clk_tb<='1';
--reset<='0';
--wait on clk_tb until clk_tb<='1';
wait for 250 ns;
end loop;
wait;
end process input_simu;
end Structure_TB_ROM;

   