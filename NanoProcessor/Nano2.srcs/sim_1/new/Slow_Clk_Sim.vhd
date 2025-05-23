library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Slow_Clk_Sim is
--  Port ( );
end Slow_Clk_Sim;

architecture Behavioral of Slow_Clk_Sim is

 component Slow_Clk is
     Port ( Clk_in : in STD_LOGIC;
            Clk_out : out STD_LOGIC);
 end component;
 
 signal Clk_in : std_logic := '0';
 signal Clk_out : std_logic;
 constant time_period : time := 10 ns; 

begin

UUT: Slow_Clk
   port map(
     Clk_in => Clk_in,
     Clk_out => Clk_out
   );

process  
begin
 wait for time_period / 2;                              
 Clk_in <= not Clk_in;
end process;


end Behavioral;
