library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ForwardingUnit is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		RegWrite: in std_logic;
		ID_EX_RegAddr1: in std_logic_vector(4 downto 0);
		ID_EX_RegAddr2: in std_logic_vector(4 downto 0);
		EX_MEM_DestReg: in std_logic_vector(4 downto 0);
		MEM_WB_DestReg: in std_logic_vector(4 downto 0);
		forwardA: out std_logic_vector(1 downto 0);
		forwardB: out std_logic_vector(1 downto 0)
	);
end ForwardingUnit;

architecture Behavioral of ForwardingUnit is
begin
	process(clk)
	begin
		if reset = '1' then
			forwardA <= "00";
			forwardB <= "00";
		elsif rising_edge(clk) then
			
			if RegWrite = '1' then
				-- Forwarding for A
				if ID_EX_RegAddr1 = EX_MEM_DestReg and EX_MEM_DestReg /= "00000" then
					forwardA <= "10";
				elsif ID_EX_RegAddr1 = MEM_WB_DestReg and MEM_WB_DestReg /= "00000" then
					forwardA <= "01";
				else
					forwardA <= "00";
				end if;

				-- Forwarding for B
				if ID_EX_RegAddr2 = EX_MEM_DestReg and EX_MEM_DestReg /= "00000" then
					forwardB <= "10";
				elsif ID_EX_RegAddr2 = MEM_WB_DestReg and MEM_WB_DestReg /= "00000" then
					forwardB <= "01";
				else
					forwardB <= "00";
				end if;
			end if;
		end if;
	end process;
end Behavioral;
