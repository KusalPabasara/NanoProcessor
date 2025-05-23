----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 03:01:11 AM
-- Design Name: 
-- Module Name: TB_Decoder_3_to_8 - Behavioral
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

entity TB_Decoder_3_to_8 is
--  Port ( );
end TB_Decoder_3_to_8;

architecture Behavioral of TB_Decoder_3_to_8 is
 component Decoder_3_to_8
  Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
         EN : in STD_LOGIC;
         Y : out STD_LOGIC_VECTOR (7 downto 0));
 end component;
 
 signal I : std_logic_vector(2 downto 0);
 signal y : std_logic_vector(7 downto 0);
 signal EN : std_logic;
 
begin

UUT:Decoder_3_to_8 PORT MAP(
    I => I,
    Y => Y,
    EN => EN
);

process
begin
-- 00 110 101 110 000 011 111
 EN <= '1';
 I <= "111";
 wait for 100 ns;
 I <= "011";
 wait for 100 ns;
 I <= "000";
 wait for 100 ns;
 I <= "110";
 wait for 100 ns;
 I <= "101";
 wait for 100 ns;
 I <= "100";
 wait for 100 ns;
 I <= "010";
 wait for 100 ns;
 I <= "001";
 wait for 100 ns;
 
 EN <= '0';
 I <= "111";
 wait for 100 ns;
 I <= "011";
 wait for 100 ns;

end process;

end Behavioral;

