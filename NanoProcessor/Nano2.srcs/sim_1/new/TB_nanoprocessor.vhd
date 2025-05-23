----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 03:11:34 AM
-- Design Name: 
-- Module Name: TB_nanoprocessor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_nanoprocessor is
--  Port ( );
end TB_nanoprocessor;

architecture Behavioral of TB_nanoprocessor is
component nanoprocessor is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           R7_OUT : out STD_LOGIC_VECTOR (3 downto 0);--for LEDs
           R7_7Seg : out STD_LOGIC_VECTOR (6 downto 0);-- for 7segment display
           CarryFlag : out STD_LOGIC;
           SignFlag : out STD_LOGIC; 
           Zero : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           anode: out STD_LOGIC_VECTOR(3 downto 0)
           );
end component;

       signal Reset : STD_LOGIC;
       signal R7_OUT,anode : STD_LOGIC_VECTOR (3 downto 0);
       signal R7_7Seg : STD_LOGIC_VECTOR (6 downto 0);
       signal CarryFlag : STD_LOGIC;
       signal SignFlag : STD_LOGIC;
       signal Zero : STD_LOGIC;
       signal Overflow : STD_LOGIC;
       constant time_period : time := 10 ns; 
       signal Clk : std_logic := '1';
       
begin
UUT:nanoprocessor port map(
       Clk => Clk,
       Reset => Reset,
       R7_OUT => R7_OUT,
       R7_7Seg => R7_7Seg,
       CarryFlag => CarryFlag,
       SignFlag => SignFlag,
       Zero => Zero,
       Overflow => Overflow,
       anode => anode
       );
 
  process
  begin
   wait for time_period/2;
   Clk <= not(Clk); 
  end process;
  
  process
  begin
   Reset<='1';
   wait for 100ns;
   Reset<='0';    
   wait;
  end process;
 

end Behavioral;


