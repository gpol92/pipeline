library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Regist3r is
	Port (
		D: in std_logic_vector(31 downto 0);
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic_vector(31 downto 0)
	);
end Regist3r;

architecture Behavioral of Regist3r is

begin
	process(clk)
	begin
		if rising_edge(clk) then
			if (reset = '1') then
				Q <= std_logic_vector(to_unsigned(0, 32));
			else
				Q <= D;
			end if;
		end if;
	end process;
end Behavioral;