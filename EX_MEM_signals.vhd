library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package EX_MEM_signals is
	type EX_MEM_signals is record
		zero: std_logic;
		ALUresult: std_logic_vector(31 downto 0);
		ALUsrc: std_logic;
		ReadData2: std_logic_vector(31 downto 0);
		DestReg: std_logic_vector(4 downto 0);
		MemRead: std_logic;
		MemWrite: std_logic;
		MemToReg: std_logic;
		Branch: std_logic;
	end record;
	
	constant EX_MEM_sig: EX_MEM_signals := (
		zero => '0',
		ALUresult => (others => '0'),
		ALUsrc => '0',
		ReadData2 => (others => '0'),
		DestReg => (others => '0'),
		MemRead => '0',
		MemWrite => '0',
		MemToReg => '0',
		Branch => '0'
	);
end EX_MEM_signals;