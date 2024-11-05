library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemory is
	Port (
		clk: in std_logic;
		MemRead: in std_logic;
		MemWrite: in std_logic;
		addr: in std_logic_vector(31 downto 0);
		data_in: in std_logic_vector(31 downto 0);
		data_out: out std_logic_vector(31 downto 0)
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
			if MemWrite = '1' then
				data_mem(to_integer(unsigned(addr))) <= data_in;
			end if;
		end if;
	end process;
	
	data_out <= data_mem(to_integer(unsigned(addr))) when MemRead = '1' else (others => '0');
end Behavioral;