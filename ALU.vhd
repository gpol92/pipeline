library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ALU is
	Port (
		opA, opB: in std_logic_vector(31 downto 0);
		ALUop: in std_logic_vector(3 downto 0);
		funct: in std_logic_vector(3 downto 0);
		ALUout: out std_logic_vector(31 downto 0);
		carryOut: out std_logic;
		zero: out std_logic
	);
end ALU;

architecture Behavioral of ALU is
	signal ALUresult: std_logic_vector(31 downto 0);
	signal tmp: std_logic_vector(32 downto 0);

begin
	process(opA, opB, ALUop, funct)
	begin
		zero <= '0';
		case(ALUop) is
			when "0000" =>
				ALUresult <= opA;
			when "0001" =>
				ALUresult <= std_logic_vector(signed(opA) + signed(opB));
			when "0010" =>
				if funct = "0010" then
					ALUresult <= std_logic_vector(signed(opA) + signed(opB));
				elsif funct = "0011" then
					ALUresult <= std_logic_vector(signed(opA) - signed(opB));
				end if;
			when "0011" =>
				if opA = opB then
					zero <= '1';
				else 
					zero <= '0';
				end if;
			when others => ALUresult <= (others => '0');
		end case;
	end process;
	ALUout <= ALUresult;
	tmp <= std_logic_vector(signed('0' & opA) + signed('0' & opB));
	carryOut <= tmp(32);
end Behavioral;