library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterBank32x32 is
	port (
		clk: in std_logic;
		reset: in std_logic;
		RegWrite: in std_logic;
		write_data: in std_logic_vector(31 downto 0);
		read_address1: in std_logic_vector(4 downto 0);
		read_address2: in std_logic_vector(4 downto 0);
		write_address: in std_logic_vector(4 downto 0);
		read_data1: out std_logic_vector(31 downto 0);
		read_data2: out std_logic_vector(31 downto 0)
	);
end RegisterBank32x32;

architecture Behavioral of RegisterBank32x32 is
	type reg_array is array (31 downto 0) of std_logic_vector(31 downto 0);
	signal registers: reg_array := (
		0 => (1 => '1', 4 => '1', others => '0'),
		2 => (0 => '1', 3 => '1', others => '0'),
		14 => (0 => '1', 1 => '1', others => '0'),
		others => (others => '0')
	);
begin
	process(clk)
	begin
		if reset = '1' then
			-- Azzeramento di tutti i registri in caso di reset
			for i in 0 to 31 loop
				registers(i) <= (others => '0');
			end loop;
		elsif rising_edge(clk) then
			-- Scrittura nel registro selezionato se abilitata
			if RegWrite = '1' then
				if write_address /= "00000" then
					registers(to_integer(unsigned(write_address))) <= write_data;
				else
					registers(0) <= (others => '0');
				end if;
			end if;
		end if;
	end process;
	-- Lettura dai registri

	read_data1 <= registers(to_integer(unsigned(read_address1)));
	read_data2 <= registers(to_integer(unsigned(read_address2)));

end Behavioral;
