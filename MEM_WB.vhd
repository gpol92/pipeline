library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.MEM_WB_signals.all;

entity MEM_WB is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		MEM_WB_IN: in MEM_WB_Inputs;
		MEM_WB_OUT: out MEM_WB_Outputs
	);
end MEM_WB;

architecture Behavioral of MEM_WB is
	signal DestReg_reg: std_logic_vector(4 downto 0);
	signal RegWrite_reg: std_logic;
	signal MemToReg_reg: std_logic;
	signal MemDataOut_reg: std_logic_vector(31 downto 0);
	signal ALUresult_reg: std_logic_vector(31 downto 0);
begin
	process(clk, reset)
	begin
		if reset = '1' then
			DestReg_reg <= (others => '0');
			RegWrite_reg <= '0';
			MemToReg_reg <= '0';
			MemDataOut_reg <= (others => '0');
			ALUresult_reg <= (others => '0');
		elsif rising_edge(clk) then
			DestReg_reg <= MEM_WB_IN.DestReg;
			RegWrite_reg <= MEM_WB_IN.RegWrite;
			MemToReg_reg <= MEM_WB_IN.MemToReg;
			MemDataOut_reg <= MEM_WB_IN.MemDataOut;
			ALUresult_reg <= MEM_WB_IN.ALUresult;
		end if;
	end process;
	
	MEM_WB_OUT.RegWrite <= RegWrite_reg;
	MEM_WB_OUT.DestReg <= DestReg_reg;
	MEM_WB_OUT.MemToReg	<= MemToReg_reg;
	MEM_WB_OUT.MemDataOut <= MemDataOut_reg;
	MEM_WB_OUT.ALUresult <= ALUresult_reg;
end Behavioral;