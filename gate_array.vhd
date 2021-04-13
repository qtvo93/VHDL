library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gate_array is
generic (n: natural := 8);
 Port (x : in std_logic_vector(n-1 downto 0);
 z : out std_logic;
 sel: in std_logic_vector(1 downto 0) );
end gate_array;
architecture struc of gate_array is
component u_gate
	Port (x,y: in std_logic;
		z: out std_logic;
		sel: in std_logic_vector(1 downto 0));
end component;

begin
if sel ="00" then
G1: for i in n-1 downto 0 generate
	G2: if i>0 generate
		U: u_gate port map (x(i-1),x(i-1),z(i-1));
				  
	end generate G2;
	G3: if i=0 generate
	 U: u_gate port map (x(0),y(0),z(0));
	end generate G3;
end generate G1;
end if;
end struc;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity u_gate is
 Port (x, y : in std_logic;
 z : out std_logic;
 sel: in std_logic_vector(1 downto 0) );
end u_gate;

architecture beh of u_gate is
begin
process(x, y, sel)
begin
case sel is
    when "00" =>
    z <= x and y;
    when "01" =>
    z <= x or y;
    when "10" =>
    z <= x xor y;
    when others => 
    z <= '1';
 end case;
end process;
end beh;
