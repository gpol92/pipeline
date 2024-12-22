library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.R_Instruction.all;

entity InstructionMemory is
    Port (
        clk: in std_logic;
		reset: in std_logic;
        addressMem: in std_logic_vector(31 downto 0);
        instructionMem: out std_logic_vector(31 downto 0) := (others => '0')
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is
    type instruction_memory is array (0 to 255) of std_logic_vector(31 downto 0);
    signal instr_mem: instruction_memory := (others => (others => '0'));
    
    -- Procedura per caricare le istruzioni
    procedure load_R_instruction (
        signal mem: inout instruction_memory;
        opcode: std_logic_vector(5 downto 0);
        sourceReg1: std_logic_vector(4 downto 0);
        sourceReg2: std_logic_vector(4 downto 0);
        writeReg: std_logic_vector(4 downto 0);
        shiftAmount: std_logic_vector(4 downto 0);
        funct: std_logic_vector(5 downto 0);
        address: integer
    ) is
        variable instr: std_logic_vector(31 downto 0);
    begin
        instr := opcode & sourceReg1 & sourceReg2 & writeReg & shiftAmount & funct;
        mem(address) <= instr;
    end procedure;
	
	procedure load_I_instruction (
		signal mem: inout instruction_memory;
		opcode: in std_logic_vector(5 downto 0);
		sourceReg1: in std_logic_vector(4 downto 0);
		writeReg: in std_logic_vector(4 downto 0);
		immediate: in std_logic_vector(15 downto 0);
		address: integer
	)	
	is
		variable instr: std_logic_vector(31 downto 0);
	begin
		instr := opcode & sourceReg1 & writeReg & immediate;
		mem(address) <= instr;
	end procedure;
	
begin
    -- Caricamento iniziale delle istruzioni nella memoria
    process
    begin
        -- Chiama la procedura passando esplicitamente il segnale instr_mem
		load_I_instruction(
			mem => instr_mem,
			opcode => "000001",
			sourceReg1 => "00000",
			writeReg => "10000",
			immediate => "0000000000000100",
			address => 0
		);
		
		-- load_I_instruction(
			-- mem => instr_mem,
			-- opcode => "000001",
			-- sourceReg1 => "00000",
			-- writeReg => "10001",
			-- immediate => "0000000000000101",
			-- address => 1
		-- );
		
		-- load_R_instruction(
			-- mem => instr_mem,
			-- opcode => "000010",
			-- sourceReg1 => "10000",
			-- sourceReg2 => "10001",
			-- writeReg => "10010",
			-- shiftAmount => "00000",
			-- funct => "000010",
			-- address => 2
		-- );

		-- load_R_instruction(
			-- mem => instr_mem,
			-- opcode => "000010",
			-- sourceReg1 => "10000",
			-- sourceReg2 => "10001",
			-- writeReg => "10011",
			-- shiftAmount => "00000",
			-- funct => "000011",
			-- address => 3
		-- );	
		
		-- load_I_instruction(
			-- mem => instr_mem,
			-- opcode => "000001",
			-- sourceReg1 => "00000",
			-- writeReg => "01110",
			-- immediate => std_logic_vector(to_unsigned(1, 16)),
			-- address => 4
		-- );
		
		-- load_I_instruction(
			-- mem => instr_mem,
			-- opcode => "000001",
			-- sourceReg1 => "00000",
			-- writeReg => "01111",
			-- immediate => std_logic_vector(to_unsigned(1, 16)),
			-- address => 5
		-- );
		
		-- load_I_instruction(
			-- mem => instr_mem,
			-- opcode => "000011",
			-- sourceReg1 => "01110",
			-- writeReg => "01111",
			-- immediate => std_logic_vector(to_unsigned(1, 16)),
			-- address => 6
		-- );
		
		-- load_I_instruction(
			-- mem => instr_mem,
			-- opcode => "000100",
			-- sourceReg1 => "01110",
			-- writeReg => "01111",
			-- immediate => std_logic_vector(to_unsigned(4, 16)),
			-- address => 7
		-- );
        wait; -- Per interrompere il processo
    end process;

    process(clk, reset)
	begin
		if reset = '1' then
			instructionMem <= instr_mem(0); -- Carica la prima istruzione durante il reset
		elsif rising_edge(clk) then
			if addressMem = std_logic_vector(to_unsigned(0, 32)) then
				instructionMem <= instr_mem(0); -- Mantieni la prima istruzione se l'indirizzo è 0
			else
				instructionMem <= instr_mem(to_integer(unsigned(addressMem))); -- Leggi dalla memoria
			end if;
		end if;
end process;

end Behavioral;



--signal memory: memory_array := (
--		0 => b"00000100000100000000000000000100", -- addi r15, r0, 4
--		1 => b"00000100000100010000000000000101", -- addi r16, r0, 5
--		2 => b"00001010000100011001000000000010", -- add r17, r16, r15
--		3 => b"00001010000100011001100000000011", -- sub r18, r16, r15
--		4 => b"00000100000011100000000000000001", -- addi r13, r0, 1
--		5 => b"00000100000011110000000000000001", -- addi r14, r0, 1
--		6 => b"00001101110011110000000000000001", -- lw r14, 1(r13)
--		7 => b"00010001110011110000000000000100", -- sw r14, 4(r13)
--		8 => b"00010110000100111111111111111000", -- bne r15, r17, -8
--		9 => b"00011100000000000000000000000001", -- jump 1
--		others => b"00000000000000000000000000000000"
--); 