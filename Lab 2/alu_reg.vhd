library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity alu is
generic(N:integer:=4);
port( op:in std_logic_vector(2 downto 0);
      a,b:in std_logic_vector(N-1 downto 0);
      y:OUT std_logic_vector(N-1 downto 0);
      z_flag,n_flag,o_flag:OUT std_logic;
      en,reset:in std_logic
    
     );
end alu;

architecture alu_structure of alu is
signal temp:std_logic_vector(N downto 0);
--signal y_in:std_logic_vector(N-1 downto 0);
--signal z_in,o_in,n_in:std_logic;
begin
m:process(op,a,b,reset,en) is
 begin
 if(reset='1')then
 temp<="00000";
elsif(en='1')then
  case(op) is
  when "000"=> temp<=('0'&a)+('0'&b);
  when "001"=> temp<=('0'&a)-('0'&b);
              
  when "010"=> temp<= '0'&(a and b);
               
  when "011"=> temp<='0'&(a or b);
                
  when "100"=> temp<= '0'&(a xor b);
                 
  when "101"=> temp<='0'&(not(a));
                  
  when "110"=> temp<='0'& a;

  when others=> temp<="00000"; 
  end case;
end if;
end process m;
y<=temp(n-1 downto 0);
z_flag<='1' when (temp(n-1 downto 0)="000") else '0';
n_flag<='1' when temp(n-1)='1' else '0';
o_flag<='1' when(temp(n)='1')else '0';

--y<="0000" when reset='1' else
    --y_in when en='1' else "ZZZZ";
--z_flag<=z_in when en='1' else '0';
--n_flag<=n_in when en='1' else '0';
--o_flag<=o_in when en='1' else '0';
end alu_structure;
