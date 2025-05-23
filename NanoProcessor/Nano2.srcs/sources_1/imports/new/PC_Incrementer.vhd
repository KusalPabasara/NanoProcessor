library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_Incrementer is
    Port ( 
        PC_in  : in  STD_LOGIC_VECTOR (2 downto 0);
        PC_out : out STD_LOGIC_VECTOR (2 downto 0)
    );
end PC_Incrementer;

architecture Behavioral of PC_Incrementer is
    -- This is an optimized version since one input is always "001"
    -- It's more efficient than using a full 3-bit RCA when one input is constant
begin
    -- Optimized hardwired lookup table approach
    -- This is more efficient than instantiating a full 3-bit adder
    PC_out <= "001" when PC_in = "000" else
              "010" when PC_in = "001" else
              "011" when PC_in = "010" else
              "100" when PC_in = "011" else
              "101" when PC_in = "100" else
              "110" when PC_in = "101" else
              "111" when PC_in = "110" else
              "000";  -- Wrap around from 7 to 0
end Behavioral;
