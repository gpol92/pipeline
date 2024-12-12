library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.RegisterBankSignals.all;

entity RegisterBank32x32 is
	port (
		clk   : in std_logic;
		reset : in std_logic;
		RB_IN : in RegisterBankInputs;
		RB_OUT : out RegisterBankOutputs
	);
end RegisterBank32x32;

architecture Behavioral of RegisterBank32x32 is
	type reg_array is array (31 downto 0) of std_logic_vector(31 downto 0);
	signal registers: reg_array := (others => (others => '0'));
begin
	process(clk)
	begin
		if reset = '1' then
			-- Azzeramento di tutti i registri in caso di reset
			registers <= (others => (others => '0'));
		elsif rising_edge(clk) then
			-- Scrittura nel registro selezionato se abilitata
			if RB_IN.RegWrite = '1' and RB_IN.write_address /= "00000" then
				registers(to_integer(unsigned(RB_IN.write_address))) <= RB_IN.write_data;
			end if;
		end if;
	end process;

	-- Lettura dai registri
	RB_OUT.read_data1 <= registers(to_integer(unsigned(RB_IN.read_address1)));
	RB_OUT.read_data2 <= registers(to_integer(unsigned(RB_IN.read_address2)));

end Behavioral;
