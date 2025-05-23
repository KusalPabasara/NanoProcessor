----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2025 02:04:21 AM
-- Design Name: 
-- Module Name: TB_MUX_2way_3bit - Behavioral
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

entity TB_MUX_2way_3bit is
--  Port ( );
end TB_MUX_2way_3bit;

architecture Behavioral of TB_MUX_2way_3bit is
component MUX_2way_3bit
Port ( A0 : in STD_LOGIC_VECTOR (2 downto 0);
       A1 : in STD_LOGIC_VECTOR (2 downto 0);
       JMP_FLAG : in STD_LOGIC;
       M2_3_out : out STD_LOGIC_VECTOR (2 downto 0));
end component;
signal A0 : STD_LOGIC_VECTOR (2 downto 0);
signal A1 : STD_LOGIC_VECTOR (2 downto 0);
signal JMP_FLAG : STD_LOGIC;
signal M2_3_out : STD_LOGIC_VECTOR (2 downto 0);

begin
UUT: MUX_2way_3bit
port map( A0 => A0,
          A1 => A1,
          JMP_FLAG => JMP_FLAG,
          M2_3_out => M2_3_out);
process
begin
    JMP_FLAG <= '0';
    A0 <= "000";
    A1 <= "001";

    wait for 100ns;
    JMP_FLAG <= '1';
    A0 <= "010";
    A1 <= "011";

    wait for 100ns;
    JMP_FLAG <= '0';
    A0 <= "100";
    A1 <= "101";

    wait for 100ns;
    JMP_FLAG <= '1';
    A0 <= "110";
    A1 <= "111";

    wait for 100ns;
    JMP_FLAG <= '0';
    
    wait for 100ns;    
    JMP_FLAG <= '1';
    A0 <= "000";
    A1 <= "001";

    wait for 100ns;
    JMP_FLAG <= '0';
    A0 <= "010";
    A1 <= "011";

    wait for 100ns;
    JMP_FLAG <= '1';
    A0 <= "100";
    A1 <= "101";

    wait for 100ns;
    JMP_FLAG <= '0';
    A0 <= "110";
    A1 <= "111";
    wait;
end process;
end Behavioral;

