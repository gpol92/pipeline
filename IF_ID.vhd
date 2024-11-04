library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IF_ID is
	Port (
		clk: in std_logic;
		reset : in std_logic;
        IF_PC : in std_logic_vector(31 downto 0);
        IF_Instruction : in std_logic_vector(31 downto 0);
        ID_PC : out std_logic_vector(31 downto 0);
        ID_Instruction : out std_logic_vector(31 downto 0)
    );
end IF_ID;

architecture Behavioral of IF_ID is
	signal PC_reg: std_logic_vector(31 downto 0);
	signal Instruction_reg: std_logic_vector(31 downto 0);
begin
	process(clk, reset)
	begin
		if reset = '1' then
			PC_reg <= (others => '0');
			Instruction_reg <= (others => '0');
		elsif rising_edge(clk) then
			PC_reg <= IF_PC;
			Instruction_reg <= IF_Instruction;
		end if;
	end process;
	
	ID_PC <= PC_reg;
	ID_Instruction <= Instruction_reg;
end Behavioral;