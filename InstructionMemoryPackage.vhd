library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Instructions is
	type R_Instruction is record 
		opcode: std_logic_vector(5 downto 0);
		sourceReg1: std_logic_vector(4 downto 0);
		sourceReg2: std_logic_vector(4 downto 0);
		writeReg: std_logic_vector(4 downto 0);
		shiftAmount: std_logic_vector(4 downto 0);
		funct: std_logic_vector(5 downto 0);
	end record;
end package;