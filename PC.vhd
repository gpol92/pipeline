library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		PCin: in std_logic_vector(31 downto 0);
		PCout: out std_logic_vector(31 downto 0)
	);
end PC;

architecture Behavioral of PC is
begin
	process(clk, reset)
	begin
		if reset = '1' then
			PCout <= (others => '0');
		elsif clk'event and clk = '1' then
			PCout <= PCin;
		end if;
	end process;
end Behavioral;