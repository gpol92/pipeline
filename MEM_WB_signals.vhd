library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package MEM_WB_signals is
	type MEM_WB_signals is record
		RegWrite: std_logic;
		MemToReg: std_logic;
		MemDataOut: std_logic_vector(31 downto 0);
		ALUresult: std_logic_vector(31 downto 0);
	end record;
end MEM_WB_signals;