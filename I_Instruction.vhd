library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package I_Instruction is
	type I_Instruction is record 
		opcode: std_logic_vector(5 downto 0);
		sourceReg1: std_logic_vector(4 downto 0);
		writeReg: std_logic_vector(4 downto 0);
		immediate: std_logic_vector(15 downto 0);
	end record;
end package;

package body I_Instruction is
	function to_binary(instr: I_Instruction) return std_logic_vector is
	begin
		return instr.opcode & instr.sourceReg1 & instr.writeReg & instr.immediate;
	end function;
	
	procedure load_I_instruction (
		opcode: in std_logic_vector(5 downto 0);
		sourceReg1: in std_logic_vector(4 downto 0);
		writeReg: in std_logic_vector(4 downto 0);
		immediate: in std_logic_vector(15 downto 0)
	)	
	is
		variable instr: I_Instruction;
	begin
		instr.opcode := opcode;
		instr.sourceReg1 := sourceReg1;
		instr.writeReg := writeReg;
		instr.immediate := immediate;
	end procedure;
end I_Instruction;