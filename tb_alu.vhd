library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ALUSignals.all;

entity tb_alu is
end tb_alu;

architecture Behavioral of tb_alu is
    -- Segnali per il record
    signal ALU_IN: ALUSignals;
    signal ALU_OUT: ALUSignals;

begin
    -- Istanza del componente ALU
    uut: entity work.ALU
        port map (
            ALU_IN => ALU_IN,
            ALU_OUT => ALU_OUT
        );

    -- Processo di generazione degli stimoli
    process
    begin
        -- Test 1: Pass-through
        ALU_IN.opA <= "00000000000000000000000000000100";
        ALU_IN.opB <= "00000000000000000000000000000101";
        ALU_IN.ALUop <= "0000";  -- Pass-through
        ALU_IN.funct <= "0000";
        wait for 10 ns;

        -- Test 2: Addizione
        ALU_IN.ALUop <= "0001";  -- Addizione
        wait for 10 ns;

        -- Test 3: Funzioni con ALUop = "0010"
        ALU_IN.ALUop <= "0010";
        ALU_IN.funct <= "0010";  -- Addizione
        wait for 10 ns;

        ALU_IN.funct <= "0011";  -- Sottrazione
        wait for 10 ns;

        -- Test 4: Confronto
        ALU_IN.ALUop <= "0011";
        ALU_IN.opA <= "00000000000000000000000000000101";
        ALU_IN.opB <= "00000000000000000000000000000101";  -- Uguali
        wait for 10 ns;

        ALU_IN.opB <= "00000000000000000000000000000100";  -- Diversi
        wait for 10 ns;

        -- Fine della simulazione
        report "End of Simulation" severity note;
        wait;
    end process;

end Behavioral;
