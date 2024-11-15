library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		opcode: in std_logic_vector(5 downto 0);
		zero: in std_logic;
		pcSrc: out std_logic;
		ALUsrc: out std_logic;
		ALUop: out std_logic_vector(3 downto 0);
		regDst: out std_logic;
		regWrite: out std_logic;
		MemToReg: out std_logic;
		MemRead: out std_logic;
		MemWrite: out std_logic;
		Branch: out std_logic
	);
end ControlUnit;

architecture Behavioral of ControlUnit is
	type state is (FETCH, DECODE, EXECUTE, MEMORY, WRITE_BACK);
	signal currentState, nextState: state;
	
	constant immOp: std_logic_vector(5 downto 0) := "000001";
	constant arithOp: std_logic_vector(5 downto 0) := "000010";
	constant loadOp: std_logic_vector(5 downto 0) := "000011";
	constant storeOp: std_logic_vector(5 downto 0) := "000100";
	constant bneOp: std_logic_vector(5 downto 0) := "000101";
	constant beqOp: std_logic_vector(5 downto 0) := "000110";
	constant jumpOp: std_logic_vector(5 downto 0) := "000111";
begin	
	process(clk)
	begin
		if rising_edge(clk) then
			if reset = '1' then	
				currentState <= FETCH;
			else
				currentState <= nextState;
			end if;
		end if;
	end process;

	process(currentState, opcode, regWrite) 
	begin
		case currentState is
			when FETCH =>
				pcSrc <= '0';
				ALUsrc <= 'X';
				ALUop <= "0000";
				regDst <= 'X';
				regWrite <= '0';
				nextState <= DECODE;
			when DECODE => 
				case opcode is	
					when immOp =>
						ALUsrc <= '1';
						ALUop <= "0001";
						regDst <= '0';
						regWrite <= '1';
						MemRead <= 'X';
						MemToReg <= 'X';
						MemWrite <= 'X';
						Branch <= 'X';
					when arithOp =>
						ALUsrc <= '0';
						ALUop <= "0010";
						regDst <= '1';
						regWrite <= '1';
						MemRead <= '0';
						MemToReg <= '0';
						MemWrite <= '0';
						Branch <= '0';
					when loadOp =>
						ALUsrc <= '1';
						ALUop <= "0010";
						RegDst <= '0';
						RegWrite <= '1';
						MemRead <= '1';
						MemToReg <= '1';
						MemWrite <= '0';
					when bneOp =>
						ALUop <= "0011";
						ALUsrc <= '0';
						RegDst <= 'X';
						RegWrite <= '0';
						MemRead <= '0';
						MemToReg <= '0';
						MemWrite <= '0';
						if zero = '0' then
							Branch <= '0';
						elsif zero = '1' then 
							Branch <= '1';
						end if;
					when beqOp =>
						ALUop <= "0011";
						ALUsrc <= '0';
						RegDst <= 'X';
						RegWrite <= '0';
						MemRead <= '0';
						MemToReg <= '0';
						MemWrite <= '0';
						if zero = '0' then
							Branch <= '1';
						elsif zero = '1' then 
							Branch <= '0';
						end if;
					when others =>
						ALUsrc <= 'X';
						ALUop <= "0000";
						RegDst <= 'X';
						RegWrite <= '0';
						MemRead <= '0';
						MemToReg <= 'X';
						MemWrite <= '0';
				end case;
				nextState <= EXECUTE;
			when EXECUTE =>
				pcSrc <= '0';
				ALUsrc <= ALUsrc;
				ALUop <= "0000";
				regDst <= regDst;
				regWrite <= '1';
				nextState <= FETCH;
			when others =>
				pcSrc <= '0';
				ALUsrc <= 'X';
				ALUop <= "0000";
				regDst <= 'X';
				regWrite <= '0';
				nextState <= FETCH;
		end case;
	end process;
end Behavioral;
