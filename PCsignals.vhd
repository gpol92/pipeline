library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package PCSignals is
    -- Tipo per gli ingressi del Program Counter
    type PCInputs is record
        PCin: std_logic_vector(31 downto 0); -- Input del Program Counter
    end record;

    -- Tipo per le uscite del Program Counter
    type PCOutputs is record
        PCout: std_logic_vector(31 downto 0); -- Output del Program Counter
    end record;

    -- Definizione del componente PC
    component PC is
        Port (
            PCin: in std_logic_vector(31 downto 0);
            PCout: out std_logic_vector(31 downto 0)
        );
    end component;

    -- Costanti iniziali
    constant initialPCInputs: PCInputs := (
        PCin => (others => '0')
    );

    constant initialPCOutputs: PCOutputs := (
        PCout => (others => '0')
    );

end package;
