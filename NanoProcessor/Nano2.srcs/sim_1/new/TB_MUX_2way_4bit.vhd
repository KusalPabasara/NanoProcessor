----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2025 02:08:05 AM
-- Design Name: 
-- Module Name: TB_MUX_2way_4bit - Behavioral
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

entity TB_MUX_2way_4bit is
--  Port ( );
end TB_MUX_2way_4bit;

architecture Behavioral of TB_MUX_2way_4bit is
component MUX_2way_4bit
port ( B0 : in STD_LOGIC_VECTOR (3 downto 0);
       B1 : in STD_LOGIC_VECTOR (3 downto 0);
       LoadSel : in STD_LOGIC;
       M2_4_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal B0 : STD_LOGIC_VECTOR (3 downto 0);
signal B1 : STD_LOGIC_VECTOR (3 downto 0);
signal LoadSel : STD_LOGIC;
signal M2_4_out : STD_LOGIC_VECTOR (3 downto 0);

begin
UUT: MUX_2way_4bit
port map( B0 => B0,
          B1 => B1,
          LoadSel => LoadSel,
          M2_4_out => M2_4_out);
process
begin
        LoadSel <= '0';
        B0 <= "0000";
        B1 <= "0010";
        
        wait for 100ns;
        LoadSel <= '1';
        B0 <= "0100";
        B1 <= "0110";
        
        wait for 100ns;
        LoadSel <= '0';
        B0 <= "1000";
        B1 <= "1010";
        
        wait for 100ns;
        LoadSel <= '1';
        B0 <= "1100";
        B1 <= "1110";
                
        wait for 100ns;    
        LoadSel <= '0';
        B0 <= "0000";
        B1 <= "0001";
        
        wait for 100ns;
        LoadSel <= '1';
        B0 <= "0100";
        B1 <= "0110";
        
        wait for 100ns;
        LoadSel <= '0';
        B0 <= "0100";
        B1 <= "1001";
        
        wait for 100ns;
        LoadSel <= '1';
        B0 <= "1010";
        B1 <= "1011";
        wait;
end process;    
end Behavioral;

