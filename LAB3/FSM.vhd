   library IEEE;
use IEEE.std_logic_1164.all;

use work.my_declerations.all;

entity sm_trial is
  port(instr: IN operation;
    clk,reset : IN std_logic;
    state: OUT std_logic_vector(3 downto 0);
    PC_out: OUT std_logic_vector(1 downto 0));
end sm_trial;

architecture structure of SM_trial is
  
  --signals
  signal uPC,next_uPC : std_logic_vector(1 downto 0);
  --signal test:std_logic;
begin
  sync:process(clk,reset) is   --present state logic
  begin
 	if(reset='1') then upc<="00";
       elsif(rising_edge(clk)) then upc<=next_upc;
      
       --test<='1';
        end if;
 end process sync;

comb: process(upc,instr) is    --nextstate logic
 begin
 state<=instr;
 pc_out<=upc;
  case(instr) is
  when add_c=> 
              if(upc="00") then 
		next_upc<="01";
              state<=instr; 
              elsif(upc="01") then next_upc<="10";
              else next_upc<="00";
             end if;
 when sub_c=> state<=instr;
              if(upc="00") then next_upc<="01";
              elsif(upc="01") then next_upc<="10";
              else next_upc<="00";
             end if;
when others=> report"invalid";
end case;
end process comb;
end structure ;