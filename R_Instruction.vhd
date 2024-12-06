library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package R_Instruction is
	type R_Instruction is record 
		opcode: std_logic_vector(5 downto 0);
		sourceReg1: std_logic_vector(4 downto 0);
		sourceReg2: std_logic_vector(4 downto 0);
		writeReg: std_logic_vector(4 downto 0);
		shiftAmount: std_logic_vector(4 downto 0);
		funct: std_logic_vector(5 downto 0);
	end record;
end package;

package body R_Instruction is
	function to_binary(instr: R_Instruction) return std_logic_vector is
	begin
		return instr.opcode & instr.sourceReg1 & instr.sourceReg2 & instr.writeReg & instr.shiftAmount & instr.funct;
	end function;
end R_Instruction;