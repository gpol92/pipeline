library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ID_EX_signals is

	component ID_EX is 
		Port (
			PC: in std_logic_vector(31 downto 0);
			instruction: in std_logic_vector(31 downto 0);
			ReadData1: in std_logic_vector(31 downto 0);
			ReadData2: in std_logic_vector(31 downto 0);
			SignExtImm: in std_logic_vector(31 downto 0);
			RegAddr1: in std_logic_vector(4 downto 0);
			RegAddr2: in std_logic_vector(4 downto 0);
			RegDst: in std_logic;
			ALUsrc: in std_logic;
			MemToReg: in std_logic;
			RegWrite: in std_logic;
			MemRead: in std_logic;
			MemWrite: in std_logic;
			Branch: in std_logic;
			ALUop: in std_logic_vector(3 downto 0)
		);
	end component;
	
	type ID_EX_Inputs is record
		PC: std_logic_vector(31 downto 0);
		instruction: std_logic_vector(31 downto 0);
		ReadData1: std_logic_vector(31 downto 0);
		ReadData2: std_logic_vector(31 downto 0);
		SignExtImm: std_logic_vector(31 downto 0);
		RegAddr1: std_logic_vector(4 downto 0);
		RegAddr2: std_logic_vector(4 downto 0);
		RegDst: std_logic;
		ALUsrc: std_logic;
		MemToReg: std_logic;
		RegWrite: std_logic;
		MemRead: std_logic;
		MemWrite: std_logic;
		Branch: std_logic;
		ALUop: std_logic_vector(3 downto 0);
	end record;
	
	type ID_EX_Outputs is record
		PC: std_logic_vector(31 downto 0);
		instruction: std_logic_vector(31 downto 0);
		ReadData1: std_logic_vector(31 downto 0);
		ReadData2: std_logic_vector(31 downto 0);
		SignExtImm: std_logic_vector(31 downto 0);
		RegAddr1: std_logic_vector(4 downto 0);
		RegAddr2: std_logic_vector(4 downto 0);
		RegDst: std_logic;
		ALUsrc: std_logic;
		MemToReg: std_logic;
		RegWrite: std_logic;
		MemRead: std_logic;
		MemWrite: std_logic;
		Branch: std_logic;
		ALUop: std_logic_vector(3 downto 0);
	end record;
	
	constant initialID_EX_Inputs: ID_EX_Inputs := (
		PC => (others => '0'),
		instruction => (others => '0'),
		ReadData1 => (others => '0'),
		ReadData2 => (others => '0'),
		SignExtImm => (others => '0'),
		RegAddr1 => (others => '0'),
		RegAddr2 => (others => '0'),
		RegDst => '0',
		ALUsrc => '0',
		MemToReg => '0',
		RegWrite => '0',
		MemRead => '0',
		MemWrite => '0',
		Branch => '0',
		ALUop => (others => '0')
	);
	
	constant initialID_EX_Outputs: ID_EX_Outputs := (
		PC => (others => '0'),
		instruction => (others => '0'),
		ReadData1 => (others => '0'),
		ReadData2 => (others => '0'),
		SignExtImm => (others => '0'),
		RegAddr1 => (others => '0'),
		RegAddr2 => (others => '0'),
		RegDst => '0',
		ALUsrc => '0',
		MemToReg => '0',
		RegWrite => '0',
		MemRead => '0',
		MemWrite => '0',
		Branch => '0',
		ALUop => (others => '0')
	);
end ID_EX_signals;