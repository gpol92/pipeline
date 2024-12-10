library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PCSignals.all;

entity PC is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		PC_IN: in PCSignals;
		PC_OUT: out PCSignals
	);
end PC;

architecture Behavioral of PC is
begin
	process(clk, reset)
	begin
		if reset = '1' then
			PC_OUT.PCout <= (others => '0');
			PC_OUT.PCin <= (others => '0');
		elsif clk'event and clk = '1' then
			PC_OUT.PCin <= PC_IN.PCin;
			PC_OUT.PCout <= PC_OUT.PCin;
		end if;
	end process;
end Behavioral;