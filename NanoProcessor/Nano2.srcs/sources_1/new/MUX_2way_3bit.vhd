library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2way_3bit is
    Port ( A0 : in STD_LOGIC_VECTOR (2 downto 0);--  from 3 bit adder
           A1 : in STD_LOGIC_VECTOR (2 downto 0);--  from instruction decoder. indicates the address to jump.
           JMP_FLAG : in STD_LOGIC; --  selection signal
           M2_3_out : out STD_LOGIC_VECTOR (2 downto 0));
end MUX_2way_3bit;

architecture Behavioral of MUX_2way_3bit is
begin
 
M2_3_out <= A0 when JMP_FLAG = '0' else A1;

end Behavioral;
