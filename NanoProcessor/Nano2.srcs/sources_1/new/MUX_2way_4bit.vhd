----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2025 02:00:29 AM
-- Design Name: 
-- Module Name: MUX_2way_4bit - Behavioral
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

entity MUX_2way_4bit is
    Port ( B0 : in STD_LOGIC_VECTOR (3 downto 0);--from  4bit add/sub unit
           B1 : in STD_LOGIC_VECTOR (3 downto 0);-- from instruction decoder. Immedaite value.
           LoadSel : in STD_LOGIC;-- from instruction decoder
           M2_4_out : out STD_LOGIC_VECTOR (3 downto 0));-- to register bank
end MUX_2way_4bit;

architecture Behavioral of MUX_2way_4bit is

begin

M2_4_out <= B0 when LoadSel = '0' else B1;

end Behavioral;

