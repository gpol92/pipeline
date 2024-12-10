library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package PCSignals is
    -- Record per i segnali del PC
	
	component PC is
		Port (
			PCin: in std_logic_vector(31 downto 0);
			PCout: out std_logic_vector(31 downto 0)
		);
	end component;
	
    type PCSignals is record
        PCin: std_logic_vector(31 downto 0); -- Input del Program Counter
        PCout: std_logic_vector(31 downto 0); -- Output del Program Counter
    end record;
	
	constant initialPC: PCSignals := (
		PCin => (others => '0'),
		PCout => (others => '0')
	);
end package;