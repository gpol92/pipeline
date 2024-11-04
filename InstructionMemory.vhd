library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemory is
	Port (
		clk: in std_logic;
		addressMem: in std_logic_vector(31 downto 0);
		instructionMem: out std_logic_vector(31 downto 0) := (others => '0')
	);
end InstructionMemory;

architecture Behavioral of InstructionMemory is
	type memory_array is array (0 to 255) of std_logic_vector(31 downto 0);
	signal memory: memory_array := (
		0 => b"00000100000100000000000000000100", -- addi r15, r0, 4
		1 => b"00000100000100010000000000000101", -- addi r16, r0, 5
		2 => b"00001010000100011001000000000010", -- add r17, r16, r15
		3 => b"00001010000100011001100000000011", -- sub r18, r16, r15
		4 => b"00000100000011100000000000000001", -- addi r13, r0, 1
		5 => b"00000100000011110000000000000001", -- addi r14, r0, 1
		6 => b"00001101110011110000000000000001", -- lw r14, 1(r13)
		7 => b"00010001110011110000000000000100", -- sw r14, 4(r13)
		8 => b"00010110000100111111111111111000", -- bne r15, r17, -8
		9 => b"00011100000000000000000000000001", -- jump 1
		others => b"00000000000000000000000000000000"
	);
begin
	process(clk)
	begin
		if rising_edge(clk) then
			instructionMem <= memory(to_integer(unsigned(addressMem)));
		else 	
			instructionMem <= instructionMem;
		end if;
	end process;
end Behavioral;