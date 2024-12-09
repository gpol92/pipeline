library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ALUSignals.all;

entity ALU is
	Port (
		ALU_IN: in ALUSignals;
		ALU_OUT: out ALUSignals
	);
end ALU;

architecture Behavioral of ALU is
	signal ALUresult: std_logic_vector(31 downto 0);
	signal tmp: std_logic_vector(32 downto 0);

begin
	process(ALU_IN.opA, ALU_IN.opB, ALU_IN.ALUop, ALU_IN.funct)
	begin
		ALU_OUT.zero <= '0';
		case(ALU_IN.ALUop) is
			when "0000" =>
				ALUresult <= ALU_IN.opA;
			when "0001" =>
				ALUresult <= std_logic_vector(signed(ALU_IN.opA) + signed(ALU_IN.opB));
			when "0010" =>
				if ALU_IN.funct = "000010" then
					ALUresult <= std_logic_vector(signed(ALU_IN.opA) + signed(ALU_IN.opB));
				elsif ALU_IN.funct = "000011" then
					ALUresult <= std_logic_vector(signed(ALU_IN.opA) - signed(ALU_IN.opB));
				end if;
			when "0011" =>
				if ALU_IN.opA = ALU_IN.opB then
					ALU_OUT.zero <= '1';
				else 
					ALU_OUT.zero <= '0';
				end if;
			when others => ALUresult <= (others => '0');
		end case;
	end process;
	ALU_OUT.ALUout <= ALUresult;
	tmp <= std_logic_vector(signed('0' & ALU_IN.opA) + signed('0' & ALU_IN.opB));
	ALU_OUT.carryOut <= tmp(32);
end Behavioral;