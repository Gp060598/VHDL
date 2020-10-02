library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity alu_testing is
generic(N:integer:=16);
port( op:in std_logic_vector(2 downto 0);
      a,b:in std_logic_vector(N-1 downto 0);
      y:OUT std_logic_vector(N-1 downto 0);
      z_flag,n_flag,o_flag:OUT std_logic;
      en,reset:in std_logic
    
     );
end alu_testing;

architecture alu_structure_testing of alu_testing is
signal temp:std_logic_vector(N downto 0);
signal overflow:std_logic_vector(2 downto 0);
--signal y_in:std_logic_vector(N-1 downto 0);
--signal z_in,o_in,n_in:std_logic;
begin
m:process(op,a,b,reset,en,temp,overflow) is
 begin
 if(reset='1')then
 temp<=(others=>'0');
elsif(en='1')then
  case(op) is
  when "000"=> temp<=('0'&a)+('0'&b);
                overflow<=a(n-1)&b(n-1)&temp(n-1);
  when "001"=> temp<=('0'&a)-('0'&b);
               overflow<=a(n-1)&b(n-1)&temp(n-1);
              
  when "010"=> temp<= '0'&(a and b);
               
  when "011"=> temp<='0'&(a or b);
                
  when "100"=> temp<= '0'&(a xor b);
                 
  when "101"=> temp<='0'& b;  --(not(a));
                  
  when "110"=> temp<='0'& a;

  when others=> temp<=('0'&a)+ 1; --"00000000000000001"; 
  end case;
end if;
if(op="000") then
 if(overflow="001" or overflow="110") then o_flag<='1';
 else o_flag<='0'; end if;
elsif(op="001") then
 if(overflow="011" or overflow="100") then o_flag<='1';
 else o_flag<='0'; end if;
else o_flag<='0';
end if;
end process m;
--overflow<=a(n-1)&b(n-1)&temp(n-1);
y<=temp(n-1 downto 0);
z_flag<='1' when (temp(n-1 downto 0)="000") else '0';
n_flag<='1' when temp(n-1)='1' else '0';--(temp(3)='1') else '0';
--o_flag<='1' when(overflow="001" or overflow="110" or overflow="011" or overflow="100") else '0';
--o_flag<='1' when (temp(n)='1')else '0';--(temp(4)='1') else '0';

--y<="0000" when reset='1' else
    --y_in when en='1' else "ZZZZ";
--z_flag<=z_in when en='1' else '0';
--n_flag<=n_in when en='1' else '0';
--o_flag<=o_in when en='1' else '0';
end alu_structure_testing;
