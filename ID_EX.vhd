library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ID_EX is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		
		-- input signals from ID stage
		ID_PC: in std_logic_vector(31 downto 0);
		ID_Instruction: in std_logic_vector(31 downto 0);
		ID_ReadData1: in std_logic_vector(31 downto 0);
		ID_ReadData2: in std_logic_vector(31 downto 0);
		ID_SignExtImm: in std_logic_vector(31 downto 0);
		ID_RegAddr1: in std_logic_vector(4 downto 0);
		ID_RegAddr2: in std_logic_vector(4 downto 0);
		ID_RegDst: in std_logic;
		ID_ALUsrc: in std_logic;
		ID_MemToReg: in std_logic;
		ID_RegWrite: in std_logic;
		ID_MemRead: in std_logic;
		ID_MemWrite: in std_logic;
		ID_Branch: in std_logic;
		ID_ALUop: in std_logic_vector(3 downto 0);
		
		-- output signals to EX stage
		EX_PC: out std_logic_vector(31 downto 0);
		EX_Instruction: out std_logic_vector(31 downto 0);
		EX_ReadData1: out std_logic_vector(31 downto 0);
		EX_ReadData2: out std_logic_vector(31 downto 0);
		EX_SignExtImm: out std_logic_vector(31 downto 0);
		EX_RegAddr1: out std_logic_vector(4 downto 0);
		EX_RegAddr2: out std_logic_vector(4 downto 0);
		EX_RegDst: out std_logic;
		EX_ALUsrc: out std_logic;
		EX_MemToReg: out std_logic;
		EX_RegWrite: out std_logic;
		EX_MemRead: out std_logic;
		EX_MemWrite: out std_logic;
		EX_Branch: out std_logic;
		EX_ALUop: out std_logic_vector(3 downto 0)
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
			PC_reg <= (others => '0');
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
			PC_reg <= ID_PC;
			Instruction_reg <= ID_instruction;
			ReadData1_reg <= ID_ReadData1;
			ReadData2_reg <= ID_ReadData2;
			SignExtImm_reg <= ID_SignExtImm;
			RegAddr1_reg <= ID_RegAddr1;
			RegAddr2_reg <= ID_RegAddr2;
			RegDst_reg <= ID_RegDst;
			ALUsrc_reg <= ID_ALUsrc;
			MemToReg_reg <= ID_MemToReg;
			RegWrite_reg <= ID_RegWrite;
			MemRead_reg <= ID_MemRead;
			MemWrite_reg <= ID_MemWrite;
			Branch_reg <= ID_Branch;
			ALUop_reg <= ID_ALUop;
		end if;
	end process;
	
	EX_PC <= PC_reg;
	EX_Instruction <= Instruction_reg;
	EX_ReadData1 <= ReadData1_reg;
	EX_ReadData2 <= ReadData2_reg;
	EX_SignExtImm <= SignExtImm_reg;
	EX_RegAddr1 <= RegAddr1_reg;
	EX_RegAddr2 <= RegAddr2_reg;
	EX_RegDst <= RegDst_reg;
	EX_ALUsrc <= ALUsrc_reg;
	EX_MemToReg <= MemToReg_reg;
	EX_RegWrite <= RegWrite_reg;
	EX_MemRead <= MemRead_reg;
	EX_MemWrite <= MemWrite_reg;
	EX_Branch <= Branch_reg;
	EX_ALUop <= ALUop_reg;
end Behavioral;