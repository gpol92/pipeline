library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ALUSignals is
	
	component ALU is
		Port (
			opA: in std_logic_vector(31 downto 0);
			opB: in std_logic_vector(31 downto 0);
			ALUop: in std_logic_vector(3 downto 0);
			funct: in std_logic_vector(5 downto 0);
			ALUout: out std_logic_vector(31 downto 0);
			carryOut: out std_logic;
			zero: out std_logic
		);
	end component;
	type ALUInputSignals is record
		opA: std_logic_vector(31 downto 0);
		opB: std_logic_vector(31 downto 0);
		ALUop: std_logic_vector(3 downto 0);
		funct: std_logic_vector(5 downto 0);
	end record;
	type ALUOutputSignals is record
		ALUout: std_logic_vector(31 downto 0);
		carryOut: std_logic;
		zero: std_logic;
	end record;
	
	constant initialALUInputs: ALUInputSignals := (
		opA => (others => '0'),
		opB => (others => '0'),
		ALUop => (others => '0'),
		funct => (others => '0')
	);
	
	constant initialALUOutputs: ALUOutputSignals := (
		ALUout => (others => '0'),
		carryOut => '0',
		zero => '0'
	);
end ALUSignals;