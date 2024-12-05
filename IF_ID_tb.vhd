library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.IF_ID_signals.all;

entity IF_ID_tb is
end IF_ID_tb;

architecture Behavioral of IF_ID_tb is
	signal IF_ID_IN: IF_ID_signals;
	signal IF_ID_OUT: IF_ID_signals;
	signal clk: std_logic := '0';
	signal reset: std_logic := '1';
begin
	uut: entity work.IF_ID
		Port map (
			clk => clk,
			reset => reset,
			IF_ID_IN => IF_ID_IN,
			IF_ID_OUT => IF_ID_OUT
		);
	
	process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;
	
	process
	begin
		wait for 50 ns;
		reset <= '0';
		wait;
	end process;
	
	process
	begin
		IF_ID_IN.PC <= std_logic_vector(to_unsigned(0, 32));
		IF_ID_IN.instruction <= std_logic_vector(to_unsigned(4, 32));
		wait for 20 ns;
		IF_ID_IN.PC <= std_logic_vector(unsigned(IF_ID_IN.PC) + 1);
		IF_ID_IN.instruction <= std_logic_vector(to_unsigned(5, 32));
		wait;
	end process;
end Behavioral;