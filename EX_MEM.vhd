library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EX_MEM is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		
		-- Input signals from EX stage
		EX_ALUresult: in std_logic_vector(31 downto 0);
		EX_ReadData2: in std_logic_vector(31 downto 0);
		EX_DestReg: in std_logic_vector(4 downto 0);
		EX_MemRead: in std_logic;
		EX_MemWrite: in std_logic;
		EX_MemToReg: in std_logic;
		EX_Branch: in std_logic;
		
		-- Output signals to MEM stage
		MEM_ALUresult: out std_logic_vector(31 downto 0);
		MEM_ReadData2: out std_logic_vector(31 downto 0);
		MEM_DestReg: out std_logic_vector(4 downto 0);
		MEM_MemRead: out std_logic;
		MEM_MemWrite: out std_logic;
		MEM_MemToReg: out std_logic;
		MEM_Branch: out std_logic
	);
end EX_MEM;

architecture Behavioral of EX_MEM is
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
			ALUresult_reg <= (others => '0');
			ReadData2_reg <= (others => '0');
			DestReg_reg <= (others => '0');
			MemRead_reg <= '0';
			MemWrite_reg <= '0';
			MemToReg_reg <= '0';
			Branch_reg <= '0';
		elsif rising_edge(clk) then
			ALUresult_reg <= EX_ALUresult;
			ReadData2_reg <= EX_ReadData2;
			DestReg_reg <= EX_DestReg;
			MemRead_reg <= EX_MemRead;
			MemWrite_reg <= EX_MemWrite;
			MemToReg_reg <= EX_MemToReg;
			Branch_reg <= EX_Branch;
		end if;
	end process;
	
	MEM_ALUresult <= ALUresult_reg;
	MEM_ReadData2 <= ReadData2_reg;
	MEM_DestReg <= DestReg_reg;
	MEM_MemRead <= MemRead_reg;
	MEM_MemWrite <= MemWrite_reg;
	MEM_MemToReg <= MemToReg_reg;
	MEM_Branch <= Branch_reg;
end Behavioral;