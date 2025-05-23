----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 02:58:49 AM
-- Design Name: 
-- Module Name: TB_Decoder_2_to_4 - Behavioral
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

entity TB_Decoder_2_to_4 is
--  Port ( );
end TB_Decoder_2_to_4;

architecture Behavioral of TB_Decoder_2_to_4 is
   component Decoder_2_to_4 
     Port ( I : in STD_LOGIC_VECTOR (1 downto 0);
            EN : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR (3 downto 0));
   end component;
   
   signal I : std_logic_vector(1 downto 0);
   signal EN : std_logic;
   signal Y : std_logic_vector(3 downto 0);
      
begin

UUT: Decoder_2_to_4 PORT MAP(
     I => I,
     EN => EN,
     Y => Y
);

process 
begin
   EN <= '1';
   I <= "00";
   wait for 100 ns;
   I <= "01";
   wait for 100 ns;
   I <= "10";
   wait for 100 ns;
   I <= "11";
   wait for 100 ns;
   
   EN <= '0';
   wait for 100 ns; 
   I <= "00";
   wait for 100 ns;
   I <= "01";      
   wait for 100 ns;
   I <= "10"; 
   wait for 100 ns;
   I <= "11"; 
   wait;
end process;              
                    
                         
end Behavioral;    

