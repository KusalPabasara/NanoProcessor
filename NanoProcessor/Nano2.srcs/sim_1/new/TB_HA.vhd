library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_HA is
--  Port ( );
end TB_HA;

architecture Behavioral of TB_HA is
  component HA
     port(
       A,B : in std_logic; 
       S,C : out std_logic 
     );
  end component;
  
  signal A,B : std_logic;
  signal S,C : std_logic;
     
begin
UUT: HA port map(
        A => A,
        B => B,
        C => C,
        S =>S
);

process
begin
  A <= '0';
  B <= '0';
  wait for 100 ns;
 
  A <= '1';
  wait for 100 ns;
 
  A <= '0';
  B <= '1';
  wait for 100 ns;
 
  A <= '1';
  wait;
end process;
 
end Behavioral;
