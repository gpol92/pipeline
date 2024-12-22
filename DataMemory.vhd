library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.DataMemorySignals.all;

entity DataMemory is
	Port (
		clk: in std_logic;
		DM_IN: in DataMemoryInputs;
		DM_OUT: out DataMemoryOutputs
	);
end DataMemory;

architecture Behavioral of DataMemory is
	type memory_array is array (0 to 511) of std_logic_vector(31 downto 0);
	signal data_mem: memory_array := (
		0 => (1 => '1', others => '0'),
		2 => (2 => '1', 4 => '1', others => '0'),
		others => (others => '0')
	);
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if DM_IN.MemWrite = '1' then
				data_mem(to_integer(unsigned(DM_IN.addr))) <= DM_IN.data_in;
			end if;
		end if;
	end process;
	
	DM_OUT.data_out <= data_mem(to_integer(unsigned(DM_IN.addr))) when DM_IN.MemRead = '1' else (others => '0');
end Behavioral;