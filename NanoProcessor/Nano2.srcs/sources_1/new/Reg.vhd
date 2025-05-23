----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 03:03:28 AM
-- Design Name: 
-- Module Name: Reg - Behavioral
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

entity Reg is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           En : in STD_LOGIC; --comes from 3-8 decoder
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end Reg;

architecture Behavioral of Reg is

begin

process (Clk, Reset) begin
 if (Reset = '1') then 
   Q <= (others => '0'); -- reset Q to all zeros. Whenever Reset=1, this is executed regardless of the value of clock.  
 elsif (rising_edge(Clk)) then -- respond when clock rises
   if En = '1' then -- Enable should be set
     Q <= D;
   end if;
 end if;
end process;

end Behavioral;


