library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cordic_tb is
end cordic_tb;

architecture Behavioral of cordic_tb is
	component cordic is
		Port (
			angle_in: in signed(31 downto 0);
			posToNeg: out std_logic
		);
	end component;

	signal angle_in: signed(31 downto 0);
	signal posToNeg: std_logic;
begin
	uut_cordic: cordic
		Port map (
			angle_in => angle_in,
			posToNeg => posToNeg
		);
	
	process
	begin
		angle_in <= signed(to_unsigned(30, 32));
		wait;
	end process;
end Behavioral;