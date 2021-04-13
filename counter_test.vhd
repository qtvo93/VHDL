library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.Vcomponents.all;

entity counter_test is
	port(
	up,ck,en_cnt: IN std_logic;
	addr: OUT std_logic_vector(2 downto 0)
	);
end counter_test;

architecture struc of counter_test is
	signal sclr, threshold: std_logic;
	COMPONENT c_counter_binary_0
	port(
	CLK: IN STD_LOGIC;
	CE: IN STD_LOGIC;
	SCLR: IN STD_LOGIC;
	THRESH0 : OUT STD_LOGIC;
	Q: OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END COMPONENT;
begin
	U: c_counter_binary_0
	PORT MAP(
	CLK =>ck,
	CE => en_cnt,
	SCLR =>sclr,
	THRESH0 => threshold,
	Q=>addr
);
end struc;
