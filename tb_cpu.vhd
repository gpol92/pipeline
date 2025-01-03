library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PCSignals.all;
use work.IF_ID_signals.all;
use work.RegisterBankSignals.all;
use work.ALUSignals.all;
use work.ID_EX_signals.all;
use work.ControlUnitSignals.all;
use work.EX_MEM_signals.all;
use work.MEM_WB_signals.all;
use work.DataMemorySignals.all;

entity tb_cpu is
end tb_cpu;

architecture Behavioral of tb_cpu is

	component InstructionMemory
		Port (
			clk: in std_logic;
			reset: in std_logic;
			addressMem: in std_logic_vector(31 downto 0);
			instructionMem: out std_logic_vector(31 downto 0) := (others => '0')
		);
	end component;
	
	component DataMemory
		Port (
			clk: in std_logic;
			DM_IN: in DataMemoryInputs;
			DM_OUT: out DataMemoryOutputs
		);
	end component;
	
	signal clk: std_logic := '0';
	signal reset: std_logic := '1';
	signal pcSrc: std_logic := '0';
	
	signal IF_ID_IN: IF_ID_Inputs := initialIF_IDInputs;
	signal IF_ID_OUT: IF_ID_Outputs := initialIF_IDOutputs;
	
	signal addressMem: std_logic_vector(31 downto 0) := (others => '0');
	signal instructionMem: std_logic_vector(31 downto 0) := (others => '0');
	
	signal PC_IN: PCInputs := initialPCInputs;
	signal PC_OUT: PCOutputs := initialPCOutputs;
	
	signal RB_IN: RegisterBankInputs := initialRBInputs;
	signal RB_OUT: RegisterBankOutputs := initialRBOutputs;
	
	signal ALU_IN: ALUInputSignals := initialALUInputs;
	signal ALU_OUT: ALUOutputSignals := initialALUOutputs;
	
	signal ID_EX_IN: ID_EX_Inputs := initialID_EX_Inputs;
	signal ID_EX_OUT: ID_EX_Outputs := initialID_EX_Outputs;
	
	signal CU_IN: ControlUnitInputSignals := initialCUInputs;
	signal CU_OUT: ControlUnitOutputSignals := initialCUOutputs;
	
	signal EX_MEM_IN: EX_MEM_Inputs := initialEX_MEM_Inputs;
	signal EX_MEM_OUT: EX_MEM_Outputs := initialEX_MEM_Outputs;
	
	signal MEM_WB_IN: MEM_WB_Inputs := initialMEMWBInputs;
	signal MEM_WB_OUT: MEM_WB_Outputs := initialMEMWBOutputs;
	
	signal DM_IN: DataMemoryInputs := initialDMInputs;
	signal DM_OUT: DataMemoryOutputs := initialDMOutputs;
	
begin
	uut_IM: InstructionMemory
		Port map (
			clk => clk,
			reset => reset,
			addressMem => addressMem,
			instructionMem => instructionMem
		);
		
	uut_PC: entity work.PC
		Port map (
			clk => clk,
			reset => reset,
			PC_IN => PC_IN,
			PC_OUT => PC_OUT
		);
		
	uut_IF_ID: entity work.IF_ID
		Port map (
			clk => clk,
			reset => reset,
			IF_ID_IN => IF_ID_IN,
			IF_ID_OUT => IF_ID_OUT
		);
		
	uut_RB: entity work.RegisterBank32x32
		Port map (
			clk => clk,
			reset => reset,
			RB_IN => RB_IN,
			RB_OUT => RB_OUT
		);
	uut_ALU: entity work.ALU
		Port map (
			ALU_IN => ALU_IN,
			ALU_OUT => ALU_OUT
		);
	uut_ID_EX: entity work.ID_EX
		Port map (
			clk => clk,
			reset => reset,
			ID_EX_IN => ID_EX_IN,
			ID_EX_OUT => ID_EX_OUT
		);
	uut_CU: entity work.ControlUnit
		Port map (
			clk => clk,
			reset => reset,
			CU_IN => CU_IN,
			CU_OUT => CU_OUT
		);
	
	uut_EX_MEM: entity work.EX_MEM
		Port map (
			clk => clk,
			reset => reset,
			EX_MEM_IN => EX_MEM_IN,
			EX_MEM_OUT => EX_MEM_OUT
		);
		
	uut_MEM_WB: entity work.MEM_WB	
		Port map (
			clk => clk,
			reset => reset,
			MEM_WB_IN => MEM_WB_IN,
			MEM_WB_OUT => MEM_WB_OUT
		);
		
	uut_DM: entity work.DataMemory
		Port map (
			clk => clk,
			DM_IN => DM_IN,
			DM_OUT => DM_OUT
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
	
	process(clk)
		-- variable PCout: std_logic_vector(31 downto 0) := (others => '0');
		variable jumpPC: std_logic_vector(31 downto 0) := (others => '0');
		variable jumpedPC: std_logic_vector(31 downto 0) := (others => '0');
	begin
		if rising_edge(clk) then
			if reset = '0' then
				addressMem <= PC_OUT.PCout;
				IF_ID_IN.PC <= PC_OUT.PCout;
				IF_ID_IN.instruction <= instructionMem;
				CU_IN.opcode <= IF_ID_OUT.instruction(31 downto 26);
				ID_EX_IN.PC <= IF_ID_OUT.PC;
				ID_EX_IN.RegDst <= CU_OUT.RegDst;
				ID_EX_IN.ALUsrc <= CU_OUT.ALUsrc;
				ID_EX_IN.MemToReg <= CU_OUT.MemToReg;
				ID_EX_IN.RegWrite <= CU_OUT.RegWrite;
				ID_EX_IN.MemRead <= CU_OUT.MemRead;
				ID_EX_IN.MemWrite <= CU_OUT.MemWrite;
				ID_EX_IN.Branch <= CU_OUT.Branch;
				ID_EX_IN.ALUop <= CU_OUT.ALUop;
				RB_IN.read_address1 <= IF_ID_OUT.instruction(25 downto 21);
				RB_IN.read_address2 <= IF_ID_OUT.instruction(20 downto 16);
				ID_EX_IN.ReadData1 <= RB_OUT.read_data1;
				ID_EX_IN.ReadData2 <= RB_OUT.read_data2;
				EX_MEM_IN.RegWrite <= ID_EX_OUT.RegWrite;
				MEM_WB_IN.RegWrite <= EX_MEM_OUT.RegWrite;
				RB_IN.RegWrite <= MEM_WB_OUT.RegWrite;
				EX_MEM_IN.MemWrite <= ID_EX_OUT.MemWrite;
				EX_MEM_IN.MemToReg <= ID_EX_OUT.MemToReg;
				EX_MEM_IN.MemRead <= ID_EX_OUT.MemRead;
				EX_MEM_IN.Branch <= ID_EX_OUT.Branch;
				EX_MEM_IN.zero <= ALU_OUT.zero;
				
				-- PCout := PC_OUT.PCout;
				jumpPC := std_logic_vector(to_unsigned(0, 6)) & IF_ID_OUT.instruction(25 downto 0);
				jumpedPC := std_logic_vector(unsigned(ID_EX_OUT.PC) + unsigned(jumpPC));
				PC_IN.PCin <= std_logic_vector(unsigned(ID_EX_OUT.PC) + 1) when pcSrc = '0' else jumpedPC;
			end if;
		end if;
	end process;
	
	process(clk)
	begin	
		if rising_edge(clk) then
			if reset = '0' then
				ID_EX_IN.RegAddr1 <= IF_ID_OUT.instruction(20 downto 16);
				ID_EX_IN.RegAddr2 <= IF_ID_OUT.instruction(15 downto 11);
				ID_EX_IN.SignExtImm <= std_logic_vector(resize(signed(IF_ID_OUT.instruction(15 downto 0)), 32));
				EX_MEM_IN.DestReg <= ID_EX_OUT.RegAddr1 when ID_EX_OUT.RegDst = '0' else ID_EX_OUT.RegAddr2;
				EX_MEM_IN.ReadData2 <= ID_EX_OUT.ReadData2;
				MEM_WB_IN.DestReg <= EX_MEM_OUT.DestReg;
				MEM_WB_IN.MemToReg <= EX_MEM_OUT.MemToReg;
				DM_IN.MemRead <= EX_MEM_OUT.MemRead;
				DM_IN.MemWrite <= EX_MEM_OUT.MemWrite;
				DM_IN.addr <= EX_MEM_OUT.ALUresult;
				DM_IN.data_in <= EX_MEM_OUT.ReadData2 when DM_IN.MemWrite = '1' else std_logic_vector(to_unsigned(0, 32));
				RB_IN.write_address <= MEM_WB_OUT.DestReg;
				ALU_IN.ALUop <= ID_EX_OUT.ALUop;
				ALU_IN.opA <= ID_EX_OUT.ReadData1;
				ALU_IN.opB <= ID_EX_OUT.ReadData2 when ID_EX_OUT.ALUsrc = '0' else ID_EX_OUT.SignExtImm;
				ALU_IN.funct <= IF_ID_OUT.instruction(5 downto 0);
				EX_MEM_IN.ALUresult <= ALU_OUT.ALUout;
				MEM_WB_IN.MemDataOut <= DM_OUT.data_out;
				MEM_WB_IN.ALUresult <= EX_MEM_OUT.ALUresult;
				RB_IN.write_data <= MEM_WB_OUT.ALUresult when MEM_WB_OUT.MemToReg = '0' else MEM_WB_OUT.MemDataOut;	
			end if;
		end if;
	end process;
	
	process(clk)
	begin
		if rising_edge(clk) then
			if reset = '0' then	
				pcSrc <= EX_MEM_OUT.zero and EX_MEM_OUT.Branch;
			end if;
		end if;
	end process;
end Behavioral;																							

	
	