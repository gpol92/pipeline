library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ControlUnitSignals.all;

entity ControlUnit is
    Port (
        clk: in std_logic;
        reset: in std_logic;
        CU_IN: in ControlUnitSignals;
		CU_OUT: out ControlUnitSignals
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

    process(currentState, CU_IN.opcode, CU_IN.zero) 
    begin
        case currentState is
            when FETCH =>
                CU_OUT.ALUsrc <= 'X';
                CU_OUT.ALUop <= "0000";
                CU_OUT.RegDst <= 'X';
                CU_OUT.RegWrite <= '0';
                nextState <= DECODE;
            when DECODE => 
                case CU_IN.opcode is    
                    when immOp =>
                        CU_OUT.ALUsrc <= '1';
                        CU_OUT.ALUop <= "0001";
                        CU_OUT.RegDst <= '0';
                        CU_OUT.RegWrite <= '1';
                        CU_OUT.CU_MemRead <= 'X';
                        CU_OUT.CU_MemToReg <= 'X';
                        CU_OUT.CU_MemWrite <= 'X';
                        CU_OUT.Branch <= 'X';
                    when arithOp =>
                        CU_OUT.ALUsrc <= '0';
                        CU_OUT.ALUop <= "0010";
                        CU_OUT.RegDst <= '1';
                        CU_OUT.RegWrite <= '1';
                        CU_OUT.CU_MemRead <= '0';
                        CU_OUT.CU_MemToReg <= '0';
                        CU_OUT.CU_MemWrite <= '0';
                        CU_OUT.Branch <= '0';
                    when loadOp =>
                        CU_OUT.ALUsrc <= '1';
                        CU_OUT.ALUop <= "0010";
                        CU_OUT.RegDst <= '0';
                        CU_OUT.RegWrite <= '1';
                        CU_OUT.CU_MemRead <= '1';
                        CU_OUT.CU_MemToReg <= '1';
                        CU_OUT.CU_MemWrite <= '0';
                    when storeOp =>
                        CU_OUT.ALUsrc <= '1';
                        CU_OUT.ALUop <= "0010";
                        CU_OUT.RegDst <= 'X';
                        CU_OUT.RegWrite <= '0';
                        CU_OUT.CU_MemRead <= '0';
                        CU_OUT.CU_MemToReg <= 'X';
                        CU_OUT.CU_MemWrite <= '1';
                        CU_OUT.Branch <= '0';
                    when bneOp =>
                        CU_OUT.ALUop <= "0011";
                        CU_OUT.ALUsrc <= '0';
                        CU_OUT.RegDst <= 'X';
                        CU_OUT.RegWrite <= '0';
                        CU_OUT.CU_MemRead <= '0';
                        CU_OUT.CU_MemToReg <= '0';
                        CU_OUT.CU_MemWrite <= '0';
                        CU_OUT.Branch <= not CU_OUT.zero;
                    when beqOp =>
                        CU_OUT.ALUop <= "0011";
                        CU_OUT.ALUsrc <= '0';
                        CU_OUT.RegDst <= 'X';
                        CU_OUT.RegWrite <= '0';
                        CU_OUT.CU_MemRead <= '0';
                        CU_OUT.CU_MemToReg <= '0';
                        CU_OUT.CU_MemWrite <= '0';
                        CU_OUT.Branch <= CU_OUT.zero;
                    when others =>
                        CU_OUT.ALUsrc <= 'X';
                        CU_OUT.ALUop <= "0000";
                        CU_OUT.RegDst <= 'X';
                        CU_OUT.RegWrite <= '0';
                        CU_OUT.CU_MemRead <= '0';
                        CU_OUT.CU_MemToReg <= 'X';
                        CU_OUT.CU_MemWrite <= '0';
                end case;
                nextState <= EXECUTE;
            when EXECUTE =>
                CU_OUT.RegWrite <= '1';
                nextState <= MEMORY;
            when MEMORY =>
                nextState <= WRITE_BACK;
            when WRITE_BACK =>
                nextState <= FETCH;
            when others =>
                CU_OUT.ALUsrc <= 'X';
                CU_OUT.ALUop <= "0000";
                CU_OUT.RegDst <= 'X';
                CU_OUT.RegWrite <= '0';
                nextState <= FETCH;
        end case;
    end process;
end Behavioral;
