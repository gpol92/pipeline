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
	
	type instruction_memory is array (0 to 255) of std_logic_vector(31 downto 0);
end package;

package body R_Instruction is
	function to_binary(instr: R_Instruction) return std_logic_vector is
	begin
		return instr.opcode & instr.sourceReg1 & instr.sourceReg2 & instr.writeReg & instr.shiftAmount & instr.funct;
	end function;
	
	procedure load_R_instruction (
		signal mem: inout instruction_memory;
		address: in integer;
		opcode: in std_logic_vector(5 downto 0);
		sourceReg1: in std_logic_vector(4 downto 0);
		sourceReg2: in std_logic_vector(4 downto 0);
		writeReg: in std_logic_vector(4 downto 0);
		shiftAmount: in std_logic_vector(4 downto 0);
		funct: in std_logic_vector(5 downto 0)
	) is 
		variable instr: R_Instruction;
	begin
		instr.opcode := opcode;
		instr.sourceReg1 := sourceReg1;
		instr.sourceReg2 := sourceReg2;
		instr.writeReg := writeReg;
		instr.shiftAmount := shiftAmount;
		instr.funct := funct;
		mem(address) <= to_binary(instr);
	end procedure load_R_Instruction;
end R_Instruction;