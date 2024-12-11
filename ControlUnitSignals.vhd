library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ControlUnitSignals is
	
	component ControlUnit is
		Port (
			opcode: in std_logic_vector(5 downto 0);
			zero: in std_logic;
			ALUsrc: out std_logic;
			ALUop: out std_logic_vector(3 downto 0);
			RegDst: out std_logic;
			RegWrite: out std_logic;
			MemToReg: out std_logic;
			MemRead: out std_logic;
			MemWrite: out std_logic;
			Branch: out std_logic
		);
	end component;
	
	type ControlUnitInputSignals is record
		opcode: std_logic_vector(5 downto 0);
        zero: std_logic;
	end record;
	
	type ControlUnitOutputSignals is record
		ALUsrc: std_logic;
        ALUop: std_logic_vector(3 downto 0);
        RegDst: std_logic;
        RegWrite: std_logic;
        MemToReg: std_logic;
        MemRead: std_logic;
        MemWrite: std_logic;
        Branch: std_logic;
	end record;
	
	constant initialCUInputs: ControlUnitInputSignals := (
		opcode => (others => '0'),
		zero => '0'
	);
	
	constant initialCUOutputs: ControlUnitOutputSignals := (
		ALUsrc => '0',
		ALUop => (others => '0'),
		RegDst => '0',
		RegWrite => '0',
		MemToReg => '0',
		MemRead => '0',		
		MemWrite => '0',
		Branch => '0'
	);
end ControlUnitSignals;