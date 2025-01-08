library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package IF_ID_signals is 

	component IF_ID is
		Port (
			PC: in std_logic_vector(31 downto 0);
			instruction: in std_logic_vector(31 downto 0);
			stall: in std_logic
		);
	end component;
	
	type IF_ID_Inputs is record
		PC: std_logic_vector(31 downto 0);
		instruction: std_logic_vector(31 downto 0);
		stall: std_logic;
	end record;
	
	type IF_ID_Outputs is record
		PC: std_logic_vector(31 downto 0);
		instruction: std_logic_vector(31 downto 0);
		stall: std_logic;
	end record;
	
	constant initialIF_IDInputs: IF_ID_Inputs := (
		PC => (others => '0'),
		instruction => (others => '0'),
		stall => '0'
	);
	
	constant initialIF_IDOutputs: IF_ID_Outputs := (
		PC => (others => '0'),
		instruction => (others => '0'),
		stall => '0'
	);
end IF_ID_signals;


