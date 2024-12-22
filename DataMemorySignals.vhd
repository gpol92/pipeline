library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package DataMemorySignals is

	component DataMemory is
		Port (
			clk: in std_logic;
			MemRead: in std_logic;
			MemWrite: in std_logic;
			addr: in std_logic_vector(31 downto 0);
			data_in: in std_logic_vector(31 downto 0);
			data_out: out std_logic_vector(31 downto 0)
		);
	end component;
	
	type DataMemoryInputs is record
		MemRead: std_logic;
		MemWrite: std_logic;
		addr: std_logic_vector(31 downto 0);
		data_in: std_logic_vector(31 downto 0);
	end record;
	
	type DataMemoryOutputs is record
		data_out: std_logic_vector(31 downto 0);
	end record;
	
	constant initialDMInputs: DataMemoryInputs := (
		MemRead => '0',
		MemWrite => '0',
		addr => (others => '0'),
		data_in => (others => '0')
	);
	
	constant initialDMOutputs: DataMemoryOutputs := (
		data_out => (others => '0')
	);
end package;