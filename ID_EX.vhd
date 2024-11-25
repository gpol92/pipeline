library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ID_EX_signals.all;

entity ID_EX is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		ID_EX_IN: in ID_EX_signals;
		ID_EX_OUT: out ID_EX_signals
	);
end ID_EX;

architecture Behavioral of ID_EX is
	signal PC_reg: std_logic_vector(31 downto 0);
	signal Instruction_reg: std_logic_vector(31 downto 0);
	signal ReadData1_reg: std_logic_vector(31 downto 0);
	signal ReadData2_reg: std_logic_vector(31 downto 0);
	signal SignExtImm_reg: std_logic_vector(31 downto 0);
	signal RegAddr1_reg: std_logic_vector(4 downto 0);
	signal RegAddr2_reg: std_logic_vector(4 downto 0);
	signal RegDst_reg: std_logic;
	signal ALUsrc_reg: std_logic;
	signal MemToReg_reg: std_logic;
	signal RegWrite_reg: std_logic;
	signal MemRead_reg: std_logic;
	signal MemWrite_reg: std_logic;
	signal Branch_reg: std_logic;
	signal ALUop_reg: std_logic_vector(3 downto 0);
begin
	process(clk, reset)
	begin
		if reset = '1' then
			Instruction_reg <= (others => '0');
			ReadData1_reg <= (others => '0');
			ReadData2_reg <= (others => '0');
			SignExtImm_reg <= (others => '0');
			RegAddr1_reg <= (others => '0');
			RegAddr2_reg <= (others => '0');
			RegDst_reg <= '0';
			ALUsrc_reg <= '0';
			MemToReg_reg <= '0';
			RegWrite_reg <= '0';
			MemRead_reg <= '0';
			MemWrite_reg <= '0';
			Branch_reg <= '0';
			ALUop_reg <= (others => '0');
		elsif rising_edge(clk) then
			PC_reg <= ID_EX_IN.PC;
			Instruction_reg <= ID_EX_IN.instruction;
			ReadData1_reg <= ID_EX_IN.ReadData1;
			ReadData2_reg <= ID_EX_IN.ReadData2;
			SignExtImm_reg <= ID_EX_IN.SignExtImm;
			RegAddr1_reg <= ID_EX_IN.RegAddr1;
			RegAddr2_reg <= ID_EX_IN.RegAddr2;
			RegDst_reg <= ID_EX_IN.RegDst;
			ALUsrc_reg <= ID_EX_IN.ALUsrc;
			MemToReg_reg <= ID_EX_IN.MemToReg;
			RegWrite_reg <= ID_EX_IN.RegWrite;
			MemRead_reg <= ID_EX_IN.MemRead;
			MemWrite_reg <= ID_EX_IN.MemWrite;
			Branch_reg <= ID_EX_IN.Branch;
			ALUop_reg <= ID_EX_IN.ALUop;
		end if;
	end process;
	
	ID_EX_OUT.PC <= PC_reg;
	ID_EX_OUT.instruction <= Instruction_reg;
	ID_EX_OUT.ReadData1 <= ReadData1_reg;
	ID_EX_OUT.ReadData2 <= ReadData2_reg;
	ID_EX_OUT.SignExtImm <= SignExtImm_reg;
	ID_EX_OUT.RegAddr1 <= RegAddr1_reg;
	ID_EX_OUT.RegAddr2 <= RegAddr2_reg;
	ID_EX_OUT.RegDst <= RegDst_reg;
	ID_EX_OUT.ALUsrc <= ALUsrc_reg;
	ID_EX_OUT.MemToReg <= MemToReg_reg;
	ID_EX_OUT.RegWrite <= RegWrite_reg;
	ID_EX_OUT.MemRead <= MemRead_reg;
	ID_EX_OUT.MemWrite <= MemWrite_reg;
	ID_EX_OUT.Branch <= Branch_reg;
	ID_EX_OUT.ALUop <= ALUop_reg;
end Behavioral;