library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.ControlUnitSignals.all;
use work.PCsignals.all;
use work.RegisterBankSignals.all;
use work.IF_ID_signals.all;

entity InstructionMemory_tb is
end InstructionMemory_tb;


architecture Behavioral of InstructionMemory_tb is
	
	component InstructionMemory is
		Port (
			clk: in std_logic;
			reset: in std_logic;
			addressMem: in std_logic_vector(31 downto 0);
			instructionMem: out std_logic_vector(31 downto 0)
		);
	end component;
	
	signal clk: std_logic := '0';
	signal reset: std_logic := '0';
	signal addressMem: std_logic_vector(31 downto 0) := (others => '0');
	signal instructionMem: std_logic_vector(31 downto 0) := (others => '0');
	
	signal CU_IN: ControlUnitInputSignals := (opcode => (others => '0'), zero => '0');
    signal CU_OUT: ControlUnitOutputSignals;
	
	signal PC_IN: PCInputs := initialPCInputs;
	signal PC_OUT: PCOutputs := initialPCOutputs;
	
	signal RB_IN: RegisterBankInputs := initialRBInputs;
	signal RB_OUT: RegisterBankOutputs := initialRBOutputs;
	
	signal IF_ID_IN: IF_ID_Inputs := initialIF_IDInputs;
	signal IF_ID_OUT: IF_ID_Outputs := initialIF_IDOutputs;
begin
	uut_IM: InstructionMemory
		Port map (
			clk => clk,
			reset => reset,
			addressMem => addressMem,
			instructionMem => instructionMem
		);
		
	uut_CU: entity work.ControlUnit
		Port map (
			clk => clk,
			reset => reset,
			CU_IN => CU_IN,
			CU_OUT => CU_OUT
		);
	
	uut_PC: entity work.PC
		Port map (
			clk => clk,
			reset => reset,
			PC_IN => PC_IN,
			PC_OUT => PC_OUT
		);
	
	uut_RB: entity work.RegisterBank32x32
		Port map (
			clk => clk,
			reset => reset,
			RB_IN => RB_IN,
			RB_OUT => RB_OUT
		);
	
	uut_IF_ID: entity work.IF_ID
		Port map (
			clk => clk,
			reset => reset,
			IF_ID_IN => IF_ID_IN,
			IF_ID_OUT => IF_ID_OUT
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
		reset <= '1';
		wait for 50 ns;
		reset <= '0';
		wait;
	end process;
	
	process(clk)
	begin
		if rising_edge(clk) then 
			if reset = '0' then 
				PC_IN.PCin <= std_logic_vector(unsigned(PC_OUT.PCout) + 1);
				addressMem <= PC_OUT.PCout;
				IF_ID_IN.PC <= PC_OUT.PCout;
				IF_ID_IN.instruction <= instructionMem; 
				CU_IN.opcode <= IF_ID_OUT.instruction(31 downto 26);
			end if;
		end if;
	end process;
end Behavioral;