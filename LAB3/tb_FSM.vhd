library IEEE;
use IEEE.std_logic_1164.all;

use work.my_declerations.all;

entity TB_sm_trial is
end TB_sm_trial;

ARCHITECTURE tb of tb_sm_trial is

component sm_trial is
  port(instr: IN operation;
    clk,reset : IN std_logic;
    state: OUT std_logic_vector(3 downto 0);
    PC_out: OUT std_logic_vector(1 downto 0));
end component;

signal instr_tb:operation;
signal reset_tb:std_logic;
signal clk_tb:std_logic:='0';
constant period:time:= 100 ns;
signal state_tb:std_logic_vector(3 downto 0);
signal pc_out_tb:std_logic_vector(1 downto 0);

begin
ut:sm_trial port map(instr=>instr_Tb, clk=>clk_tb, reset=>reset_tb,state=>state_tb,pc_out=>pc_out_tb);
clk_pro:process
 begin
 loop
 wait for (period/2);
 clk_tb<=not(clk_tb);
 end loop;
end process clk_pro;

m: process 
begin
instr_tb<="0000";
reset_tb<='1';
wait on clk_tb until clk_tb='1';
reset_tb<='0';
wait on clk_tb until clk_tb<='1';
wait;
end process m;
end tb;