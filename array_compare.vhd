library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity PE is
	Port (eq_i,gt_i,x,y: in std_logic;
		eq_o,gt_o : out std_logic
		);
end PE;
architecture Behavioral of PE is
begin
process(eq_i,gt_i,x,y)
begin
if eq_i ='1' then
	if x='1' and y='0' then eq_o <='0'; gt_o <='1';
	elsif x='0' and y='1' then eq_o <='0'; gt_o <='0';
	else eq_o <='1' ; gt_0='0';
	end if;
else 
	eq_o <= eq_i; gt_o <= gt_i;
end if;
end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_cmp is
generic(n: natural := 4);
	Port (x,y : n std_logic_vectore(n-1 downto 0);
		eq,gt: out std_logic
		);
end array_cmp;

architecture struc of array_cmp is
component PE
	Port (eq_i, gt_i,x,y: in std_logic;
		eq_o,gt_o: out std_logic
		);
end component;

signal w_eq, w_gt: std_logic_vector(n-1 downto 0);
begin 
w_eq(n-1) <= '1' ; w_gt(n-1) <= '0';
G1: for i in n-1 downto 0 generate
	G2: if i>0 generate
		node: PE port map (w_eq(i),w_gt(i),x(i),y(i),
				   w_eq(i-1),w_gt(i-1));
	end generate G2;
	G3: if i=0 generate
	 node: node: PE port map (w_eq(i),w_gt(i),x(i),y(i),
				   EQ,GT);
	end generate G3;
end generate G1;
end struc;