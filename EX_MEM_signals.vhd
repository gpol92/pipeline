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
	
	procedure init_EX_MEM_all(signal sig: EX_MEM_signals);
end EX_MEM_signals;

package body EX_MEM_signals is
	procedure init_EX_MEM_all(signal sig: EX_MEM_signals) is
		