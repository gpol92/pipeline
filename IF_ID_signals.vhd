library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package IF_ID_signals is 
	type IF_ID_signals is record
		PC: std_logic_vector(31 downto 0);
		instruction: std_logic_vector(31 downto 0);
	end record;
	
	procedure init_IF_ID_all(signal sig: inout IF_ID_signals);
end IF_ID_signals;

package body IF_ID_signals is
	procedure init_IF_ID_all(signal sig: inout IF_ID_signals) is
		variable temp: IF_ID_signals;
	begin
		temp.PC := (others => '0');
	end procedure;
end IF_ID_signals;