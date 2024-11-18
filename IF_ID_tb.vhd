library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IF_ID_tb is
end IF_ID_tb;

architecture Behavioral of IF_ID_tb is
	component IF_ID
		Port (
			clk: in std_logic;
			reset : in std_logic;
			IF_PC : in std_logic_vector(31 downto 0);
			IF_Instruction : in std_logic_vector(31 downto 0);
			ID_PC : out std_logic_vector(31 downto 0);
			ID_Instruction : out std_logic_vector(31 downto 0)
		);
	end component;
	
	component PC 
		Port (
			clk: in std_logic;
			reset: in std_logic;
			PCin: in std_logic_vector(31 downto 0);
			PCout: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component InstructionMemory
		Port (
			clk: in std_logic;
			addressMem: in std_logic_vector(31 downto 0);
			instructionMem: out std_logic_vector(31 downto 0) := (others => '0')
		);
	end component;
	
	component RegisterBank32x32
		port (
			clk: in std_logic;
			reset: in std_logic;
			RegWrite: in std_logic;
			write_data: in std_logic_vector(31 downto 0);
			read_address1: in std_logic_vector(4 downto 0);
			read_address2: in std_logic_vector(4 downto 0);
			write_address: in std_logic_vector(4 downto 0);
			read_data1: out std_logic_vector(31 downto 0);
			read_data2: out std_logic_vector(31 downto 0)
		);
	end component;


	component ID_EX 
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
			ID_PCSrc: in std_logic;
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
			EX_PCSrc: out std_logic;
			EX_RegDst: out std_logic;
			EX_ALUsrc: out std_logic;
			EX_MemToReg: out std_logic;
			EX_RegWrite: out std_logic;
			EX_MemRead: out std_logic;
			EX_MemWrite: out std_logic;
			EX_Branch: out std_logic;
			EX_ALUop: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component EX_MEM
		Port (
			clk: in std_logic;
			reset: in std_logic;
		
			-- Input signals from EX stage
			EX_zero: in std_logic;
			EX_ALUresult: in std_logic_vector(31 downto 0);
			EX_ReadData2: in std_logic_vector(31 downto 0);
			EX_DestReg: in std_logic_vector(4 downto 0);
			EX_MemRead: in std_logic;
			EX_MemWrite: in std_logic;
			EX_MemToReg: in std_logic;
			EX_Branch: in std_logic;
		
			-- Output signals to MEM stage
			MEM_zero: out std_logic;
			MEM_ALUresult: out std_logic_vector(31 downto 0);
			MEM_ReadData2: out std_logic_vector(31 downto 0);
			MEM_DestReg: out std_logic_vector(4 downto 0);
			MEM_MemRead: out std_logic;
			MEM_MemWrite: out std_logic;
			MEM_MemToReg: out std_logic;
			MEM_Branch: out std_logic
		);
	end component;
	

	component ControlUnit
		Port (
			clk: in std_logic;
			reset: in std_logic;
			opcode: in std_logic_vector(5 downto 0);
			zero: in std_logic;
			ALUsrc: out std_logic;
			ALUop: out std_logic_vector(3 downto 0);
			RegDst: out std_logic;
			RegWrite: out std_logic;
			CU_MemToReg: out std_logic;
			CU_MemRead: out std_logic;
			CU_MemWrite: out std_logic;
			Branch: out std_logic
		);
	end component;

	component ALU
		Port (
			opA, opB: in std_logic_vector(31 downto 0);
			ALUop: in std_logic_vector(3 downto 0);
			funct: in std_logic_vector(3 downto 0);
			ALUout: out std_logic_vector(31 downto 0);
			carryOut: out std_logic;
			zero: out std_logic
		);
	end component;
	
	component DataMemory
		Port (
			clk: in std_logic;
			MemRead: in std_logic;
			MemWrite: in std_logic;
			addr: in std_logic_vector(31 downto 0);
			data_in: in std_logic_vector(31 downto 0);
			data_out: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component MEM_WB
		Port (
			clk: in std_logic;
			reset: in std_logic;
			MEM_MemToReg: in std_logic;
			MEM_MemDataOut: in std_logic_vector(31 downto 0);
			MEM_ALUresult: in std_logic_vector(31 downto 0);
			WB_MemToReg: out std_logic;
			WB_MemDataOut: out std_logic_vector(31 downto 0);
			WB_ALUresult: out std_logic_vector(31 downto 0)
		);
	end component;
	
	signal opcode: std_logic_vector(5 downto 0);
	signal ALUsrc: std_logic := '0';
	signal ALUop: std_logic_vector(3 downto 0) := (others => '0');
	signal RegDst: std_logic := '0';

	signal clk: std_logic := '0';
	signal reset: std_logic := '1';
	signal PCin: std_logic_vector(31 downto 0) := (others => '0');
	signal PCout: std_logic_vector(31 downto 0) := (others => '0');
	signal pcSrc: std_logic := '0';
	signal addressMem: std_logic_vector(31 downto 0) := (others => '0');
	signal instructionMem: std_logic_vector(31 downto 0) := (others => '0');
	signal IF_PC: std_logic_vector(31 downto 0) := (others => '0');
	signal IF_Instruction: std_logic_vector(31 downto 0) := (others => '0');
	signal ID_PC: std_logic_vector(31 downto 0) := (others => '0');
	signal ID_Instruction: std_logic_vector(31 downto 0) := (others => '0');
	signal addOne: std_logic_vector(31 downto 0) := (0 => '1', others => '0');
	signal zeros: std_logic_vector(5 downto 0) := (others => '0');

	signal RegWrite: std_logic := '0';
	signal write_data: std_logic_vector(31 downto 0);
	signal read_address1: std_logic_vector(4 downto 0);
	signal read_address2: std_logic_vector(4 downto 0);
	signal write_address: std_logic_vector(4 downto 0);
	signal read_data1: std_logic_vector(31 downto 0);
	signal read_data2: std_logic_vector(31 downto 0);
	
	
	signal CU_MemToReg: std_logic := '0';
	signal CU_MemRead: std_logic := '0';
	signal CU_MemWrite: std_logic := '0';
	signal MemToReg: std_logic := '0';
	signal MemRead: std_logic := '0';
	signal MemWrite: std_logic := '0';
	signal Branch: std_logic := '0';
	
	signal ID_ReadData1: std_logic_vector(31 downto 0) := (others => '0');
	signal ID_ReadData2: std_logic_vector(31 downto 0) := (others => '0');
	signal ID_SignExtImm: std_logic_vector(31 downto 0) := (others => '0');
	signal ID_RegAddr1: std_logic_vector(4 downto 0) := (others => '0');
	signal ID_RegAddr2: std_logic_vector(4 downto 0) := (others => '0');
	signal ID_PCSrc: std_logic := '0';
	signal ID_RegDst: std_logic := '0';
	signal ID_ALUsrc: std_logic := '0';
	signal ID_MemToReg: std_logic := '0';
	signal ID_RegWrite: std_logic := '0';
	signal ID_MemRead: std_logic := '0';
	signal ID_MemWrite: std_logic := '0';
	signal ID_Branch: std_logic := '0';
	signal ID_ALUop: std_logic_vector(3 downto 0) := (others => '0');
	signal EX_PC: std_logic_vector(31 downto 0) := (others => '0');
	signal EX_zero: std_logic := '0';
	signal EX_Instruction: std_logic_vector(31 downto 0) := (others => '0');
	signal EX_ReadData1: std_logic_vector(31 downto 0) := (others => '0');
	signal EX_ReadData2: std_logic_vector(31 downto 0) := (others => '0');
	signal EX_SignExtImm: std_logic_vector(31 downto 0) := (others => '0');
	signal EX_RegAddr1: std_logic_vector(4 downto 0) := (others => '0');
	signal EX_RegAddr2: std_logic_vector(4 downto 0) := (others => '0');
	signal EX_PCSrc: std_logic := '0';
	signal EX_RegDst: std_logic := '0';
	signal EX_ALUsrc: std_logic := '0';
	signal EX_MemToReg: std_logic := '0';
	signal EX_RegWrite: std_logic := '0';
	signal EX_MemRead: std_logic := '0';
	signal EX_MemWrite: std_logic := '0';
	signal EX_Branch: std_logic := '0';
	signal EX_ALUop: std_logic_vector(3 downto 0) := (others => '0');
	signal opA, opB: std_logic_vector(31 downto 0) := (others => '0');
	signal funct: std_logic_vector(3 downto 0) := (others => '0');
	signal ALUout: std_logic_vector(31 downto 0) := (others => '0');
	signal carryOut: std_logic := '0';
	signal zero: std_logic := '0';
	signal EX_ALUresult: std_logic_vector(31 downto 0) := (others => '0');
	signal EX_DestReg: std_logic_vector(4 downto 0) := (others => '0');
	signal MEM_zero: std_logic := '0';
	signal MEM_ALUresult: std_logic_vector(31 downto 0) := (others => '0');
	signal MEM_ReadData2: std_logic_vector(31 downto 0) := (others => '0');
	signal MEM_MemRead: std_logic := '0';
	signal MEM_MemWrite: std_logic := '0';
	signal MEM_MemToReg: std_logic := '0';
	signal MEM_Branch: std_logic := '0';
	signal MEM_DestReg: std_logic_vector(4 downto 0) := (others => '0');
	
	signal addr: std_logic_vector(31 downto 0) := (others => '0');
	signal data_in: std_logic_vector(31 downto 0) := (others => '0');
	signal data_out: std_logic_vector(31 downto 0) := (others => '0');
	
	signal MEM_MemDataOut: std_logic_vector(31 downto 0) := (others => '0');
	signal WB_MemToReg: std_logic := '0';
	signal WB_MemDataOut: std_logic_vector(31 downto 0) := (others => '0');
	signal WB_ALUresult: std_logic_vector(31 downto 0) := (others => '0');
	
begin

	uut_MEM_WB: MEM_WB
		Port map (
			clk => clk,
			reset => reset,
			MEM_MemToReg => MEM_MemToReg,
			MEM_MemDataOut => MEM_MemDataOut,
			MEM_ALUresult => MEM_ALUresult,
			WB_MemToReg => WB_MemToReg,
			WB_MemDataOut => WB_MemDataOut,
			WB_ALUresult => WB_ALUresult
		);
	uut_DM: DataMemory
		Port map (
			clk => clk,
			MemRead => MemRead,
			MemWrite => MemWrite,
			addr => addr,
			data_in => data_in,
			data_out => data_out
		);
		
	uut_ID_EX: ID_EX
		Port map (
			clk => clk,
			reset => reset,
			ID_PC => ID_PC,
			ID_Instruction => ID_Instruction,
			ID_ReadData1 => ID_ReadData1,
			ID_ReadData2 => ID_ReadData2,
			ID_SignExtImm => ID_SignExtImm,
			ID_RegAddr1 => ID_RegAddr1,
			ID_RegAddr2 => ID_RegAddr2,
			ID_PCSrc => ID_PCSrc,		
			ID_RegDst => ID_RegDst,
			ID_ALUsrc => ID_ALUsrc,
			ID_MemToReg => ID_MemToReg,
			ID_RegWrite => ID_RegWrite,
			ID_MemRead => ID_MemRead,
			ID_MemWrite => ID_MemWrite,
			ID_Branch => ID_Branch,
			ID_ALUop => ID_ALUop,
			EX_PC => EX_PC,
			EX_Instruction => EX_Instruction,
			EX_ReadData1 => EX_ReadData1,
			EX_ReadData2 => EX_ReadData2,
			EX_SignExtImm => EX_SignExtImm,
			EX_RegAddr1 => EX_RegAddr1,
			EX_RegAddr2 => EX_RegAddr2,
			EX_PCSrc => EX_PCSrc,
			EX_RegDst => EX_RegDst,
			EX_ALUsrc => EX_ALUsrc,
			EX_MemToReg => EX_MemToReg,
			EX_RegWrite => EX_RegWrite,
			EX_MemRead => EX_MemRead,
			EX_MemWrite => EX_MemWrite,
			EX_Branch => EX_Branch,
			EX_ALUop => EX_ALUop
		);
	uut_RF: RegisterBank32x32
		Port map (
			clk => clk,
			reset => reset,
			RegWrite => RegWrite,
			write_data => write_data,
			read_address1 => read_address1,
			read_address2 => read_address2,
			write_address => write_address,
			read_data1 => read_data1,
			read_data2 => read_data2
		);

	uut_IF_ID: IF_ID
		Port map (
			clk => clk,
			reset => reset,
			IF_PC => IF_PC,
			IF_Instruction => IF_Instruction,
			ID_PC => ID_PC,
			ID_Instruction => ID_Instruction
		);
		
	uut_PC: PC
		Port map (
			clk => clk,
			reset => reset,
			PCin => PCin,
			PCout => PCout
		);
	uut_IM: InstructionMemory
		Port map (
			clk => clk,
			addressMem => addressMem,
			instructionMem => instructionMem
		);
	
	uut_CU: ControlUnit
		Port map (
			clk => clk,
			reset => reset,
			opcode => opcode,
			zero => zero,
			ALUsrc => ALUsrc,
			ALUop => ALUop,
			RegDst => RegDst,
			RegWrite => RegWrite,
			CU_MemToReg => CU_MemToReg,
			CU_MemRead => CU_MemRead,
			CU_MemWrite => CU_MemWrite,
			Branch => Branch
		);
	
	uut_ALU: ALU
		Port map (
			opA => opA,
			opB => opB,
			ALUop => ALUop,
			funct => funct,
			ALUout => ALUout,
			carryOut => carryOut,
			zero => zero
		);
	
	uut_EX_MEM: EX_MEM
		Port map (
			clk => clk,
			reset => reset,
			EX_zero => EX_zero,
			EX_ALUresult => EX_ALUresult,
			EX_ReadData2 => EX_ReadData2,
			EX_DestReg => EX_DestReg,
			EX_MemRead => EX_MemRead,
			EX_MemWrite => EX_MemWrite,
			EX_MemToReg => EX_MemToReg,
			EX_Branch => EX_Branch,
			MEM_zero => MEM_zero,
			MEM_ALUresult => MEM_ALUresult,
			MEM_ReadData2 => MEM_ReadData2,
			MEM_DestReg => MEM_DestReg,
			MEM_MemRead => MEM_MemRead,
			MEM_MemWrite => MEM_MemWrite,
			MEM_MemToReg => MEM_MemToReg,
			MEM_Branch => MEM_Branch
		);
	
	process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

	process
	begin
		wait for 50 ns;
		reset <= '0';
		wait;
	end process;
	
	opcode <= ID_Instruction(31 downto 26);																																																																																																					
	addressMem <= PCout;
	PCin <= std_logic_vector(unsigned(PCout) + unsigned(addOne)) when pcSrc = '0' else zeros & ID_Instruction(25 downto 0);
	IF_PC <= PCin;
	IF_Instruction <= instructionMem;
	ID_RegAddr1 <= ID_Instruction(20 downto 16);
	ID_RegAddr2 <= ID_Instruction(15 downto 11);
	read_address1 <= ID_Instruction(20 downto 16);
	read_address2 <= ID_Instruction(15 downto 11);
	write_address <= ID_Instruction(20 downto 16) when RegDst = '0' else ID_Instruction(15 downto 11) when RegDst = '1' else (others => 'Z');
	ID_ReadData1 <= read_data1;
	ID_ReadData2 <= read_data2;
	ID_RegDst <= RegDst;
	ID_ALUsrc <= ALUsrc;
	ID_ALUop <= ALUop;
	ID_RegWrite <= RegWrite;
	EX_ALUresult <= ALUout;
	EX_zero <= zero;
	pcSrc <= MEM_zero and MEM_Branch;
	ID_MemRead <= CU_MemRead;
	ID_MemWrite <= CU_MemWrite;
	ID_MemToReg <= CU_MemToReg;
	MemRead <= MEM_MemRead;
	MemToReg <= WB_MemToReg;
	MemWrite <= MEM_MemWrite;
	write_data <= WB_ALUresult when MemToReg = '0' else WB_MemDataOut when MemToReg = '1';
	data_in <= MEM_ALUresult;
	MEM_MemDataOut <= data_out;
	ID_Branch <= Branch;
end Behavioral;																																							
