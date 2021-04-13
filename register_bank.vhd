----------------------------------------------------------------------------------
Register Bank 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity reg_bank is
port(   x: in std_logic_vector(3 downto 0);
        btns: in std_logic_vector(3 downto 0);
        z : out std_logic_vector(7 downto 0);
        disp_en: out std_logic_vector(3 downto 0);
        ck, reset: in std_logic);
end reg_bank ;

architecture Behavioral of reg_bank  is
signal r0,r1,r2,r3: std_logic_vector(3 downto 0);
Type my_state is (s0,s1,s2,s3);
Signal n_s: my_state;
Signal ck_div: std_logic;
signal sw_sel: std_logic_vector(0 to 3);
begin

process(ck)
begin
if ck='1' and ck'event then
case btns is
    when "1000" => R0 <= x;
    when "0100" => R1 <= x;
    when "0010" => R2 <= x;
    when "0001" => R3 <= x;
    when others => null;
end case;
end if;
end process;

process(sw_sel,r0,r1,r2,r3)
variable temp: std_logic_vector(3 downto 0);
begin
case sw_sel is
     when "1000" => temp := r0;
     when "0100" => temp := r1;
     when "0010" => temp := r2;
     when "0001" => temp := r3;
     when others => temp:= "0000";
 end case;
 
case temp is 
    when "0000" => z <= "00000011";
    when "0001" => z <= "10011111";
    when "0010" => z <= "00100101";
    when "0011" => z <= "00001101";
    when "0100" => z <= "10011001";
    when "0101" => z <= "01001001";
    when "0111" => z <= "00011111";
    when "1000" => z <= "00000001";
    when "1001" => z <= "00001001";
    when "1010" => z <= "00010001";
    when "1011" => z <= "11000001";
    when "1100" => z <= "01100011";
    when "1101" => z <= "10000101";
    when "1110" => z <= "01100001";
    when "1111" => z <= "01110001";
    when others => null;
    end case;
end process;

Process(ck_div)
Begin
if ck_div'event and ck_div='1' then
Case n_s is
When s0 => sw_sel <= "1000";disp_en <= "0111";n_s <= s1;
When s1 => sw_sel <= "0100";disp_en <= "1011";n_s <= s2;
When s2 => sw_sel <= "0010";disp_en <= "1101";n_s <= s3;
When s3 => sw_sel <= "0001";disp_en <= "1110";n_s <= s0;
End case;
End if;
End process;

process(ck)
variable count : integer;
begin
if ck = '1' and ck'event then
    if reset = '1' then
        count := 0;
        ck_div <= '0';
    elsif reset ='0' then
        if count = 99999 then
            ck_div <= not ck_div;
            count:= 0;
         else
            count := count +1;
         end if;
     end if;
 end if;
 end process;
 
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity reg_v1 is
port ( x : in std_logic_vector(1 downto 0);
       LEDS: out std_logic_vector(7 downto 0);
       btns: in std_logic_vector(3 downto 0);
       ck: in std_logic);
end reg_v1;
architecture beh of reg_v1 is
signal r0,r1,r2,r3: std_logic_vector(1 downto 0);
begin 
LEDS(7 downto 6) <= R3;
LEDS(5 downto 4) <= R2;
LEDS(3 downto 2) <= R1;
LEDS(1 downto 0) <= R0; 
process(ck)
begin
if ck ='1' and ck'event then
case btns is
    when "1000" => R0 <= x;
    when "0100" => R1 <= x;
    when "0010" => R2 <= x;
    when "0001" => R3 <= x;
    when others => null;
end case;
end if;
end process;
end beh;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;          
entity reg_v2 is
port ( SW : in std_logic_vector(7 downto 0);
       z: out std_logic_vector(7 downto 0);
       btns: in std_logic_vector(3 downto 0);
       disp_en: out std_logic_vector(3 downto 0));
end reg_v2;
architecture beh of reg_v2 is
begin 
process(SW,btns)
variable temp: std_logic_vector(1 downto 0);
begin
case btns is
    when "1000" => temp := SW(7 downto 6); disp_en <= "0111";
    when "0100" => temp := SW(5 downto 4); disp_en <= "1011";
    when "0010" => temp := SW(3 downto 2); disp_en <= "1101";
    when "0001" => temp := SW(1 downto 0); disp_en <= "1110";
    when others => temp := "00"; disp_en <= "1111";
end case;
case temp is
    when "00" => z <= "00000011";
    when "01" => z <= "10011111";
    when "10" => z <= "00100101";
    when "11" => z <= "00001101";
    when others => null;
end case;
end process;
end beh;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;          
entity reg_v3 is
port (  SW : in std_logic_vector(7 downto 0);
        z : out std_logic_vector(7 downto 0);
        disp_en: out std_logic_vector(3 downto 0);
        ck,reset:in std_logic);
         
end reg_v3;
architecture beh of reg_v3 is
Type my_state is (s0,s1,s2,s3);
Signal n_s: my_state;
Signal ck_div: std_logic;
signal sw_sel: std_logic_vector(0 to 3);
begin 
process(sw_sel)
variable temp: std_logic_vector(1 downto 0);
begin
case sw_sel is 
    when "1000" => temp := SW(7 downto 6); 
    when "0100" => temp := SW(5 downto 4); 
    when "0010" => temp := SW(3 downto 2); 
    when "0001" => temp := SW(1 downto 0); 
    when others => temp := "00";
end case;
case temp is
    when "00" => z <= "00000011";
    when "01" => z <= "10011111";
    when "10" => z <= "00100101";
    when "11" => z <= "00001101";
    when others => null;
end case;
end process;

Process(ck_div)
Begin
if ck_div'event and ck_div='1' then
Case n_s is
When s0 => sw_sel <="1000";disp_en <= "0111";n_s <= s1;
When s1 => sw_sel <="0100";disp_en <= "1011";n_s <= s2;
When s2 => sw_sel <="0010";disp_en <= "1101";n_s <= s3;
When s3 => sw_sel <="0001";disp_en <= "1110";n_s <= s0;
End case;
End if;
End process;

process(ck)
variable count: integer;
begin
if ck = '1' and ck'event then
    if reset = '1' then
        count := 0;
        ck_div <= '0';
     elsif reset = '0' then
        if count = 9999 then 
            ck_div <= not ck_div;
            count := 0;
        else
            count := count +1;
         end if;
     end if;
 end if;
 end process;
 end beh;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
entity reg_v4 is
 port (sw : in std_logic_vector(3 downto 0); 
    Btn: in std_logic_vector(3 downto 0);
     z : out std_logic_vector(7 downto 0);
     disp_en : out std_logic_vector(3 downto 0); 
    ck, reset: in std_logic);
end reg_v4;
 
        
---------------------------------
## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
#set_property PACKAGE_PIN W5 [get_ports clk]							
	#set_property IOSTANDARD LVCMOS33 [get_ports clk]
	#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
## Switches
#set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
#set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
#set_property PACKAGE_PIN W16 [get_ports {sw[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
#set_property PACKAGE_PIN W17 [get_ports {sw[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
#set_property PACKAGE_PIN W15 [get_ports {sw[4]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
#set_property PACKAGE_PIN V15 [get_ports {sw[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
#set_property PACKAGE_PIN W14 [get_ports {sw[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
#set_property PACKAGE_PIN W13 [get_ports {sw[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
#set_property PACKAGE_PIN V2 [get_ports {sw[8]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
#set_property PACKAGE_PIN T3 [get_ports {sw[9]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
#set_property PACKAGE_PIN T2 [get_ports {sw[10]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
#set_property PACKAGE_PIN R3 [get_ports {sw[11]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
#set_property PACKAGE_PIN W2 [get_ports {sw[12]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
#set_property PACKAGE_PIN U1 [get_ports {sw[13]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
#set_property PACKAGE_PIN T1 [get_ports {sw[14]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
#set_property PACKAGE_PIN R2 [get_ports {sw[15]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
 

## LEDs
#set_property PACKAGE_PIN U16 [get_ports {led[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
#set_property PACKAGE_PIN E19 [get_ports {led[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
#set_property PACKAGE_PIN U19 [get_ports {led[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
#set_property PACKAGE_PIN V19 [get_ports {led[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
#set_property PACKAGE_PIN W18 [get_ports {led[4]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
#set_property PACKAGE_PIN U15 [get_ports {led[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
#set_property PACKAGE_PIN U14 [get_ports {led[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
#set_property PACKAGE_PIN V14 [get_ports {led[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
#set_property PACKAGE_PIN V13 [get_ports {led[8]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
#set_property PACKAGE_PIN V3 [get_ports {led[9]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
#set_property PACKAGE_PIN W3 [get_ports {led[10]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
#set_property PACKAGE_PIN U3 [get_ports {led[11]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
#set_property PACKAGE_PIN P3 [get_ports {led[12]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
#set_property PACKAGE_PIN N3 [get_ports {led[13]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
#set_property PACKAGE_PIN P1 [get_ports {led[14]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
#set_property PACKAGE_PIN L1 [get_ports {led[15]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]
	
	
##7 segment display
set_property PACKAGE_PIN W7 [get_ports {z[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {z[7]}]
set_property PACKAGE_PIN W6 [get_ports {z[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {z[6]]}]
set_property PACKAGE_PIN U8 [get_ports {z[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {z[5]}]
set_property PACKAGE_PIN V8 [get_ports {z[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {z[4]}]
set_property PACKAGE_PIN U5 [get_ports {z[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {z[3]}]
set_property PACKAGE_PIN V5 [get_ports {z[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {z[2]}]
set_property PACKAGE_PIN U7 [get_ports {z[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {z[1]}]

set_property PACKAGE_PIN V7 [get_ports z[0]]							
	set_property IOSTANDARD LVCMOS33 [get_ports z[0]]

set_property PACKAGE_PIN U2 [get_ports {disp_en[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {disp_en[0]}]
set_property PACKAGE_PIN U4 [get_ports {disp_en[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {disp_en[1]}]
set_property PACKAGE_PIN V4 [get_ports {disp_en[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {disp_en[2]}]
set_property PACKAGE_PIN W4 [get_ports {disp_en[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {disp_en[3]}]


##Buttons
#set_property PACKAGE_PIN U18 [get_ports btnC]						
	#set_property IOSTANDARD LVCMOS33 [get_ports btnC]
set_property PACKAGE_PIN T18 [get_ports {Btns[1]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Btns[1]}]
set_property PACKAGE_PIN W19 [get_ports {Btns[2]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Btns[2]}]
set_property PACKAGE_PIN T17 [get_ports {Btns[0]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Btns[0]}]
set_property PACKAGE_PIN U17 [get_ports {Btns[3]}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {Btns[3]}]
 


##Pmod Header JA
##Sch name = JA1
#set_property PACKAGE_PIN J1 [get_ports {JA[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[0]}]
##Sch name = JA2
#set_property PACKAGE_PIN L2 [get_ports {JA[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[1]}]
##Sch name = JA3
#set_property PACKAGE_PIN J2 [get_ports {JA[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[2]}]
##Sch name = JA4
#set_property PACKAGE_PIN G2 [get_ports {JA[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[3]}]
##Sch name = JA7
#set_property PACKAGE_PIN H1 [get_ports {JA[4]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[4]}]
##Sch name = JA8
#set_property PACKAGE_PIN K2 [get_ports {JA[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[5]}]
##Sch name = JA9
#set_property PACKAGE_PIN H2 [get_ports {JA[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[6]}]
##Sch name = JA10
#set_property PACKAGE_PIN G3 [get_ports {JA[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JA[7]}]



##Pmod Header JB
##Sch name = JB1
#set_property PACKAGE_PIN A14 [get_ports {JB[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JB[0]}]
##Sch name = JB2
#set_property PACKAGE_PIN A16 [get_ports {JB[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JB[1]}]
##Sch name = JB3
#set_property PACKAGE_PIN B15 [get_ports {JB[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JB[2]}]
##Sch name = JB4
#set_property PACKAGE_PIN B16 [get_ports {JB[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JB[3]}]
##Sch name = JB7
#set_property PACKAGE_PIN A15 [get_ports {JB[4]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JB[4]}]
##Sch name = JB8
#set_property PACKAGE_PIN A17 [get_ports {JB[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JB[5]}]
##Sch name = JB9
#set_property PACKAGE_PIN C15 [get_ports {JB[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JB[6]}]
##Sch name = JB10 
#set_property PACKAGE_PIN C16 [get_ports {JB[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JB[7]}]
 


##Pmod Header JC
##Sch name = JC1
#set_property PACKAGE_PIN K17 [get_ports {JC[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[0]}]
##Sch name = JC2
#set_property PACKAGE_PIN M18 [get_ports {JC[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[1]}]
##Sch name = JC3
#set_property PACKAGE_PIN N17 [get_ports {JC[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[2]}]
##Sch name = JC4
#set_property PACKAGE_PIN P18 [get_ports {JC[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[3]}]
##Sch name = JC7
#set_property PACKAGE_PIN L17 [get_ports {JC[4]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[4]}]
##Sch name = JC8
#set_property PACKAGE_PIN M19 [get_ports {JC[5]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[5]}]
##Sch name = JC9
#set_property PACKAGE_PIN P17 [get_ports {JC[6]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[6]}]
##Sch name = JC10
#set_property PACKAGE_PIN R18 [get_ports {JC[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[7]}]


##Pmod Header JXADC
##Sch name = XA1_P
#set_property PACKAGE_PIN J3 [get_ports {JXADC[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[0]}]
##Sch name = XA2_P
#set_property PACKAGE_PIN L3 [get_ports {JXADC[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[1]}]
##Sch name = XA3_P
#set_property PACKAGE_PIN M2 [get_ports {JXADC[2]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[2]}]
##Sch name = XA4_P
#set_property PACKAGE_PIN N2 [get_ports {JXADC[3]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[3]}]
##Sch name = XA1_N
#set_property PACKAGE_PIN K3 [get_ports {JXADC[4]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[4]}]
##Sch name = XA2_N
#set_property PACKAGE_PIN M3 [get_ports {JXADC[5]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[5]}]
##Sch name = XA3_N
#set_property PACKAGE_PIN M1 [get_ports {JXADC[6]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[6]}]
##Sch name = XA4_N
#set_property PACKAGE_PIN N1 [get_ports {JXADC[7]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[7]}]



##VGA Connector
#set_property PACKAGE_PIN G19 [get_ports {vgaRed[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[0]}]
#set_property PACKAGE_PIN H19 [get_ports {vgaRed[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[1]}]
#set_property PACKAGE_PIN J19 [get_ports {vgaRed[2]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[2]}]
#set_property PACKAGE_PIN N19 [get_ports {vgaRed[3]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[3]}]
#set_property PACKAGE_PIN N18 [get_ports {vgaBlue[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[0]}]
#set_property PACKAGE_PIN L18 [get_ports {vgaBlue[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[1]}]
#set_property PACKAGE_PIN K18 [get_ports {vgaBlue[2]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[2]}]
#set_property PACKAGE_PIN J18 [get_ports {vgaBlue[3]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[3]}]
#set_property PACKAGE_PIN J17 [get_ports {vgaGreen[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[0]}]
#set_property PACKAGE_PIN H17 [get_ports {vgaGreen[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[1]}]
#set_property PACKAGE_PIN G17 [get_ports {vgaGreen[2]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[2]}]
#set_property PACKAGE_PIN D17 [get_ports {vgaGreen[3]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[3]}]
#set_property PACKAGE_PIN P19 [get_ports Hsync]						
	#set_property IOSTANDARD LVCMOS33 [get_ports Hsync]
#set_property PACKAGE_PIN R19 [get_ports Vsync]						
	#set_property IOSTANDARD LVCMOS33 [get_ports Vsync]


##USB-RS232 Interface
#set_property PACKAGE_PIN B18 [get_ports RsRx]						
	#set_property IOSTANDARD LVCMOS33 [get_ports RsRx]
#set_property PACKAGE_PIN A18 [get_ports RsTx]						
	#set_property IOSTANDARD LVCMOS33 [get_ports RsTx]


##USB HID (PS/2)
#set_property PACKAGE_PIN C17 [get_ports PS2Clk]						
	#set_property IOSTANDARD LVCMOS33 [get_ports PS2Clk]
	#set_property PULLUP true [get_ports PS2Clk]
#set_property PACKAGE_PIN B17 [get_ports PS2Data]					
	#set_property IOSTANDARD LVCMOS33 [get_ports PS2Data]	
	#set_property PULLUP true [get_ports PS2Data]


##Quad SPI Flash
##Note that CCLK_0 cannot be placed in 7 series devices. You can access it using the
##STARTUPE2 primitive.
#set_property PACKAGE_PIN D18 [get_ports {QspiDB[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[0]}]
#set_property PACKAGE_PIN D19 [get_ports {QspiDB[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[1]}]
#set_property PACKAGE_PIN G18 [get_ports {QspiDB[2]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[2]}]
#set_property PACKAGE_PIN F18 [get_ports {QspiDB[3]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[3]}]
#set_property PACKAGE_PIN K19 [get_ports QspiCSn]					
	#set_property IOSTANDARD LVCMOS33 [get_ports QspiCSn]


       
       
       
       
       
       
       
