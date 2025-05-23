library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_FA is
--  Port ( );
end TB_FA;

architecture Behavioral of TB_FA is
 component FA
    port(
       A, B, C_in : in std_logic;
       S, C_out : out std_logic 
    );
 end component;   
 
 signal A,B,C_in : std_logic;
 signal S,C_out : std_logic;
 
begin
UUT:FA port map(
       A => A,
       B => B,
       C_in => C_in,
       S => S,
       C_out => C_out
);

process
begin
  A <= '0';
  B <= '0';
  C_in <= '0';
  
  wait for 100 ns;
  A <= '1';
  wait for 100 ns;
  A <= '0';
  B <= '1';
  wait for 100 ns;
  A <= '1';
  wait for 100 ns;
  A <= '0';
  B <= '0';
  C_in <= '1';
  
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
