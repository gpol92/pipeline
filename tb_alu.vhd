library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ALUSignals.all;
use work.RegisterBankSignals.all;


entity tb_alu is
end tb_alu;

architecture Behavioral of tb_alu is
    -- Segnali per il record
    signal ALU_IN: ALUInputSignals;
    signal ALU_OUT: ALUOutputSignals;
	signal clk: std_logic := '0';
	signal reset: std_logic := '1';
	-- Segnale per controllare l'inclusione del register file.
	constant INCLUDE_REGISTER_FILE: boolean := true;
begin
    -- Istanza del componente ALU
    uut: entity work.ALU
        port map (
            ALU_IN => ALU_IN,
            ALU_OUT => ALU_OUT
        );
	-- Includi in maniera condizionale il register file
	gen_register_file: if INCLUDE_REGISTER_FILE generate
		signal RB_IN: RegisterBankInputs;
		signal RB_OUT: RegisterBankOutputs;
		
		-- Istanza del componente register file
		uut_RF: entity work.RegisterBank32x32
			port map (
				clk => clk,
				reset => reset,
				RB_IN => RB_IN,
				RB_OUT => RB_OUT
			);
		-- Connect RegisterFile signals to ALU signals
		RB_IN.RegWrite <= '1';
		RB_OUT.read_data1 <= ALU_IN.opA;
		RB_OUT.read_data2 <= std_logic_vector(to_unsigned(4, 32));
		RB_IN.write_data <= ALU_OUT.ALUout;
	end generate;
	
	process 
	begin
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
		wait for 10 ns;
	end process;
	
	process
	begin 
		reset <= '1';
		wait for 50 ns;
		reset <= '0';
		wait;
	end process;
	-- Processo di generazione degli stimoli
    process
    begin
        -- Test 1: Pass-through
        ALU_IN.opA <= "00000000000000000000000000000100";
        ALU_IN.opB <= "00000000000000000000000000000101";
        ALU_IN.ALUop <= "0000";  -- Pass-through
        ALU_IN.funct <= "000000";
        wait for 10 ns;

        -- Test 2: Addizione
        ALU_IN.ALUop <= "0001";  -- Addizione
        wait for 10 ns;

        -- Test 3: Funzioni con ALUop = "0010"
        ALU_IN.ALUop <= "0010";
        ALU_IN.funct <= "000010";  -- Addizione
        wait for 10 ns;

        ALU_IN.funct <= "000011";  -- Sottrazione
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
