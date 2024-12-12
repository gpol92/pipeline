library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.EX_MEM_signals.all;

entity EX_MEM is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		EX_MEM_IN: in EX_MEM_Inputs;
		EX_MEM_OUT: out EX_MEM_Outputs
	);
end EX_MEM;

architecture Behavioral of EX_MEM is
	signal zero_reg: std_logic;
	signal RegWrite_reg: std_logic;
	signal ALUresult_reg: std_logic_vector(31 downto 0);
	signal ReadData2_reg: std_logic_vector(31 downto 0);
	signal DestReg_reg: std_logic_vector(4 downto 0);
	signal MemRead_reg: std_logic;
	signal MemWrite_reg: std_logic;
	signal MemToReg_reg: std_logic;
	signal Branch_reg: std_logic;
begin
	process(clk, reset)
	begin
		if reset = '1' then
			zero_reg <= '0';
			RegWrite_reg <= '0';
			ALUresult_reg <= (others => '0');
			ReadData2_reg <= (others => '0');
			DestReg_reg <= (others => '0');
			MemRead_reg <= '0';
			MemWrite_reg <= '0';
			MemToReg_reg <= '0';
			Branch_reg <= '0';
		elsif rising_edge(clk) then
			zero_reg <= EX_MEM_IN.zero;
			RegWrite_reg <= EX_MEM_IN.RegWrite;
			ALUresult_reg <= EX_MEM_IN.ALUresult;
			ReadData2_reg <= EX_MEM_IN.ReadData2;
			DestReg_reg <= EX_MEM_IN.DestReg;
			MemRead_reg <= EX_MEM_IN.MemRead;
			MemWrite_reg <= EX_MEM_IN.MemWrite;
			MemToReg_reg <= EX_MEM_IN.MemToReg;
			Branch_reg <= EX_MEM_IN.Branch;
		end if;
	end process;
	
	EX_MEM_OUT.zero <= zero_reg;
	EX_MEM_OUT.RegWrite <= RegWrite_reg;
	EX_MEM_OUT.ALUresult <= ALUresult_reg;
	EX_MEM_OUT.ReadData2 <= ReadData2_reg;
	EX_MEM_OUT.DestReg <= DestReg_reg;
	EX_MEM_OUT.MemRead <= MemRead_reg;
	EX_MEM_OUT.MemWrite <= MemWrite_reg;
	EX_MEM_OUT.MemToReg <= MemToReg_reg;
	EX_MEM_OUT.Branch <= Branch_reg;
end Behavioral;