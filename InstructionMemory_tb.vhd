library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemory_tb is
end InstructionMemory_tb;


architecture Behavioral of InstructionMemory_tb is
	
	component InstructionMemory is
		Port (
			clk: in std_logic;
			addressMem: in std_logic_vector(31 downto 0);
			instructionMem: out std_logic_vector(31 downto 0)
		);
	end component;
	
	signal clk: std_logic := '0';
	signal addressMem: std_logic_vector(31 downto 0) := (others => '0');
	signal instructionMem: std_logic_vector(31 downto 0);
begin
	uut_IM: InstructionMemory
		Port map (
			clk => clk,
			addressMem => addressMem,
			instructionMem => instructionMem
		);
	process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
	end process;
	
	process
	begin
		addressMem <= std_logic_vector(to_unsigned(1, 32));
		wait for 20 ns; 
		addressMem <= std_logic_vector(to_unsigned(2, 32));
		wait;
	end process;
end Behavioral;