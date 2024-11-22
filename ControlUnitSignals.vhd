library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ControlUnitSignals is
	type ControlUnitSignals is record
		opcode: std_logic_vector(5 downto 0);
        zero: std_logic;
        ALUsrc: std_logic;
        ALUop: std_logic_vector(3 downto 0);
        RegDst: std_logic;
        RegWrite: std_logic;
        CU_MemToReg: std_logic;
        CU_MemRead: std_logic;
        CU_MemWrite: std_logic;
        Branch: std_logic;
	end record;
end ControlUnitSignals;