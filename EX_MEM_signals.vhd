library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package EX_MEM_signals is

	type EX_MEM_Inputs is record
		zero: std_logic;
		RegWrite: std_logic;
		ALUresult: std_logic_vector(31 downto 0);
		ReadData2: std_logic_vector(31 downto 0);
		DestReg: std_logic_vector(4 downto 0);
		MemRead: std_logic;
		MemWrite: std_logic;
		MemToReg: std_logic;
		Branch: std_logic;
	end record;
	
	type EX_MEM_Outputs is record
		zero: std_logic;
		RegWrite: std_logic;
		ALUresult: std_logic_vector(31 downto 0);
		ReadData2: std_logic_vector(31 downto 0);
		DestReg: std_logic_vector(4 downto 0);
		MemRead: std_logic;
		MemWrite: std_logic;
		MemToReg: std_logic;
		Branch: std_logic;
	end record;
	
	constant initialEX_MEM_Inputs: EX_MEM_Inputs := (
		zero => '0',
		RegWrite => '0',
		ALUresult => (others => '0'),
		ReadData2 => (others => '0'),
		DestReg => (others => '0'),
		MemRead => '0',
		MemWrite => '0',
		MemToReg => '0',
		Branch => '0'
	);
	
	constant initialEX_MEM_Outputs: EX_MEM_Outputs := (
		zero => '0',
		RegWrite => '0',
		ALUresult => (others => '0'),
		ReadData2 => (others => '0'),
		DestReg => (others => '0'),
		MemRead => '0',
		MemWrite => '0',
		MemToReg => '0',
		Branch => '0'
	);
end EX_MEM_signals;