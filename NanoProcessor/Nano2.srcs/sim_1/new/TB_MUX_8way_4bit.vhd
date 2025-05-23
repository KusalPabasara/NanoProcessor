----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2025 02:11:55 AM
-- Design Name: 
-- Module Name: TB_MUX_8way_4bit - Behavioral
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

entity TB_MUX_8way_4bit is
--  Port ( );
end TB_MUX_8way_4bit;

architecture Behavioral of TB_MUX_8way_4bit is
component MUX_8way_4bit
    Port ( R0 : in STD_LOGIC_VECTOR (3 downto 0);
       R1 : in STD_LOGIC_VECTOR (3 downto 0);
       R2 : in STD_LOGIC_VECTOR (3 downto 0);
       R3 : in STD_LOGIC_VECTOR (3 downto 0);
       R4 : in STD_LOGIC_VECTOR (3 downto 0);
       R5 : in STD_LOGIC_VECTOR (3 downto 0);
       R6 : in STD_LOGIC_VECTOR (3 downto 0);
       R7 : in STD_LOGIC_VECTOR (3 downto 0);
       Sel : in STD_LOGIC_VECTOR (2 downto 0);
       M8_4_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;
signal R0,R1,R2,R3,R4,R5,R6,R7: STD_LOGIC_VECTOR (3 downto 0);
signal Sel: STD_LOGIC_VECTOR (2 downto 0);
signal M8_4_out: STD_LOGIC_VECTOR (3 downto 0);
begin
UUT:MUX_8way_4bit
port map(R0 => R0,
         R1 => R1,
         R2 => R2,
         R3 => R3,
         R4 => R4,
         R5 => R5,
         R6 => R6,
         R7 => R7,
         Sel => Sel,
         M8_4_out => M8_4_out);

process
begin
        R0 <= "0000";
        R1 <= "0011";
        R2 <= "0110";
        R3 <= "1100";
        R4 <= "1000";
        R5 <= "0100";
        R6 <= "0010";
        R7 <= "0001";
        Sel <= "000";
        
        wait for 100ns;
        Sel <= "000";

        wait for 100ns;
        Sel <= "001";
        
        wait for 100ns;
        Sel <= "010";
        
        wait for 100ns;
        Sel <= "011";

        wait for 100ns;
        Sel <= "100";
        
        wait for 100ns;
        Sel <= "101";
        
        wait for 100ns;
        Sel <= "110";
        
        wait for 100ns;
        Sel <= "111"; 
        wait;
end process;                                      
end Behavioral;

