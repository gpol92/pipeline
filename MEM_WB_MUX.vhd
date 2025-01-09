library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEM_WB_MUX is
	Port (
		MemToReg: in std_logic;
		MemDataOut: in std_logic_vector(31 downto 0);
		ALUresult: in std_logic_vector(31 downto 0);
		MUXout: out std_logic_vector(31 downto 0)
	);
end MEM_WB_MUX;

architecture Behavioral of MEM_WB_MUX is
	
begin
	process(MemToReg, MemDataOut, ALUresult)
	begin
		case MemToReg is
			when '1' => 
				MUXout <= MemDataOut;
			when '0' => 
				MUXout <= ALUresult;
			when others => 
				MUXout <= (others => '0');
		end case;
	end process;
end Behavioral;