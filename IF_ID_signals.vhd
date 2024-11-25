library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package IF_ID_signals is 
	type IF_ID_signals is record
		PC: std_logic_vector(31 downto 0);
		instruction: std_logic_vector(31 downto 0);
	end record;
end IF_ID_signals;