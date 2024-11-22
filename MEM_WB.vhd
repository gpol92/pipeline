library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MEM_WB_signals.all;

entity MEM_WB is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		MEM_WB_IN: in MEM_WB_signals;
		MEM_WB_OUT: out MEM_WB_signals
	);
end MEM_WB;

architecture Behavioral of MEM_WB is
	signal MemToReg_reg: std_logic;
	signal MemDataOut_reg: std_logic_vector(31 downto 0);
	signal ALUresult_reg: std_logic_vector(31 downto 0);
begin
	process(clk, reset)
	begin
		if reset = '1' then
			MemToReg_reg <= '0';
			MemDataOut_reg <= (others => '0');
			ALUresult_reg <= (others => '0');
		elsif rising_edge(clk) then
			MemToReg_reg <= MEM_WB_IN.MemToReg;
			MemDataOut_reg <= MEM_WB_IN.MemDataOut;
			ALUresult_reg <= MEM_WB_IN.ALUresult;
		end if;
	end process;
	
	MEM_WB_OUT.MemToReg	<= MemToReg_reg;
	MEM_WB_OUT.MemDataOut <= MemDataOut_reg;
	MEM_WB_OUT.ALUresult <= ALUresult_reg;
end Behavioral;