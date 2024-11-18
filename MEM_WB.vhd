library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEM_WB is
	Port (
		clk: in std_logic;
		reset: in std_logic;
		MEM_MemToReg: in std_logic;
		MEM_MemDataOut: in std_logic_vector(31 downto 0);
		MEM_ALUresult: in std_logic_vector(31 downto 0);
		WB_MemToReg: out std_logic;
		WB_MemDataOut: out std_logic_vector(31 downto 0);
		WB_ALUresult: out std_logic_vector(31 downto 0)
	);
end MEM_WB;

architecture Behavioral of MEM_WB is
	signal MemToReg_reg: std_logic;
	signal MemDataOut_reg: std_logic_vector(31 downto 0);
	signal ALUresult_reg: std_logic_vector(31 downto 0);
begin
	process(clk, reset)
	begin
		if reset = '1' then
			MemToReg_reg <= '0';
			MemDataOut_reg <= (others => '0');
			ALUresult_reg <= (others => '0');
		elsif rising_edge(clk) then
			MemToReg_reg <= MEM_MemToReg;
			MemDataOut_reg <= MEM_MemDataOut;
			ALUresult_reg <= MEM_ALUresult;
		end if;
	end process;
	
	WB_MemToReg <= MemToReg_reg;
	WB_MemDataOut <= MemDataOut_reg;
	WB_ALUresult <= ALUresult_reg;
end Behavioral;