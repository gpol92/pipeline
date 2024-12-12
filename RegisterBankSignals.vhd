library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package RegisterBankSignals is 
	component RegisterBank32x32 is
		Port (
			RegWrite: in std_logic;
			write_data: in std_logic_vector(31 downto 0);
			read_address1: in std_logic_vector(4 downto 0);
			read_address2: in std_logic_vector(4 downto 0);
			write_address: in std_logic_vector(4 downto 0); 
			read_data1: out std_logic_vector(31 downto 0);
			read_data2: out std_logic_vector(31 downto 0)
		);
	end component;
	
	type RegisterBankInputs is record
		RegWrite: std_logic;
		write_data: std_logic_vector(31 downto 0);
		read_address1: std_logic_vector(4 downto 0);
		read_address2: std_logic_vector(4 downto 0);
		write_address: std_logic_vector(4 downto 0);
	end record;
	
	type RegisterBankOutputs is record
		read_data1: std_logic_vector(31 downto 0);
		read_data2: std_logic_vector(31 downto 0);
	end record;
	
	
	constant initialRBInputs: RegisterBankInputs := (
		RegWrite => '0',
		write_data => (others => '0'),
		read_address1 => (others => '0'),
		read_address2 => (others => '0'),
		write_address => (others => '0')
	);
	
	constant initialRBOutputs: RegisterBankOutputs := (
		read_data1 => (others => '0'),
		read_data2 => (others => '0')
	);
end RegisterBankSignals;
		