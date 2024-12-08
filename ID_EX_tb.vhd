library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ID_EX_signals.all;

entity ID_EX_tb is
end ID_EX_tb;

architecture Behavioral of ID_EX_tb is
	signal ID_EX_IN: ID_EX_signals;
	signal ID_EX_OUT: ID_EX_signals;
	signal clk: std_logic := '0';
	signal reset: std_logic := '1';
begin
	uut: entity work.ID_EX
		Port map (
			clk => clk,
			reset => reset,
			ID_EX_IN => ID_EX_IN,
			ID_EX_OUT => ID_EX_OUT
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
	
	process
	begin
		ID_EX_IN.PC <= std_logic_vector(to_unsigned(0, 32));
		ID_EX_IN.instruction <= "00000100000100000000000000000100";
		ID_EX_IN.ReadData1 <= std_logic_vector(to_unsigned(0, 32));
		ID_EX_IN.ReadData2 <= std_logic_vector(to_unsigned(0, 32));
		ID_EX_IN.SignExtImm <= std_logic_vector(to_unsigned(4, 32));
		ID_EX_IN.RegAddr1 <= std_logic_vector(to_unsigned(0, 5));
		ID_EX_IN.RegAddr2 <= std_logic_vector(to_unsigned(16, 5));
		ID_EX_IN.RegDst <= '0';
		ID_EX_IN.ALUsrc <= '1';
		ID_EX_IN.MemToReg <= '0';
		ID_EX_IN.RegWrite <= '1';
		ID_EX_IN.MemRead <= '0';
		ID_EX_IN.MemWrite <= '0';
		ID_EX_IN.Branch <= '0';
		ID_EX_IN.ALUop <= "0001";
		wait for 20 ns;
		ID_EX_IN.PC <= std_logic_vector(unsigned(ID_EX_IN.PC) + 1);
		ID_EX_IN.instruction <= "00000100000100010000000000000101";
		ID_EX_IN.ReadData1 <= std_logic_vector(to_unsigned(0, 32));
		ID_EX_IN.ReadData2 <= std_logic_vector(to_unsigned(0, 32));
		ID_EX_IN.RegAddr1 <= std_logic_vector(to_unsigned(0, 5));
		ID_EX_IN.RegAddr2 <= std_logic_vector(to_unsigned(17, 5));
		ID_EX_IN.RegDst <= '0';
		ID_EX_IN.ALUsrc <= '1';
		ID_EX_IN.MemToReg <= '0';
		ID_EX_IN.RegWrite <= '1';
		ID_EX_IN.MemRead <= '0';
		ID_EX_IN.MemWrite <= '0';
		ID_EX_IN.Branch <= '0';
		ID_EX_IN.ALUop <= "0001";
		wait for 20 ns;
		ID_EX_IN.PC <= std_logic_vector(unsigned(ID_EX_IN.PC) + 1);
		ID_EX_IN.instruction <= "00001010000100011001000000000010"
		ID_EX_IN.ReadData1 <= std_logic_vector(to_unsigned(0, 32));
		ID_EX_IN.ReadData2 <= std_logic_vector(to_unsigned(17, 32));
		ID_EX_IN.RegAddr1 <= std_logic_vector(to_unsigned(0, 5));
		ID_EX_IN.RegAddr2 <= std_logic_vector(to_unsigned(17, 5));
		ID_EX_IN.RegDst <= '0';
		ID_EX_IN.ALUsrc <= '1';
		ID_EX_IN.MemToReg <= '0';
		ID_EX_IN.RegWrite <= '1';
		ID_EX_IN.MemRead <= '0';
		ID_EX_IN.MemWrite <= '0';
		ID_EX_IN.Branch <= '0';
		ID_EX_IN.ALUop <= "0001";
		wait;
	end process;
end Behavioral;