library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ALUSignals is
	type ALUSignals is record
		opA: std_logic_vector(31 downto 0);
		opB: std_logic_vector(31 downto 0);
		ALUop: std_logic_vector(3 downto 0);
		funct: std_logic_vector(3 downto 0);
		ALUout: std_logic_vector(31 downto 0);
		carryOut: std_logic;
		zero: std_logic;
	end record;
end ALUsignals;