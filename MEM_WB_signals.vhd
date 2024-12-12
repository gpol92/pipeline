library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package MEM_WB_signals is
	
	component MEM_WB is
		Port (
			DestReg: in std_logic_vector(4 downto 0);
			RegWrite: in std_logic;
			MemToReg: in std_logic;
			MemDataOut: in std_logic_vector(31 downto 0);
			ALUresult: in std_logic_vector(31 downto 0)
		);
	end component;
	type MEM_WB_Inputs is record
		DestReg: std_logic_vector(4 downto 0);
		RegWrite: std_logic;
		MemToReg: std_logic;
		MemDataOut: std_logic_vector(31 downto 0);
		ALUresult: std_logic_vector(31 downto 0);
	end record;
	
	type MEM_WB_Outputs is record
		DestReg: std_logic_vector(4 downto 0);
		RegWrite: std_logic;
		MemToReg: std_logic;
		MemDataOut: std_logic_vector(31 downto 0);
		ALUresult: std_logic_vector(31 downto 0);
	end record;
	
	constant initialMEMWBInputs: MEM_WB_Inputs := (
		DestReg => (others => '0'),
		RegWrite => '0',
		MemToReg => '0',
		MemDataOut => (others => '0'),
		ALUresult => (others => '0')
	);
	
	constant initialMEMWBOutputs: MEM_WB_Outputs := (
		DestReg => (others => '0'),
		RegWrite => '0',
		MemToReg => '0',
		MemDataOut => (others => '0'),
		ALUresult => (others => '0')
	);
end MEM_WB_signals;