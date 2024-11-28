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
	
	procedure init_ALU_all(signal sig : inout ALUSignals);
end ALUsignals;

package body ALUSignals is 
	procedure init_ALU_all(signal sig : inout ALUSignals) is
        variable temp : ALUSignals; -- Variabile temporanea
    begin
        temp.opA := (others => '0');
        temp.opB := (others => '0');
        temp.ALUop := (others => '0');
        temp.funct := (others => '0');
        temp.ALUout := (others => '0');
        temp.carryOut := '0';
        temp.zero := '0';
        sig <= temp; -- Assegna la variabile al segnale
    end procedure;
end ALUSignals;