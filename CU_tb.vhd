library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit_tb is
-- Nessun port poiché è un testbench.
end ControlUnit_tb;

architecture Behavioral of ControlUnit_tb is
    -- Dichiarazione di segnali di test
    signal clk: std_logic := '0';
    signal reset: std_logic := '0';
    signal CU_IN: ControlUnitInputSignals := (opcode => (others => '0'), zero => '0');
    signal CU_OUT: ControlUnitOutputSignals;

    -- Clock period constant
    constant clk_period: time := 10 ns;

begin
    -- Istanza della Control Unit
    uut: entity work.ControlUnit
        port map (
            clk => clk,
            reset => reset,
            CU_IN => CU_IN,
            CU_OUT => CU_OUT
        );

    -- Processo per generare il clock
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Processo per fornire stimoli
    stimulus_process: process
    begin
        -- Reset iniziale
        reset <= '1';
        wait for clk_period * 2;
        reset <= '0';

        -- Test FETCH -> DECODE
        CU_IN.opcode <= "000001"; -- immOp
        wait for clk_period * 2;

        -- Test DECODE -> EXECUTE
        CU_IN.opcode <= "000010"; -- arithOp
        wait for clk_period * 2;

        -- Test DECODE -> MEMORY
        CU_IN.opcode <= "000011"; -- loadOp
        wait for clk_period * 2;

        -- Test MEMORY -> WRITE_BACK
        CU_IN.opcode <= "000011"; -- loadOp (simula memoria)
        wait for clk_period * 2;

        -- Test DECODE -> FETCH (unknown opcode)
        CU_IN.opcode <= "111111"; -- unknown opcode
        wait for clk_period * 2;

        -- Termina la simulazione
        wait;
    end process;
end Behavioral;
