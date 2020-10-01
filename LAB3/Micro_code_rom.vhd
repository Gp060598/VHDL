 
use work.my_declerations.all;
library ieee;
use ieee.std_logic_1164.all;
entity micro_rom is
port(inst: in operation;
     flag:in std_logic;
     upc:in std_logic_vector(1 downto 0);
     reset:in std_logic;
     wren,reada,readb:out std_logic;
     uinst: out opcode;
     bypass:out std_logic_vector(2 downto 0);
     address_en,data_en:out std_logic
     );
end micro_rom;

architecture m_rom of micro_rom is
begin
rom:process(inst,flag,upc,reset) is
 begin
 if(reset='1') then
 wren<='0';
 reada<='0';
 readb<='0';
 uinst<=add_a;
 bypass<="000";
 address_en<='0';
 data_en<='0';
 else
 wren<='0';
 reada<='0';
 readb<='0';
 uinst<=add_a;
 bypass<="000";
 address_en<='0';
 data_en<='0'; 
end if;
 	case(inst) is
	 	when add_C=>
			if (upc="01") then     --do the corresponding alu op
			uinst<=add_a;
			wren<='1';
			reada<='1'; readb<='1';
			data_en<='1';
			elsif(upc="10") then  --incr the program counter
			uinst<=incr_a;
			wren<='1';
			bypass<="101";
			address_en<='1';
			end if;
		when sub_C=>
			if (upc="01") then
			uinst<=sub_a;
			wren<='1';
			reada<='1'; readb<='1';
			wren<='1';
			data_en<='1';
			elsif(upc="10") then
			uinst<=incr_a;
			wren<='1';
			bypass<="101";
			address_en<='1';
			end if;
		when and_C=>
			if (upc="01") then
			uinst<=and_a;
			wren<='1';
			reada<='1'; readb<='1';
			--wren<='1';
			data_en<='1';
			elsif(upc="10") then
			uinst<=incr_a;
			wren<='1';
                        bypass<="101";
			address_en<='1';
			end if;
                when or_C=>
			if (upc="01") then
			uinst<=or_a;
			reada<='1'; readb<='1';
			wren<='1';
			data_en<='1';
			elsif(upc="10") then
			uinst<=incr_a;
			wren<='1';
			bypass<="101";
			address_en<='1';
			end if;
                 when xor_C=>
			if (upc="01") then
			uinst<=xor_a;
			wren<='1';
			reada<='1'; readb<='1';
			--wren<='1';
			data_en<='1';
			elsif(upc="10") then
			uinst<=incr_a;
			wren<='1';
			bypass<="101";
			address_en<='1';
			end if;
                  when not_C=>
			if (upc="01") then
			uinst<=movb_a;
			reada<='1'; --readb<='1';
			wren<='1';
			data_en<='1';
			elsif(upc="10") then
			uinst<=incr_a;
			wren<='1';
			bypass<="101";
			address_en<='1';
			end if;
                  when mov_C=>
			if (upc="01") then
			uinst<=mov;
			reada<='1'; --readb<='1';
			wren<='1';
			data_en<='1';
			elsif(upc="10") then
			uinst<=incr_a;
			wren<='1';
			bypass<="101";
			address_en<='1';
			end if;
                   when nop_C=>
			if(upc="01") then
			uinst<=incr_a;
			wren<='1';
			bypass<="101";
			address_en<='1';
			end if;
                   when LD_c =>
                    if uPC = "01" then
		        uinst <= Mov;
		        reada <= '1';
		        address_en <= '1';
		    elsif uPC = "10" then
		        uinst <= Mov;
		        reada <= '1';
		        wren <= '1';
	                data_en <= '1';
	            elsif uPC = "11" then
	                uinst <= Incr_A;
	                wren <= '1';
	                bypass <= "101";
	                address_en <= '1';
		      end if;
    
		    when ST_c =>
		      if uPC = "01" then
		      uinst <= Mov;
	              reada <= '1';
	              address_en <= '1';
	             elsif uPC = "10" then
	               uinst <= Movb_a;
	               readb <= '1';
	                wren <= '1';
	               data_en <= '1';
	             elsif uPC = "11" then
	                uinst <= Incr_a;
	                wren <= '1';
	                bypass <= "101";
	                address_en <= '1';
		      end if;
                    when LDI_C=>
			if (upc="01") then
                        bypass<="010";
			uinst<=mov;
			wren<='1';
			data_en<='1';
			elsif(upc="10") then
			uinst<=incr_a;
			wren<='1';
			bypass<="101";
			address_en<='1';
			end if;
                     when Not_used=>
			if(upc="01") then
			uinst<=incr_a;
			wren<='1';
			bypass<="101";
			address_en<='1';
			end if;
                     when BRZ|BRO|BRN=>
 			if (upc="01") then
		 	 if(flag='1') then
			  uinst<=add_a;
                         else uinst<=incr_A;
                          end if;
			reada<='1'; 
                        bypass<="101";
			wren<='1';
			address_en<='1';
			end if;  
                     when BRA=>
			if(upc="01") then
			uinst<=add_a;
			wren<='1';
                        reada<='1';
			bypass<="101";
			address_en<='1';
			end if;
when others=> report "invalid instruction";
end case;
end process rom;
end m_rom;