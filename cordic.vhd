library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cordic is 
	Port (
		angle_in: in signed(31 downto 0);
		posToNeg: out std_logic
	);
end cordic;

architecture Behavioral of cordic is
	type angles is array(0 to 6) of signed(31 downto 0);
	signal iterations: signed(4 downto 0) := "00000";
	signal iterations: angles := (
		0 => signed(45),
		1 => signed(26.565),
		2 => signed(14.036),
		3 => signed(7.125),
		4 => signed(3.576),
		5 => signed(1.790),
		6 => signed(0.895)
	);
begin
	process
	begin
		if angle_in >= 0 then
			angle_in <= angle_in - iterations(iteration);
		else
			angle_in <= angle_in + iterations(iteration);
		end if;
		iteration <= iteration + 1;
		wait for 10 ns;
	end process;
end Behavioral;