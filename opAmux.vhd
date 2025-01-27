library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity opAmux is
	Port (
		forwardA: in std_logic_vector(1 downto 0);
		ALUresultEXMEM: in std_logic_vector(31 downto 0);
		WBresult: in std_logic_vector(31 downto 0);
		ID_EX_ReadData1: in std_logic_vector(31 downto 0);
		opAmuxOut: out std_logic_vector(31 downto 0)
	);
end opAmux;

architecture Behavioral of opAmux is

begin
	process(forwardA, ALUresultEXMEM, WBresult, ID_EX_ReadData1)
	begin
		opAmuxOut <= ID_EX_ReadData1 when forwardA = "00" else WBresult when forwardA = "01" else ALUresultEXMEM when forwardA = "10";
	end process;
end Behavioral;