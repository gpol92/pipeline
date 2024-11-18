library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is
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

    process(currentState, opcode, zero) 
    begin
        case currentState is
            when FETCH =>
                ALUsrc <= 'X';
                ALUop <= "0000";
                RegDst <= 'X';
                RegWrite <= '0';
                nextState <= DECODE;
            when DECODE => 
                case opcode is    
                    when immOp =>
                        ALUsrc <= '1';
                        ALUop <= "0001";
                        RegDst <= '0';
                        RegWrite <= '1';
                        CU_MemRead <= 'X';
                        CU_MemToReg <= 'X';
                        CU_MemWrite <= 'X';
                        Branch <= 'X';
                    when arithOp =>
                        ALUsrc <= '0';
                        ALUop <= "0010";
                        RegDst <= '1';
                        RegWrite <= '1';
                        CU_MemRead <= '0';
                        CU_MemToReg <= '0';
                        CU_MemWrite <= '0';
                        Branch <= '0';
                    when loadOp =>
                        ALUsrc <= '1';
                        ALUop <= "0010";
                        RegDst <= '0';
                        RegWrite <= '1';
                        CU_MemRead <= '1';
                        CU_MemToReg <= '1';
                        CU_MemWrite <= '0';
                    when storeOp =>
                        ALUsrc <= '1';
                        ALUop <= "0010";
                        RegDst <= 'X';
                        RegWrite <= '0';
                        CU_MemRead <= '0';
                        CU_MemToReg <= 'X';
                        CU_MemWrite <= '1';
                        Branch <= '0';
                    when bneOp =>
                        ALUop <= "0011";
                        ALUsrc <= '0';
                        RegDst <= 'X';
                        RegWrite <= '0';
                        CU_MemRead <= '0';
                        CU_MemToReg <= '0';
                        CU_MemWrite <= '0';
                        Branch <= not zero;
                    when beqOp =>
                        ALUop <= "0011";
                        ALUsrc <= '0';
                        RegDst <= 'X';
                        RegWrite <= '0';
                        CU_MemRead <= '0';
                        CU_MemToReg <= '0';
                        CU_MemWrite <= '0';
                        Branch <= zero;
                    when others =>
                        ALUsrc <= 'X';
                        ALUop <= "0000";
                        RegDst <= 'X';
                        RegWrite <= '0';
                        CU_MemRead <= '0';
                        CU_MemToReg <= 'X';
                        CU_MemWrite <= '0';
                end case;
                nextState <= EXECUTE;
            when EXECUTE =>
                RegWrite <= '1';
                nextState <= MEMORY;
            when MEMORY =>
                nextState <= WRITE_BACK;
            when WRITE_BACK =>
                nextState <= FETCH;
            when others =>
                ALUsrc <= 'X';
                ALUop <= "0000";
                RegDst <= 'X';
                RegWrite <= '0';
                nextState <= FETCH;
        end case;
    end process;
end Behavioral;
