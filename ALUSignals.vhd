library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ALUSignals is
	
	component ALU is
		Port (
			opA: in std_logic_vector(31 downto 0);
			opB: in std_logic_vector(31 downto 0);
			ALUop: in std_logic_vector(3 downto 0);
			funct: in std_logic_vector(3 downto 0);
			ALUout: out std_logic_vector(31 downto 0);
			carryOut: out std_logic;
			zero: out std_logic
		);
	end component;
	type ALUSignals is record
		opA: std_logic_vector(31 downto 0);
		opB: std_logic_vector(31 downto 0);
		ALUop: std_logic_vector(3 downto 0);
		funct: std_logic_vector(3 downto 0);
		ALUout: std_logic_vector(31 downto 0);
		carryOut: std_logic;
		zero: std_logic;
	end record;
end ALUSignals;