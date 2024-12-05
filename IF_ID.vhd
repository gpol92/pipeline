library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.IF_ID_signals.all;

entity IF_ID is
	Port (
		clk: in std_logic;
		reset : in std_logic;
        IF_ID_IN: in IF_ID_signals;
		IF_ID_OUT: out IF_ID_signals
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
			PC_reg <= IF_ID_IN.PC;
			Instruction_reg <= IF_ID_IN.instruction;
		end if;
	end process;
	
	IF_ID_OUT.PC <= PC_reg;
	IF_ID_OUT.instruction <= Instruction_reg;
end Behavioral;