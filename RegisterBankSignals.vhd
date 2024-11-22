library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package RegisterBankSignals is  
	type RegisterBankSignals is record
		RegWrite      : std_logic;
		write_data    : std_logic_vector(31 downto 0);
		read_address1 : std_logic_vector(4 downto 0);
		read_address2 : std_logic_vector(4 downto 0);
		write_address : std_logic_vector(4 downto 0);
		read_data1    : std_logic_vector(31 downto 0);
		read_data2    : std_logic_vector(31 downto 0);
	end record;
end RegisterBankSignals;
		